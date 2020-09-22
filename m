Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C443C4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 16:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E4C22206
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 16:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y8IB/eAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E4C22206
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1172089DFA;
	Tue, 22 Sep 2020 16:12:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3958589DFA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 16:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glmm4JL/eTINjIzEBy5+cmu0AuXjOAiEqqHfiNvrVAfLTU/x2GGHqLkbcwQJmrKh8Hl5MPBH4uilXggf4z8RZkghUpDbdzj+kF5zfgkVXlLSBqX/qOidd4/0SAUzrnhw6MpcLEfgdiHIxJ+td3DxJc5DbuC7Bzh8N5WCesiCcj1N0dYxKeRmN/PEq9B3f7mKwUv4NvO804AISa4miBQ9olMPvC33UhVMZ4SX4ek1LbDmGpg2Jwk2hVRhBUlrxO2kvj7avN4VGdlGnt58Omvq5JMcCm/yt+FfA80vI0xJ/rZb+HKyf7g1OiLtLsjzDN3kq+JTxogso+CdIc6BvIKgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esudorAT88kWlzEEPzTPDip+0pt9AAzNWgK+GCw0Zds=;
 b=PTkYoV38IqW3n4z44AhB9J7SE2aJagao1muWqwaGEkxwwv3QJnzWGLovnKduuRUiLs6eQKPRJwiHbMRDZ7aaGBue2Ack+1X/LZQ7IXl2f2boIJVlsLeClEeaT4mDI0UDUD4qOBe3AdnkCLJWNQ6P+TqJJy3SvQaUG5j9a804PIHDQfEJYG4mLwlbQYicO1aRYaNuQWyD/w/H+48Za7K9a8/6RwBTge21ozO6WiiWgE1E8lYwtgd9Q0SHoRRPwjLim+emsTZP69MSPvgzsZuVhyyyoR3weP5Xa160rRnDfJFrBW79nsZ7LlLZlZ7QIx+hVUsWL9XnWGx219ucAEIChQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esudorAT88kWlzEEPzTPDip+0pt9AAzNWgK+GCw0Zds=;
 b=Y8IB/eAwLQoFkuE+IHcvvdjQgjr3XZvkcQdD5bG/E8J3oeOSy++awz0Bow0lRMik0Yz+9pVjeg6OqtTJ2/jw5VQaoj7TdrjiS5zJn28fS04VFgCyOhSsj7ec9AgWoFyYLWLOiNKLDE8/zlFftiyKRsiohrVLizRMpnche0n/GA0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB3708.namprd12.prod.outlook.com (2603:10b6:5:1c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 22 Sep
 2020 16:12:01 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::5c29:f133:1209:b74d%6]) with mapi id 15.20.3391.025; Tue, 22 Sep 2020
 16:12:01 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix CFLAGS setup for DCN30
To: amd-gfx@lists.freedesktop.org
References: <20200922153659.465095-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4b5927dd-9f2d-40f9-ef63-007cf7b65f37@amd.com>
Date: Tue, 22 Sep 2020 18:17:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200922153659.465095-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0131.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::36) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.127.106) by
 AM0PR06CA0131.eurprd06.prod.outlook.com (2603:10a6:208:ab::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 16:12:01 +0000
X-Originating-IP: [217.86.127.106]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44622f06-7f14-41cb-91c1-08d85f123d48
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708320DCF10580AF4474F608B3B0@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blNRytBDj+iAf8yMNUb30mjRiWmWU0w500Ryb3/jaOEPTIE5pApS/PVaqVDq+mjc02eR08+IZY8Tp97i7BLfZwYEK46e9tQD8CTmWZK9i0uUOlMFYKMmtbcIe/xzUQcBpYvCgFroxA0LZaepdDiU55AX0xJx8cH1jWV5aDmTVJTnVh3uSWQ0FY86vIQdmVbenyFBkuKlik8uLRKza1fjLxoFmCHZfGmqxD82R496FA7VI7MDDGElj1ydYL3NtcvOevtQ7r1+Pmr+Q9PE2FBFApavTV97qWT+uR6yizZpZGUZwLKYw3Ms4/5I3ylT3nq5ww4EuP+2bUmj84U+3TlYLr9zMAgF6/NII3AwXLObpAM0hHfB7ekEIQTFmB7Be94IBCI+UhipJzZG8RNbGJprutypNRpTZK2VBmF2BTcC67WPdu008yvd6jzlZ8J/myr+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(36756003)(6486002)(5660300002)(52116002)(478600001)(31686004)(31696002)(26005)(66476007)(2906002)(66946007)(66556008)(316002)(186003)(16526019)(53546011)(16576012)(2616005)(956004)(8676002)(6916009)(8936002)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jcui3zHXU3iHC2axDdUwXdgq1zuao1auqmTAneiKQw3S02qbW7UErihdHk/jGPupyHMag/xGlODaYLtVNnJcquPNNk2SCmyQSI/RQvbjcHGU/A3wQLUUXZGPDQ4UvjKTXyvLEX4r3d9WlV+i1tRSr/hmd/JNYF76ye5T6qthrvE4BJ2Nfv5c19kYniMIoJn+xx4oZBLHg4peH8quOtqPgGJZfrxu+BFaa8sQzudaoEyK2YcxKVsjt/XZDrwZDZ/oZeim0ux/IbU9GxXJkE8s/rVQrFL9wKB3LT2K1R0G9xy4cdgcAKhWXhrSbkIj80eUTtV/7VYHFpDNa90kRSeHAGuqUOz/VpKyu2j2Jxa248FUYqwcCjdBJfGLZbcUJNkFBu3b8ijTyFFf/IjieP85a5RHZ++6MtgUENyEyrKn7Q8U8cFE8fSgfRP4X83CQcqtoJjJAxvO6ui6z7lI0lQnMY3tujbSz5zi43yI/Ig8ANieE4uS1IgoTn8mKPVJuTNk28Yb+1fHagJP8MM1p79QrI9Getu/pQqXoFXISrkCT/dh5/n5GmSXbeLoqR/iuzRCzwrNVOyKlVjIL2FfH6rXlUG2hhW22nG1AhY0hUzZMfiA9sISbbrvOfq3OoPNmS/UJNG9BrUYRoZNhkHF7OHXLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44622f06-7f14-41cb-91c1-08d85f123d48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:12:01.7170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKSt/pF5Zmq5AIb13B/hjfD89w6saZ08KvSuqaMXyHyra2Ag85D3fkJLTWMwHlIpUgV359ocwXwYMqiVEQAPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 9/22/20 5:36 PM, Alex Deucher wrote:
> Properly handle clang and older versions of gcc.
>
> Fixes: e77165bf7b02a3 ("drm/amd/display: Add DCN3 blocks to Makefile")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn30/Makefile | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> index 025637a83c3b..bd2a068f9863 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
> @@ -31,9 +31,21 @@ DCN30 = dcn30_init.o dcn30_hubbub.o dcn30_hubp.o dcn30_dpp.o dcn30_optc.o \
>   	dcn30_dio_link_encoder.o dcn30_resource.o
>   
>   
> -CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -
> +ifdef CONFIG_X86
>   CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -msse
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -msse
> +endif
> +
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mhard-float -maltivec
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mhard-float -maltivec
> +endif
> +
> +ifdef CONFIG_ARM64
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o := -mgeneral-regs-only
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o := -mgeneral-regs-only
> +endif
> +
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
> @@ -45,8 +57,10 @@ ifdef IS_OLD_GCC
>   # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
>   # (8B stack alignment).
>   CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -mpreferred-stack-boundary=4
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -mpreferred-stack-boundary=4
>   else
>   CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_resource.o += -msse2
> +CFLAGS_$(AMDDALPATH)/dc/dcn30/dcn30_optc.o += -msse2
>   endif
>   
>   AMD_DAL_DCN30 = $(addprefix $(AMDDALPATH)/dc/dcn30/,$(DCN30))
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
