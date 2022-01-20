Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0F8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 06:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF53110E1A2;
	Thu, 20 Jan 2022 06:44:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8229210E123
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 06:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUI1yKin+0uIRKMTza6LKTTo0NpNOkXw5s3EOnrCqgsIg2thpGddLnmnaGU0PBqe4M5Kp2Vx9aBgaWCRbQqWwVr5Gp1bIQaNb+VCyIfKFyYFPCktxV3+xj3OzogyKsa6+8FpImyoZi/tkZiNlpIFh4Yc92jWF2qBgLyFv50akayVRG8PSw0IzEUAYrZP1ZqDx7nOSyRyFkS5xv/HOP4o/WXtaJte11yLHRwmX/fM+Ok7gdPyRB6bprJguZ6+D/iBOjQwXP3mzJZ6VTn8Spwsk2H/SsmtC94KEiIxHO0e1X4EFWOxYIdwYHykYunekn/9aFXSVM1emwuh28XPZaWz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3WXFr3KwSdhHTo3+fgT/WVGHqw0+j8BBdKwdx+CxUc=;
 b=G/8DGGo92IewhVSXFPU94xLn2TzYVXCmNBM6T80TM2Ke72IPLsKUc9jBG5/vLiJ7V0kTakvvZcPdDBAZr3Titcu1XzmPvZnaqBxY48x66n5iFtCrGILXoH9VvXpuyBbWafRUl57VymaMqRvyzooKjcvi1bz3nBclwADPpovRW9Qa9fyZyJrxWB/QBfKH2YcGRpiiLs7l1zAr6QnQgPyHGLsRbqmCLBhDzApBu5YMcN3Q9Cd6tMFDxEWlllJNc9q0YL6NRkdLyuIyPz8S6uW3dnxwleQzyvpZucdBP/Y96iVBCWiJ0ULUF4gMZoUubN8tyWH0Kwl/urF0X2uV2Cyshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3WXFr3KwSdhHTo3+fgT/WVGHqw0+j8BBdKwdx+CxUc=;
 b=vbX3EuW8VrLEVpN1eXh4CTV7+cge7rVB0fTbDaS1cjhZuc1WaQFyGomVt9cFd/QcAw/X8+YmTVCOGTvaaL6Bhyac6oy0zE822dtV6P34qguzXzWo2PNMBHwQ61ABSgu2epxjH2CiYXN413apvWSNS3+TvBZtuOb3EUkt5HjxiGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 06:44:35 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Thu, 20 Jan 2022
 06:44:35 +0000
Message-ID: <945bd9ce-629e-db6b-815f-291fee1b3452@amd.com>
Date: Thu, 20 Jan 2022 12:14:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd: Fix MSB of SMU version printing
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220119030456.12493-1-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220119030456.12493-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::13) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d54bf44-d51c-4737-df83-08d9dbe05209
X-MS-TrafficTypeDiagnostic: DM6PR12MB2748:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2748732DEB7C012BCD8648B0975A9@DM6PR12MB2748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nRv/vc9bqIFW/F7z0yjzy7L48GxxTVgeQkRujkUBhqc0c98xKPcMKN2KdSKIPY2LhOmA087qEcKXq3eSR7+FlodUcMKUMiiLnfprpRPpfLwsFz0xWfXs574MaNXKIWcVW37J9/ySp4tN9ppJdt/tSQO0BloNPUM66GetXDl09YdmJy26SAOSGoG9xXvWOOc2XFdpGwLSVeecFur9q0lI1CX7DOoK0FngJpfQa5+72KMFjeS6tU9VqVs/UPxqpAx32iFqci8gJaD2wCsrahaNRXp0S52IcqawbPSfN/SzH0o6Z6DV+xkchF1hmqq1LHAfXe5F6FMTI15yf/kkDacFGim/MGoOZS0S95g1YyIkBGR9JRnfs2oZt/xR65N7OmaE8i0Mj6tIjsGH8wi7eot0bIrQyzXTV1kktikcmgNFri9vTQX6TuAb5diHKxnSQ4wBJKXlEPDLRJEEtnpQaoJzYrDrS37NsdFJ/aFwd1+e1b9iPkzvxV7Bp4TkTwxwfFgPdFG1fV3+t5cGv5fqo9cuWJuIMIKIULgMmLWpUl5istpAbkFpgc9SiQFJD41Tlzr7l2J/qka/ps9+Pwxm5DWXjdw4J2fcSodhKR4RRSPUucsPOEVxN1n5hYt51Kex8VOD54YAhVl4Jvqc0QZANYVDRbkFvQ+Ko7Ge5ta0UlXlcOc/spz4Aw3c0SRbpisn7+D1yCAOf3z8nkkHPqbobNIfjXtkN3Nvjk/Dn6vvvywwrSkM1OlVeVumNUU9sllFLEvc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(186003)(5660300002)(36756003)(26005)(2906002)(66946007)(66556008)(66476007)(83380400001)(38100700002)(8936002)(31696002)(86362001)(508600001)(2616005)(31686004)(6666004)(6512007)(6486002)(8676002)(6506007)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDVMNkt1NE1DY2hKbXFLdnQ5QTgxeC9pNmtKK1pXNnJEWndHRStqTlNLNWdp?=
 =?utf-8?B?dzFPZ3RZVzFLWDlWZmxPNGhDTnZRKzgxZHE4cFcvRWdoUU4xcjZyUTR0eUlR?=
 =?utf-8?B?U2Zna3dYUnJtbEMxa2pkMjVnY2ZmZjRmbEZWWW9xN2Vla0xNU3B0R1JOMGNV?=
 =?utf-8?B?RjByUG10VWc0MWpZOUVoVnRDWiszLzdJK3IzQVRFYXFXdHRwUzhaSy9lRldq?=
 =?utf-8?B?bFFlRkQ3R2ZJNHdIRUtqN09Gd2JjTWRVMk85NTl2QnM3WjdGQzNhQm5VMU5R?=
 =?utf-8?B?bkt6UUM4clVqaHhpdGpaYitqYkhiRlRzekpJWm81VUFhUEpwVmZQYkFRQ1N0?=
 =?utf-8?B?RGI4Y2RZK0pYMjdoYlYwNzBJZjN5bEhxR2tLWFhNQUtaZVR6WUhyNGZOZGdS?=
 =?utf-8?B?dnV3WXdPQ20yYzhrRE1IL3RwcCttckRWdUlXaGNXOGp4bXc0RVZONDB2dEZD?=
 =?utf-8?B?NnUyN0NkcSs0VXdnY1VVZE5zVHcrTlhRaXRIczdLK0pFU3o3c0hKdHQvcWh2?=
 =?utf-8?B?U3NaYWI5K2xVc2JxbG9hUGdTano2MWh2QVVUdGEzeS9sUi9pNndIWFlnbWR3?=
 =?utf-8?B?TmNxc1JZQnJEYVZQZ1VMWDFUL2FoRktROGxJbTExNzMvV0xuZWo0aFlnbUg0?=
 =?utf-8?B?WkMwUUdwS2xLeWprN1IyeVdRdEVtU1c5OEo5MnlIWnFpYm1USEt5VXVQWjJw?=
 =?utf-8?B?bmwyYStWenVDNVdGVEs2dHdpZHRqdGVoc2Ewb2xYZzRsVHJFNlp5dGN0S2Zz?=
 =?utf-8?B?QWVEK0xJSHlXOW1lQmpUZk1pajJvTWV5U2NWOEJtcERvYkdjWmFZZVBMMXc0?=
 =?utf-8?B?ZFdzUG1aNENkeHZGZlpEUE5MdVRVTytzc1o1ek56VHRqQjZUa3dhT0htU0VI?=
 =?utf-8?B?bW9MM2J6SkN4eXQ2N0EvOHhWRFAwbEtzZjNhZ2JSSjZVeXJudHc0ekpwSk1Z?=
 =?utf-8?B?NnRSWHB2ZFlsNGlsaHdSNEw2bVRPbUpoVVdHVU5lSGZSeEEwNHZXVEhNME16?=
 =?utf-8?B?a09ITU5pVW1yVFVmcldNdTlKaVdPVXE4bEgzS2JiUlc4Qk5iY05UNXF5WXZE?=
 =?utf-8?B?d3kySmVBTGJjS2tBNWhRc1Z5cHRaaGo3dS81K3pRUE9oSnJlMmtGV0sxL2dP?=
 =?utf-8?B?TThFRjBPaWU3Tm1JSTBUbzV4SGp0aGwxQ0NYY3FISm9sMVRIOC9JL2hkNDAv?=
 =?utf-8?B?ZHBtcjV2L0NTMnZva0IzNC9oWHlObVZSaWZjM0IvdzZ0S2lZTWdaV25NRlFW?=
 =?utf-8?B?OXdtVU1WeU5UZWlYa3pCREdhSHpGUTM4a1lReWJTNVFocFA2QlluN2JGZ1hO?=
 =?utf-8?B?cEhrYVlSSnVRKzhZeXZ1dXZpUUttRnhQNk5YVGN0SEZ6V2c0ZHU5M3JLbTRZ?=
 =?utf-8?B?UGIzSmVRNS91MmE3UlVqOHR0SXphNHRrbWlyMHMyanFFWVlNU1BhSDNJbHFI?=
 =?utf-8?B?Wk50b3hGWXJvdm9rMUhMUDZDRFRPRS9mSTBtUjRZdlJLZWZ3MmRWQ3hMUFhU?=
 =?utf-8?B?TFdZS0FaYXhWRHdDN1BFVFB5K1ZIVlh0QytKdGRzTVNHOUpXeTVuMHdkQUhT?=
 =?utf-8?B?UmlDMmxnZnJZZUpFa2l3WXlNV0JnOUpMbTFlOVE5VW9ubk1CZC9IWngweWZZ?=
 =?utf-8?B?cy9nZHk5cXhpU0ZuK0tpWW83eFBUaEt0QWFzTUt6dzNxWHhqODhrVEU0MU5T?=
 =?utf-8?B?ZStwbHloUERaRWVIbjVYU2V0eDk3cDhvRjUzNktPQUE2T0cwV1dlcU12VXMx?=
 =?utf-8?B?VDNQb0NjNjMrQ256TFBZZlNMb25KN2pEeVNCMnBBRjdDN2FhZndRSktkeGJx?=
 =?utf-8?B?OWhvN0NBQTBwbWhpdkhnUzBlaW5nTVc4YkdlNkxNY0xXdTFaUUliK29lWTVG?=
 =?utf-8?B?V3Q5MkdzOW9pczk5bTRWZU9PQ2JtMnBJK1djZ3dBV094WGQ2RHdJNTlxYXJI?=
 =?utf-8?B?cEZIbzlBYWtqQzhSZDQxZWdBK1hNU1VuSW1LQmxWWm1PL3hIbmVMaVpTaEh2?=
 =?utf-8?B?amV6WWlkVEJjL2xZWFV2ZGFOMnVqNjJBb2h2MGN1NFErQWpxSHg1aHZ3UEli?=
 =?utf-8?B?K1pxQ0lERTZsb0ZnWFNFcHZNRHkweTUvMS84L3Qya3Q5NmZzbU5IclUza1lY?=
 =?utf-8?Q?F07E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d54bf44-d51c-4737-df83-08d9dbe05209
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 06:44:34.9234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vc0mPumSFQu9LliCEfmaUeRNyPqwoVbB3Rg9xfNGH5qeovmfanFJ4YYuBum0MxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/19/2022 8:34 AM, Mario Limonciello wrote:
> Yellow carp has been outputting versions like `1093.24.0`, but this
> is supposed to be 69.24.0. That is the MSB is being interpreted
> incorrectly.
> 
> The MSB is not part of the major version, but has generally been
> treated that way thus far.  It's actually the program, and used to
> distinguish between two programs from a similar family but different
> codebase.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c        | 10 +++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 10 +++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 10 +++++-----
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 14 +++++++-------
>   4 files changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f3c864223033..ae793c648f5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1431,8 +1431,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   	struct drm_amdgpu_info_firmware fw_info;
>   	struct drm_amdgpu_query_fw query_fw;
>   	struct atom_context *ctx = adev->mode_info.atom_context;
> -	uint8_t smu_minor, smu_debug;
> -	uint16_t smu_major;
> +	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>   	int ret, i;
>   
>   	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
> @@ -1578,11 +1577,12 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
>   	if (ret)
>   		return ret;
> -	smu_major = (fw_info.ver >> 16) & 0xffff;
> +	smu_program = (fw_info.ver >> 24) & 0xff;
> +	smu_major = (fw_info.ver >> 16) & 0xff;
>   	smu_minor = (fw_info.ver >> 8) & 0xff;
>   	smu_debug = (fw_info.ver >> 0) & 0xff;
> -	seq_printf(m, "SMC feature version: %u, firmware version: 0x%08x (%d.%d.%d)\n",
> -		   fw_info.feature, fw_info.ver, smu_major, smu_minor, smu_debug);
> +	seq_printf(m, "SMC feature version: %u, program: %d, firmware version: 0x%08x (%d.%d.%d)\n",
> +		   fw_info.feature, smu_program, fw_info.ver, smu_major, smu_minor, smu_debug);
>   
>   	/* SDMA */
>   	query_fw.fw_type = AMDGPU_INFO_FW_SDMA;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 7029e5deb6b3..e94a400db669 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -225,15 +225,15 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
> +	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> +	smu_program = (smu_version >> 24) & 0xff;
> +	smu_major = (smu_version >> 16) & 0xff;
>   	smu_minor = (smu_version >> 8) & 0xff;
>   	smu_debug = (smu_version >> 0) & 0xff;
>   	if (smu->is_apu)
> @@ -287,9 +287,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
>   		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> -			"smu fw version = 0x%08x (%d.%d.%d)\n",
> +			"smu fw program = %d, version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
> -			smu_version, smu_major, smu_minor, smu_debug);
> +			smu_program, smu_version, smu_major, smu_minor, smu_debug);
>   		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index 9c91e79c955f..56a02bc60cee 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -74,15 +74,15 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
> +	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> +	smu_program = (smu_version >> 24) & 0xff;
> +	smu_major = (smu_version >> 16) & 0xff;
>   	smu_minor = (smu_version >> 8) & 0xff;
>   	smu_debug = (smu_version >> 0) & 0xff;
>   	if (smu->is_apu)
> @@ -98,9 +98,9 @@ int smu_v12_0_check_fw_version(struct smu_context *smu)
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
>   		dev_info(smu->adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> -			"smu fw version = 0x%08x (%d.%d.%d)\n",
> +			"smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
>   			smu->smc_driver_if_version, if_version,
> -			smu_version, smu_major, smu_minor, smu_debug);
> +			smu_program, smu_version, smu_major, smu_minor, smu_debug);
>   		dev_warn(smu->adev->dev, "SMU driver if version not matched\n");
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index f66d8b9135ca..d9e3ebfeee73 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -198,15 +198,15 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	uint32_t if_version = 0xff, smu_version = 0xff;
> -	uint16_t smu_major;
> -	uint8_t smu_minor, smu_debug;
> +	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>   	int ret = 0;
>   
>   	ret = smu_cmn_get_smc_version(smu, &if_version, &smu_version);
>   	if (ret)
>   		return ret;
>   
> -	smu_major = (smu_version >> 16) & 0xffff;
> +	smu_program = (smu_version >> 24) & 0xff;
> +	smu_major = (smu_version >> 16) & 0xff;
>   	smu_minor = (smu_version >> 8) & 0xff;
>   	smu_debug = (smu_version >> 0) & 0xff;
>   	if (smu->is_apu)
> @@ -229,8 +229,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   
>   	/* only for dGPU w/ SMU13*/
>   	if (adev->pm.fw)
> -		dev_dbg(adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
> -			 smu_version, smu_major, smu_minor, smu_debug);
> +		dev_dbg(smu->adev->dev, "smu fw reported program %d, version = 0x%08x (%d.%d.%d)\n",
> +			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
>   
>   	/*
>   	 * 1. if_version mismatch is not critical as our fw is designed
> @@ -242,9 +242,9 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   	 */
>   	if (if_version != smu->smc_driver_if_version) {
>   		dev_info(adev->dev, "smu driver if version = 0x%08x, smu fw if version = 0x%08x, "
> -			 "smu fw version = 0x%08x (%d.%d.%d)\n",
> +			 "smu fw program = %d, smu fw version = 0x%08x (%d.%d.%d)\n",
>   			 smu->smc_driver_if_version, if_version,
> -			 smu_version, smu_major, smu_minor, smu_debug);
> +			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
>   		dev_warn(adev->dev, "SMU driver if version not matched\n");
>   	}
>   
> 
