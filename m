Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F320C47409
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 17:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1DF246D7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BWTC50E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1DF246D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3E36EE41;
	Thu, 16 Jan 2020 17:27:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0F5B6EE40
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 17:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EoRfkOFVSLlS66wAVlff0eSXfqqIBvo3fBdyP08SwPsB+wqsjW6NsRKuuZ4hkD3ddqP9GPHxrhRpZijy3e33xQVZdNopDiNuFUP9lEt6JTdhptofP6NVag9INb2lKZurKsHERliZy06CJ5gLcGH2pM8J/rMy+WVMblQhY0uBak1tilXzHItgsl0VP04hZTf4AH5LUr4xwvNJK5Zqicd/iaGjjxcXHwutSkArNA+WV2BQe308NfaURgj1gi8WJPZg1o3fB3IDiWtCeoCZBDHHRvWQb6e1q9KWxfyEAmKhkFPtLmrrPpvYwaAoBr9AjkIGUGVUnq9DmMiomBQJhx3RfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76QJ+zxfZ6tHsB+S/wFPdh6aWFvV7VelORxIXDeFFIY=;
 b=ZLmcZnZNanVv2U5KMbJgZ3teIqzVRmUdxGyxQLZUVBALnD9NvTBDvnuHJZq0kkiq3VhQyczNKAC9mr0n/yG6BhHVQvl63h+6ZNkEVt9A6WYAAg/piPi7sSEQ/YNmkuC1wSZaod0oYQr9a/vgUBasQiVX4T92YU/dxnsFLt/6TkYfh3ydBBsfRx/CDsWOS7jxU2hIn+QOVJOwjD0dTQg5W7kBuoisDUnH90Hr8DO6Diw5f1GvuBMV643Tx5knTXjyVhMNx9jQpyApIUwkfFryb/vdN0uueNVEvxh++vOCN5TlYbsD2BKOkLnRhJbk5+qJSqQSn5WUd5INB4gPGb/JlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76QJ+zxfZ6tHsB+S/wFPdh6aWFvV7VelORxIXDeFFIY=;
 b=BWTC50E23uekz6J4LWOs6ikcjKWo/0TZiwopCaLnhQvJu5BnpdYqzqeD8zMeLax5hCr8t1uaLSiv3OSHJKNefUsZZqgtQKh9iW6C2Sy/j8H/1M5XGOgNqFAMa/XMHF3UeqeVCQA0wuQEWAzDI/KWPLJpCFUfm2vbK3Cc1w2ifKw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3772.namprd12.prod.outlook.com (10.255.172.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Thu, 16 Jan 2020 17:27:15 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2623.015; Thu, 16 Jan 2020
 17:27:15 +0000
Subject: Re: [PATCH] drm/amdgpu: attempt to enable gfxoff on more raven1 boards
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200115173139.1392429-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <122fd08d-2881-f45a-183a-9190db93192d@amd.com>
Date: Thu, 16 Jan 2020 12:27:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200115173139.1392429-1-alexander.deucher@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
Received: from [192.168.1.2] (108.162.131.176) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Thu, 16 Jan 2020 17:27:15 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba8c2097-9fde-4aed-4837-08d79aa95463
X-MS-TrafficTypeDiagnostic: DM6PR12MB3772:|DM6PR12MB3772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB377298DE87A1F387F03DAD5799360@DM6PR12MB3772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(199004)(189003)(66946007)(478600001)(2616005)(956004)(966005)(36756003)(26005)(186003)(4326008)(55236004)(16526019)(66556008)(66476007)(53546011)(5660300002)(2906002)(31686004)(8676002)(52116002)(16576012)(31696002)(86362001)(45080400002)(6486002)(44832011)(81156014)(81166006)(316002)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3772;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yRaNeONbAY/wgnj8tET3NKKcyYAhzRNl+V/R+K3FJIiOHstP+vErPYJgxPQ1SlUklLr34Z2OB1wVFEKbD86tp2YBOLW4pQXZrCkFmLaorzYNdbBFeZeiDBB64DLQH/7W845hDMBftKMk0jnK3akBWnIoNEcrmvtgR/WPGiJ1+i4TbAOj9Llpqzs1+VuBiLL0/tBB4N9FmU8CsSFRZSsITd7OVEOgQgMoQ9gHKMBSg2dNgMXQYCl7YBUo9TWKzGdlc9lUGHONjpNbQAwzPoJg9w+rUVXMALDCUpNUgH/2VHZ1jHoLjVq8V5xLty8tsaYLB78k8i+7sbAP16lq2jUJeCN/nJuiiA0/ZS0W/BdlUNaeCdfPEI8pxFzAFQknid+/GxggAQjPqFaK637Pmf5Ppl8wvLkbsxtns8HSayHWM3Jg5pqyX9muwlnOXMwK2EYeVs8ow/Vd3qkqiqrgUzzHyYrxWmz8OADGCGk5iiiZEQf0+J7aqQfriSYw+6GMx2n5fYoPsip9mXUrlm8ips3CQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8c2097-9fde-4aed-4837-08d79aa95463
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 17:27:15.4836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmNy1rzlpjEBJMSIEWLqqubSS21ChWwkscQhJwOSMOQLszNfJ+pn9St98f+I1/vB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3772
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-15 12:31, Alex Deucher wrote:
> Switch to a blacklist so we can disable specific boards
> that are problematic.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 42 ++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index e3d466bd5c4e..b48b07bcd0fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1031,6 +1031,37 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
>  	}
>  }
>  
> +struct amdgpu_gfxoff_quirk {
> +	u16 chip_vendor;
> +	u16 chip_device;
> +	u16 subsys_vendor;
> +	u16 subsys_device;
> +	u8 revision;
> +};
> +
> +static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
> +	/* https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D204689&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C683669e5a2c74bcbbc9108d799e0cda4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637147063903364365&amp;sdata=UL9SCKI7OchzK6a27AxkjrpeLNw%2BWH5DmpWGKutCI4A%3D&amp;reserved=0 */
> +	{ 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc8 },
> +	{ 0, 0, 0, 0, 0 },
> +};
> +
> +static bool gfx_v9_0_raven_check_disable_gfxoff(struct pci_dev *pdev)
> +{
> +	const struct amdgpu_gfxoff_quirk *p = amdgpu_gfxoff_quirk_list;
> +
> +	while (p && p->chip_device != 0) {

Maybe a "for" loop would make it compact?

for ( ; p && p->chip_device != 0; p++) {
	if (pdev->vendor == p->chip_vendor &&
	    pdev->device == p->chip_device &&
	    pdev->subsystem_vendor == p->subsys_vendor &&
	    pdev->subsystem_device == p->subsys_device &&
	    pdev->revision == p->revision) {
		return true;
	}
}

I wonder if the structure "amdgpu_gfxoff_quirk" which stores
device ID information can be named something more generic, (struct device_id?)
and also used in "pdev"? (Reuse the struct.)

Then we'd only compare structs:

for ( ; p && p->chip_device != 0; p++) {
	if (pdev->dev_id == *p)
		return true;
}

Regards,
Luben

> +		if (pdev->vendor == p->chip_vendor &&
> +		    pdev->device == p->chip_device &&
> +		    pdev->subsystem_vendor == p->subsys_vendor &&
> +		    pdev->subsystem_device == p->subsys_device &&
> +		    pdev->revision == p->revision) {
> +			return true;
> +		}
> +		++p;
> +	}
> +	return false;
> +}
> +
>  static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  {
>  	switch (adev->asic_type) {
> @@ -1039,10 +1070,13 @@ static void gfx_v9_0_check_if_need_gfxoff(struct amdgpu_device *adev)
>  	case CHIP_VEGA20:
>  		break;
>  	case CHIP_RAVEN:
> -		if (!(adev->rev_id >= 0x8 ||
> -		      adev->pdev->device == 0x15d8) &&
> -		    (adev->pm.fw_version < 0x41e2b || /* not raven1 fresh */
> -		     !adev->gfx.rlc.is_rlc_v2_1)) /* without rlc save restore ucodes */
> +		if (!(adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8) &&
> +		    ((adev->gfx.rlc_fw_version != 106 &&
> +		      adev->gfx.rlc_fw_version < 531) ||
> +		     (adev->gfx.rlc_fw_version == 53815) ||
> +		     (adev->gfx.rlc_feature_version < 1) ||
> +		     !adev->gfx.rlc.is_rlc_v2_1) &&
> +		    !gfx_v9_0_raven_check_disable_gfxoff(adev->pdev))
>  			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
>  
>  		if (adev->pm.pp_feature & PP_GFXOFF_MASK)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
