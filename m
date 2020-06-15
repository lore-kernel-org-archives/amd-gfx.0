Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C69C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3048206F1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 20:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y8wD4bhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3048206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B276E4FB;
	Mon, 15 Jun 2020 20:27:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE93B6E4FB
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 20:27:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYBXMKnx95T1gqABuN1BbyPyTJNcdmfBDCCzZyyWZiHP0rkpsbOFBWX8hbD9L+IfXK/a3iBrhxKpPaqC28ssWDice6iL1cQrH7XdyDEqzqyIYm2DfO2YnQ0vJYpM+Eil69rmbe5oyBzzKsiT7diRlh9E3uWH387WeshX+FxuSgDIeAYPm4Hd4mhYwwMALzG5VYruhLHNnOJt4aKH+PGWrHT1ZmMP6Sn/xSgHrOh+MyQIdCbrtsFEQj4kY+gpLmuDJa9VOOMRW7ksC5l990b0ohaLlu6GtxoJo7edDEaKG/0QCvB3l0MA+hdoAfFwvhuDpVOZgDmpMEfQkrMgB+DJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiEJIDJWenyXOXrKkFT/rQ0ISXUanLUILejlSYOM3EQ=;
 b=J38oAZ9rbM/tTG4NPxGObx3SxpSrqS7scVy/r7HpPi7UEZX9ylUHgoauUrrtdW1l+B0Yv0WUbn9BUazYtnxLIqQENAyG1YvNx5xO4Ow5US0Sh/K5Kik4gYKSR0mB82b0CCRszp6H9t/TQLK2iygxipa0NG7+E24tBhm/YJ6pqhjvvOwrutD+l/D7GSfL7k966WOMHPQCfBtQHejJlm0FiX6KhL4yuTFMnINWIZTKiAc9ZVstsdUlJfn0l8Ng056Ed3Us9l9vfiY5G3ssD1DUwXTQgrN40qMpfBdMiU2p/sRVjfnrm+nGAMefKlwMDTcbBeMeHnfLJO/oqc0EILXKZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiEJIDJWenyXOXrKkFT/rQ0ISXUanLUILejlSYOM3EQ=;
 b=Y8wD4bhiG1MqUidM7t5IjSx+xCV9JuABN+xhhTwJ+OCfajXoGn4G5kyuqBQYMAeuAZ5dRJcvdcKGV10qOofk8FuvkfVETuRMQI2Tm4Yk9eewimc05K25qR4zVyToMupkqCiDc50bAaV8QEC5GqWEGjKsPow4snwlhapXhqWtXYc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3712.namprd12.prod.outlook.com (2603:10b6:208:164::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 20:27:26 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 20:27:26 +0000
Subject: Re: [PATCH] drm/amdgpu/pm: update comment to clarify Overdrive
 interfaces
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200615202535.2455665-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1b181f3e-bd58-d22a-b869-74629f51adbe@amd.com>
Date: Mon, 15 Jun 2020 22:28:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200615202535.2455665-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: BN6PR14CA0014.namprd14.prod.outlook.com
 (2603:10b6:404:79::24) To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.7.143] (165.204.84.11) by
 BN6PR14CA0014.namprd14.prod.outlook.com (2603:10b6:404:79::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.19 via Frontend Transport; Mon, 15 Jun 2020 20:27:25 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cf81713-23b8-4b80-881f-08d8116a84cb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB37120D67A14FAAEB8011A5C18B9C0@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOLe9thVbPtwMg5cCcI2rXZK/3FlOYTZGkQ5uGLleF7BlkJTQyPYw5sh2krCopZGGsD2oBfw8mTKxNiXiBPE92aQC33ugoZhN5zd3nPL8HtzOITJZH74cGivfmslNuHUdBVB49yaYepLmSiQMRpYrBSGEjGDkOhYH7YV6o8TFAOqnoyCk4kzj1ddhyOf1fKaQfvSrpFTa48nEI2s/8o36kE1ZNl8IXVUcg15io62x2if1P9Ow1hdNzkzPt3r8fn+yF5Vk4PWmUuokcQTiaTnhiDr4Ga74FH3aty1hni+4SzRIe+u5A4GPDXRYQ8t9kM6krrJzbvMp5Nwv8rJixaTvMqNUVmHDfIGOYYP7cH+tSPj6ttmCOhlQkXpi/xll4k0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(66946007)(2616005)(66556008)(83380400001)(66476007)(16576012)(316002)(31696002)(16526019)(26005)(6666004)(36756003)(956004)(52116002)(186003)(53546011)(5660300002)(2906002)(4744005)(31686004)(8676002)(4326008)(8936002)(6486002)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oL54PJuCWYpCBPUVkPWyUt8AGlj4f87YNGxqYcyo/GRJU1KqkH005YbvSKsTWxVUVqz92yr1az5CF9L+fql4OXUTg8zB7pAz4QdmysqgdP/XS5ciW2Hu9fb7gjGAjO5jIbeoylUI8AZ6HSf8g4asHrMfcO5c4S+jFZvEewrxbUgFs9Thb4aITRMYF0WTcinDQ83+pPtbEa3gBsVq+hjFIViUFKqduXL+HhDM1Q0P5h4N4J9vk/iIJDU8RZpGUjaUCiAOL6cPEogaB7ZzLhdV8r8ltwxHuWO0YyN5sLVDGoOlxcwAzK+SwYKM6ARKEoqNvZbrJ6ul1hzi/4+5avBdRBhn8PHM9Pnkb9hnjPhY9rNb9WY2eLA2H2uo9eUIYw8AFVtQoy2GP+Nlu3TNZ2zyBqphWVoHZ2imOuPfZM2yYxzAh4c0ipy1WuM93Ad3zsqbKbsNAe9JkOXo7ulc+ZU70s1fa4QvxWNXY2MESrNy+ag=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf81713-23b8-4b80-881f-08d8116a84cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 20:27:26.7390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0fSillsTfkDbzRyck9PznOPxnhAOdq7O3m7f49vJiaghtjNAUB+bBYzieDom8BfmBjaM1DrwQlgXF8IObXjZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/15/20 10:25 PM, Alex Deucher wrote:
> Vega10 and previous asics use one interface, vega20 and newer
> use another.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 395ddbe2461c..5a8e177e4f56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -696,7 +696,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>    * default power levels, write "r" (reset) to the file to reset them.
>    *
>    *
> - * < For Vega20 >
> + * < For Vega20 and newer ASICs >
>    *
>    * Reading the file will display:
>    *
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
