Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA96EC3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABED0206F6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3oHQduJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABED0206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6799D6E5C8;
	Mon, 20 Apr 2020 15:29:54 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357EA6E5C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:29:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENOQ7j6MBgqd8btZxCaZLy1hQN6zW9UmXGlGWue7ZoZgP6mMXDn4005uKHiGnqyw9PW0hh06CgM/qJj9DPVn8f1/DX8UlV10cmsoku2FgGjvco72Fdmje4Pj7bDN8+HUnn/MfpzEjb/xznm+0Oso5ii9/vpF91FVhG3W37jTQ8cr62MV0Id1lyO3nj17SWUInfPJETWdYjiI7ZwxXkOx6TEKTAY6mhRIRFOl6zsmRSdF0uAJKSLM2DiG08FMhMoyllUovx9Bd2I4llqoKUI4v3uso9a48HWGZX2OVZOSddBKjTqR64fxXAw884gu0/yIlSuXunPvfErh9KKX/y8jVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeCJgECoJczFCxAfvpi2ZDvkU5Gja4ae8Ux3gEKHpcE=;
 b=Uizsj+V+fAWNShjAVyO+FS6eedCzjuw26TvUmumd/w6NbOgShJuTMdn9B2xDyA5fuZ6kdiGHjvREpC8D/RuUIunra28XOLfARkDGfJPk/WjJaAtrms4EN2qDJzhm0HOOQ1y83ylhdk9+1zb6g4CRqFt7AWiSQwijDA/Ghngbh1P1eAUNq2d+C8uT5/LwMvPp8wzaoKm9AtWFyegvloIvexgScjb4Gu36UcHJc8b96P+79rFu9/3VKMCmq77XrKG/Gd1793LZLSzJbtntE8na2/7Q5x3y9IQq+0oxK4VzBmNdEn453o18/0NN76ZhfgWFArKDwHim0YmvBHsBYClqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeCJgECoJczFCxAfvpi2ZDvkU5Gja4ae8Ux3gEKHpcE=;
 b=3oHQduJhy47LPa1jMgsR3K6ubYdw/lEB1CCX2aB0moQZkt+W+fs8HxLJQHpvy4lF3WuhvuJSBzspHYMSzhJhL3aN3wxeTuD2x/SFhjJO5HKAshDClzqT7S2oXxFk6vWb9+wqOI+7/gEc5t8s4POOhr8XVITHnG4aWoJviKxxbUM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:29:51 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:29:51 +0000
Subject: Re: [PATCH 4/8] drm/amdgpu: add helper function to init asd ucode
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
 <1587377804-3836-5-git-send-email-Hawking.Zhang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <00df5041-e8b8-9662-dc42-17d0b1c1f44e@amd.com>
Date: Mon, 20 Apr 2020 11:29:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1587377804-3836-5-git-send-email-Hawking.Zhang@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN8PR12CA0029.namprd12.prod.outlook.com
 (2603:10b6:408:60::42) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN8PR12CA0029.namprd12.prod.outlook.com (2603:10b6:408:60::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26 via Frontend Transport; Mon, 20 Apr 2020 15:29:50 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a29840d5-1994-46b0-6565-08d7e53fab26
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:|DM6PR12MB3148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31485DE276ABB582B02FB85199D40@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(5660300002)(316002)(2616005)(31686004)(186003)(44832011)(16526019)(956004)(110136005)(2906002)(8676002)(6486002)(26005)(81156014)(478600001)(6636002)(36756003)(6512007)(52116002)(53546011)(6506007)(86362001)(66556008)(66476007)(66946007)(8936002)(31696002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6oUgr0S1G02ak5RLsk4rFdZu95rOxIesrVYCxaHGivd6Kq8Ugh+Y6hkA/vy+YAQlN/lCsEccILVLixnGbIHO8WLUOK8pTV3vfo7AmIkEyQpacGkJCQ8QpLZUDT7LNAdoDJP1ZtSy9tA5L3noIPkxJpTcfKEvMBpe+b/hcmRWYykhElFvngBgP9VzUSbiZDqmVsyn3pf6adv3R+saYz8VdOr6iERC1LbcbibRC6M6KDmIjOO9DtbyqfKoQkHfQfyJpavV1AAOfiAFjhP/KjliLl/YlYqYPKeBYambhncyXPt90h7eDuDI3ODjVyEB/EVWup8nN/JtwlzZ8wVZsbcy4GlfgB7J8WQ2bfUUNdbBo3xJhUNLTQmMyfJ4axQX8PeGDZ5tTWo+0SPy3RPnJetTwgB1k6mz4FqQSSFVvJtS37TkVCHYzI7684sBpjAfZ+b
X-MS-Exchange-AntiSpam-MessageData: UB7kxzww1ThkDAc2hnolMNQ56E2dUhlL2VttOMEYaugNiAb4zEjBid1tmM2D+gJpEA1TUb84Xg9bYRvVDx0qH27wUdniU1VPDTJU1S+rUKNgi3pdugDSnwbWUVFSe5d16LSuNwi8DQjcwyU/q1yfBlEisw/YlEced7JLVZ17v62Y7RH0xIqR2rTOSoLep/HCixdPkapxHlemeirHN5PnOmyhhV8yRA01yFgaOhlrXbQ2Ep1Uecixz/kPSfCbbpaIRMPMYfzkq1ZUVDA0b99wzmoKVRLaF2cgDviKTiF4Xx7h28Zsg7pccq3P+Ebi+bgsO1FpqPaRv4KmColKsyubV+a53qTcRmQUZ7W9Be/0BTnZkPsTUTMEwGnxGFOQIc6k2PpCKyDyUWWHeWwa2hF2ywaOwdjPrIxFSBvkOCWwc42hQiP4rcVdyRN4QeseNUvnNhJZ/PDCNFdok33tx9gB15bhZu+vs5D35T1TrAob8bB8eVU6NBXWZ6OJHroOkC08mz9q09j8TqE0Og+0nxvSk1S11rRsIkSDxUeYKh+PFs4oPeHZanylsLWNMg8WwT1BOLgokyNt30GIEKhnOUav6v9bxY+ROLQ1F4ZS/Tij0psXQbwicL/O3/+G1FdEO7sXQ0SCriyIzLSe0knEwJ7BiwZtTuDsz2zenIvlUTgCDGOu4sDJwZdUDYO/7mt/lNnRrd4IEylZirnyE3jXt7R/9Em1guF3ordP3VQT4JGZIs0AKvmZMIUr236vHjU5NJgpPQ2OVzaYU+PJB2E27/Snpbny5/e5Nv7uIB8oYwcjlYw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29840d5-1994-46b0-6565-08d7e53fab26
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:29:51.4944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KYKhgeyjCMxC41oVD0he4+BkuHbr6j4219drkEa8v+vLzGA690fySVgTa1s/1c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-20 6:16 a.m., Hawking Zhang wrote:
> asd is unified ucode across asic. it is not necessary
> to keep its software structure to be ip specific one

Sentences usually start with a capital letter.
"ASD is unified uCode across ASICs."
The second sentence uses "it" twice and it is not clear
whose software structure?
ip --> IP and the sentence should end with a period.

> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 7797065..3656068 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1840,6 +1840,42 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  	return 0;
>  }
>  
> +int psp_init_asd_microcode(struct psp_context *psp,
> +			   const char *chip_name)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	char fw_name[30];

I'm not sure that that length is going to be enough in all contingencies.
/lib/firmware and /usr/lib/firmware are indeed the same inode (hard link),
but if/when using /usr/lib/firmware as opposed to /lib/firmware, some names
for ASD firmware are at 40 or more characters:

$for F in /usr/lib/firmware/amdgpu/*asd*; do LL=`echo $F | wc -c`; echo $LL : $F ; done
42 : /usr/lib/firmware/amdgpu/arcturus_asd.bin
40 : /usr/lib/firmware/amdgpu/navi10_asd.bin
40 : /usr/lib/firmware/amdgpu/navi12_asd.bin
40 : /usr/lib/firmware/amdgpu/navi14_asd.bin
41 : /usr/lib/firmware/amdgpu/picasso_asd.bin
40 : /usr/lib/firmware/amdgpu/raven2_asd.bin
39 : /usr/lib/firmware/amdgpu/raven_asd.bin
40 : /usr/lib/firmware/amdgpu/renoir_asd.bin
40 : /usr/lib/firmware/amdgpu/vega10_asd.bin
40 : /usr/lib/firmware/amdgpu/vega12_asd.bin
40 : /usr/lib/firmware/amdgpu/vega20_asd.bin

And when using /lib/firmware, the above line lengths are less by 4 characters,
which leaves it too close for comfort given that ASIC names could vary.

So, I'd rather see the size of the path name be something larger,
say 50, or more.

> +	const struct psp_firmware_header_v1_0 *asd_hdr;
> +	int err = 0;
> +
> +	if (!chip_name) {
> +		dev_err(adev->dev, "invalid chip name for asd microcode\n");

Here, "chip_name" is not "invalid"--it's NULL. The message
printed in the kernel logs should be more clear:

"No chip name given for ASD microcode."

> +		return -EINVAL;
> +	}
> +
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);
> +	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
> +	if (err)
> +		goto out;
> +
> +	err = amdgpu_ucode_validate(adev->psp.asd_fw);
> +	if (err)
> +		goto out;
> +
> +	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
> +	adev->psp.asd_fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
> +	adev->psp.asd_feature_version = le32_to_cpu(asd_hdr->ucode_feature_version);
> +	adev->psp.asd_ucode_size = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
> +	adev->psp.asd_start_addr = (uint8_t *)asd_hdr +
> +				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
> +	return 0;
> +out:
> +	dev_err(adev->dev, "fail to initialize asd microcode\n");

This message is vague, in both counts: load and validate.
The rest of the driver prints something like "failed to load %s firmware", fw_name,
which is more descriptive an_ it shows the file which failed to be loaded
or validated (giving the user a visual check of the name).

For instance, see gfx_v10_0.v at the bottom of "..._init_microcode()" function.

Print something like,

	dev_err(adev->dev, "psp: Failed to load firmware \"%s\"\n", fw_name);

Regards,
Luben

> +	release_firmware(adev->psp.asd_fw);
> +	adev->psp.asd_fw = NULL;
> +	return err;
> +}
> +
>  static int psp_set_clockgating_state(void *handle,
>  				     enum amd_clockgating_state state)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index f8b1f03..a763148 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -385,4 +385,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  			uint64_t cmd_buf_mc_addr,
>  			uint64_t fence_mc_addr,
>  			int index);
> +int psp_init_asd_microcode(struct psp_context *psp,
> +			   const char *chip_name);
>  #endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
