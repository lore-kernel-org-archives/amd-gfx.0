Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC2BC4742C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 14:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA098206C0
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 14:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jIrmAh5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA098206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46C3089B5F;
	Tue, 10 Nov 2020 14:27:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2E1F89B5F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 14:27:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEMBHiF/49pyuMmcVHrQIScQ84GN3e3ep4K3FhinACs6m7ZjB6ctabwaB4xh5YCud0ChR68EbYppS4rdCOasxJSbVnMWkhuyE++sniPQTzuoSAjoske0hZWtuhrwmSNRZFgB0QxDx/h2sKnvuHgzHMMf5RHKviihV27jGEovL7/JUSTdcwi10dcnF4yXBSqiPmhivx6JU1f9LEIw0PLGTVzOhP9VccjDiSgccTBYrEVFJsvPEkmjTiOyqXFvqmnTUC40damnamJDOx9wPv09v4YLRKofzSlbI9MPcEe8hE039LJGrtyRsCGeCO0rnUZ51CbqA6ELTJHfx2/lO6ZdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C0t9r2B47V3lwaL1x9KM0b7YLVDFCePmJMyFNrcZnU=;
 b=LzOqR9FTLrEg5h1+jPnon4JZEDaxuSBTITdO9EQVdzRQWXXuddRU9wUOPRD0qDdV/Q5j1U8FhkqyT3shhxEwgBGyOVf240ZPswKLUOTNKHujYMko5obUa/nztKCumTcEEAHvj4o/erRlXJRFUrKKFp5hSHV/2rD/aRLoaBRwAB4x2NjmSTYjV9Rgr+fc0bjim3BbPEOPNVOtkamyXXBxoCObEVawMFk1FWSDyrepQrbTCbnN2FROTgWtluxbEU/wJmaB3R3wCa0MBTgmv9omQxXxnV0GopJD2Ve/Hp5dHZc5nbVQQFoBzKLxIPj1SPzjEYk5IHOl5C/aWrNo6mKsIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8C0t9r2B47V3lwaL1x9KM0b7YLVDFCePmJMyFNrcZnU=;
 b=jIrmAh5x3n6E06m57YcUmj0bWk+TvZuhX23oGrrd76jLn6U0twH8gXLeNHK8trbBAG6ZVixwkqMDuVNAKn983d9z4AG1XtHL9WD4KAwjYrLBF4v9gs0AfxllK5P7nMlXfr7h12nrBUeGUutoDCftDe/yZbvPj4esDCuDhT3tzwc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4587.namprd12.prod.outlook.com (2603:10b6:303:5d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 14:27:30 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::95e:3860:8b43:1a35%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:27:29 +0000
Subject: Re: [PATCH] drm/amd/display: Fix memory leaks in S3 resume
To: Stylon Wang <stylon.wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201110074912.54097-1-stylon.wang@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <df99166b-de59-5aad-f921-b4263c082ca8@amd.com>
Date: Tue, 10 Nov 2020 09:27:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201110074912.54097-1-stylon.wang@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d231d55-d279-49e0-44c7-08d88584c122
X-MS-TrafficTypeDiagnostic: MW3PR12MB4587:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45874754BAEA169A04F56E7D8CE90@MW3PR12MB4587.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB7OjUfM3HoqXuLnQSazq/0MHD10tM5IBDOGgUs0dNoVeXBk5mCfl/Y7LZ5f4rERsUfW40I+ubi3JCcOKkPP/ap9bgsumAjt4ToByv8fxjCmay+I5vkn5Gyyi7NwDyK36asT9qH8K801JRUg6ctEkwwc8gc8fc62Nn7xAPTMIaAgOQKtxr+BQJva742F00jIdRtdIlqXZN2l2j4aXmv6Z/D6f10R3V10kG9UqudfdZHrS8GodLwc5AZDK4hwbveeMTs1TgHGeaQBPd5BsLd/L4GAdju6Yx9eUpflVtveARHobpCw3k+vxpeWqu9sgfwH3wGePgCVcCol/y+evBZl4OYcGUiAVdSiaH8wLdf4QmaYoZiLL5NPx3+q7oPUB5FX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(8676002)(8936002)(5660300002)(36756003)(31686004)(2906002)(31696002)(6486002)(83380400001)(66476007)(66556008)(66946007)(86362001)(52116002)(316002)(16576012)(4001150100001)(4326008)(478600001)(956004)(44832011)(26005)(53546011)(2616005)(186003)(16526019)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8ZeeUzSY4c05pIUR7RB2q2nug3Yg6CJHIyu34ape5oOcul6nVxlGIaPieHZyIqJkKMoM6M59p+Q2B/xI+Sovei6D7fW6MZG7yHDVcyB2FCxLDQZyZQZp8zjbu42skr9cIOHD1J4B6CezbH0rEGwaoGcMwL4NFwM5IS0qQ1sqxyWLDMb8G1DsgXBENqVJmCDJkcct3GObM3wXSoFr1L2gawkTPrPSUiRdcf17DK0rlDkoqT4860kxoamy3kofgkSpnCGiWCRpnJzHFIGZaUK/AjbdlU0+Hn9NdCd+20zijNLbGAqqxKan3QGuGIN5c22Ae0rWHRzuQDYtXKibHoO5xLOt8KHavmaaT3MDeXykdbBVquun9Nd3Uj3gG7tNf2K9YgARLfZ3h/YKMARbdpp8i1LG1v4XDYXE5FWKAXbZANjdoJzDsIgt1SW421OBjf5B9hGr9LrNdsthi84LcyZfY15mf8D4iRj8uMc8AjMbPnpsIaYQ8oAm7/QdXM6wg+3BzTFixK1fpXj5Xr3SKx4jzSjJaALItJ41vKnJADJlTmr7V2Q0NyHyiNzh3mhQ0ImeOGs/XxscdUaIfhS1YA1u5nJ+mtk1OIHAO4rnsOZJvfGD3wVKe0uRetvIczvUnRKUOZ6OHA6YIHN3gkWccvtkww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d231d55-d279-49e0-44c7-08d88584c122
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:27:29.7889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XV6qgrUhwzdoV/sOWR6QSICv+TcXyrxWec9JQ8T0+vtjl0FH4I276Ims2kqtSoQRLMtm6Flhpb1ttZ7Tb7c61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4587
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alexander.Deucher@amd.com, Nicholas.Kazlauskas@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-10 2:49 a.m., Stylon Wang wrote:
> EDID parsing in S3 resume pushes new display modes
> to probed_modes list but doesn't consolidate to actual
> mode list. This creates a race condition when
> amdgpu_dm_connector_ddc_get_modes() re-initializes the
> list head without walking the list and results in  memory leak.
> 
> Signed-off-by: Stylon Wang <stylon.wang@amd.com>

Looks reasonable to me but haven't had a chance to understand whether 
this is the best solution.

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0b6adf23d316..715e0bd489f8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2337,7 +2337,8 @@ void amdgpu_dm_update_connector_after_detect(
>   
>   			drm_connector_update_edid_property(connector,
>   							   aconnector->edid);
> -			drm_add_edid_modes(connector, aconnector->edid);
> +			aconnector->num_modes = drm_add_edid_modes(connector, aconnector->edid);
> +			drm_connector_list_update(connector);
>   
>   			if (aconnector->dc_link->aux_mode)
>   				drm_dp_cec_set_edid(&aconnector->dm_dp_aux.aux,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
