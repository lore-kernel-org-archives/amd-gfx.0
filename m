Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA24C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27E1460EBB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 16:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 27E1460EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B36F26E105;
	Tue, 19 Oct 2021 16:17:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324746EC30
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 16:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtvYQ522/GWb1zw/hoJa+7Y3LaD2pnO+oOu+6nJmCzSA7cWZOh2sbBafy7Ve7ZwjTo1g6zsVAMqOQiEnmiJE+FsFpbYwF+AyRRotVSPFJD5ml6ZgdkaAUB8INXBgUMA7Q6/LJwRRDct1kfwpm5r8rJrNGgjfiuav//AMCs7mkEa4EKX/DSy6TB+a0wC0Tyzrvoc9tiLQ/9rVfzX8O3LJ9etZLfy2ZtvnI0D8Aes/E1gJvywu8fQ9rLtJL3DPXo4zmcQ+fdJwaM6ll386BE/lK0EwvQaxqMgiQK4zpWZxVkX6XRaECKqI7A/4EX5ncfAn7LOMtBaquunZ5SRCClfB9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3Fgj7rtGTJUfpD2oz96iPJIZs7eo3fCNSZFBem9g7k=;
 b=dAHMrn5CxBgJB5iOYgA670E1brxhz1Rg6d1chSR8/DSG0P64HFyN0cI6AvOMOQWMof8ByQyRiGGLCP7cCEgcN2O7bZ62mjlJclQsz24Nq949YSPgOgUM1G7FL2t0GljmexvSeMJMIVdE/QM+aFGfXjZ7A5kATpU3vQtLN5VtdJbw/JiKFvj5L2Q4hJ7VSx4CZmSRnRln5yybzp8nobwmTchm+NGwHKGITZAsM4XrwQewcKg+7yIR1i0bbU+o8A6A/V/Wzw9DTqpbUIOyd5c4h4JKrKFDHfVj4VI7YgWRLXKxG10D/uX77u1JEInNYfqdHqlaA+POZN20rE2dfwygXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3Fgj7rtGTJUfpD2oz96iPJIZs7eo3fCNSZFBem9g7k=;
 b=BkaP0flcIvtqKN7DA26xjBURaOeiDD/Cl/PlU+9ELCYiiUHpBODBiBndFbIROj+SKLlKEC2mBMkNaKidHY/bRJur0JGVmFoi/0449Lc5QFfsZQzro+JqvB4q1cYXWaPeTkUM5RMAgWwx5N55OQlE6/7TKchAhOvnNOFPyMbbMrk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 16:17:10 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 16:17:10 +0000
Content-Type: multipart/alternative;
 boundary="------------niTJu9d0qUCSOvd0DyUeSbXd"
Message-ID: <a62ae095-e4f0-46fe-67e9-cdcbbdebec28@amd.com>
Date: Tue, 19 Oct 2021 12:17:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: Consolidate VCN firmware setup code
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20211019155644.338589-1-alexander.deucher@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20211019155644.338589-1-alexander.deucher@amd.com>
X-ClientProxiedBy: LO4P123CA0151.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::12) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 LO4P123CA0151.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:188::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 16:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f50af67-914f-4403-9dc5-08d9931be731
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3595A7AF31BBB4214667CE9BE4BD9@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WLa/6JNph26Hfen85+8DNZGDZIlbvA3itzbRWP7CG3vx+9DtnbR31WEP9vBFoBsxf65H2lrrjfFBXfXiJHby4X33tMGFcSYDgMDHAyJb3L9le6h14PFUi8uNuFdbR3/vkFiX02xA+PqZv40n8qNCbcpiexCf9wtnC6uF5in1BL//4goOYVHENTzFrDB7hJipAli4uRI9G/2/c1tFk7ECglr60vE2ky17ntmkrATFNiLq2CckdolvRrSD4kA6h+W0xiI/dlp6lprtQqur1u4SzC9kDwfCKwLjQrrmuuZd6ghyqau16VABIzHMDqxzQErL75nnc5eTPbmoPFv6AaMMW0xzCEqTAKUrwluESGYEny0beSVKAJxGdfSMHXidL9mzxmQTDgrglMaFjVbKbiOkkKqVKNARZM8mMd3RVUVwgWWKcdtImSBGlLUsNoGy1wLUtz0DeQDwUsXYmTSWYsRYuqfBE/r/PJUPS0rXIzrnqQuz9sTDxljm2ua1LfGOSUPwiuDzB5l2Bs5RQd/SnSBKOwRLAlntQujgveYVc2oh/zKtCoKFRL3rr/WJ97so0+/4Bq0h7ZL3GkUtTivOdzQ5A8JS2hzW2IyqhO2vR7zCuhLpBP+sIrb/MtUNvMd7Ubh0yKLih3ab5Ksk+MDa0Vvv9wH4JaNNkK1iBFH8d4uOE/zBow4AVFKB0JVY82CriHM62on2oSq5isH04Dt2WhFe1aq8ueeZB50GRKCrFAu9jG1NLS6uxwQzYiIorhYBUek
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33964004)(26005)(2616005)(6666004)(8936002)(316002)(8676002)(6916009)(30864003)(53546011)(956004)(16576012)(66476007)(186003)(66556008)(2906002)(508600001)(31686004)(5660300002)(36756003)(66946007)(6486002)(4001150100001)(38100700002)(31696002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3daamN4NStPUkdJZElKQlR3dFlrcXBlYllrdkRFVktCZzBuMDU0T1BWYnRY?=
 =?utf-8?B?cFo4Y2w0d2JJcllrQkdscm1VdEd1S0cweE9tSXpjeTJPVGxhZm1oM1lPWUty?=
 =?utf-8?B?OFJyTkxmV2dtZlVGQmtpaDR3S2tKaUhHdVRLVVpTMm0wcnc4SzhXV0dyVEts?=
 =?utf-8?B?dGVpSGUwQXFCdC8xaDl0R3RDRGd2M2ZjMjE0VkdhSzQ3MHRPaWloYkt2Zis5?=
 =?utf-8?B?b1JGUDJCYjdHQytnT1Rpc2pDOThVMVQ1MTRyUGNkeVJzb2xJYVc0OG9vMkdt?=
 =?utf-8?B?YVJsVVFjYjFCT21TcGNRUk5ycnlLTno5dTl0RlpqZmlNNmpqUFNsb0tKK3Ix?=
 =?utf-8?B?TDZRWFA1b25aZnVHZ1pQcWlvamYweDl0clVhWDRCY2tJM0hmV0pqcG5UaVpo?=
 =?utf-8?B?SnBFLzdCajVrdE5BUC9YTVlKY25oRlYyU2lHYUtJTUQ4QlZWdEt4bGlub1dn?=
 =?utf-8?B?M0ZyTmRIT1lnbkhDeldFYTdRclRwVUZ1THVIL0cybU5Fdmc2ZmRFRTFRcE9L?=
 =?utf-8?B?aitLcHVoSGtnU3JSMzJmclgyRU1SNkZPRzUyN1NsekMrYjZlZnlyVmh0ZkFz?=
 =?utf-8?B?eDZHdERqdTN1SVNYbHNTRlVXRkNwWHhNTEpNRlhoRSs0d0RtS1NnZURxOFo2?=
 =?utf-8?B?dGVxUkVRRTQ4V1poM1dMdUd2U1pQVDJ0Nk1qY0x0cmlXUStBZlJGN0NkalJO?=
 =?utf-8?B?Nkw1RisrdG5GTTJ6TWMzQVptcFJvc3I2V3FqNkhTbFh6YVFCSTROVUlScWp3?=
 =?utf-8?B?Qi80dCtOTktkTFM4ZG85YnlxVld5cVl3clZRNU1ZT2NYN3QxOUZycml1Tzk3?=
 =?utf-8?B?OE5SUTVtSU1zRkYyKys4OWNaMEVMNUJkS29hZVRkenZiSTQyU0xUUm5NQzdW?=
 =?utf-8?B?R0FnN0xLOHRBSEdJNnRzWnh6VGQyNi9PTlpHUGMwYVVldFNzSm8vbWFsMXhG?=
 =?utf-8?B?bkF6a1BsZVJGOVJ6bVdodmFDeWUyRUFqdmJRMkpJL1NhSnFPZUp6dU4xOHdF?=
 =?utf-8?B?TVY2SUczSng3bVFoVE0wOEliU0RqNnlXckszNEYwQW5KNW5yNTF5WURkUURR?=
 =?utf-8?B?cVpPUXZxRHZNWkVGUUlEZkl6QTdVcHArTEV0Qkc5V0RYUmNOMnFyRjFWcm1X?=
 =?utf-8?B?VmNON3VVZmJBVFhKZnRZR1Q0aUY1dVljZS9UTlcwOFZBRERXcnZUeUVkem84?=
 =?utf-8?B?bDl2SHZCcXNTL25mQlNkZ2Y3SlRzOFFISE16Ny9ub3FYTC8wN0V5dS9ZcnBW?=
 =?utf-8?B?NFNwSzE0VG5QWFZRM2JzOU0yVUtmU25ZZ3dSTWIzQTNPaW9HMXQ3eXRxdWhY?=
 =?utf-8?B?TWNIMHZHZDdHQTdyTE5SaWN2S2JYSkFZKzl6Q3lUTytvK3BRcmNQeE8xRlNn?=
 =?utf-8?B?RWNyUm5ub2FmU0RURUptMkFGR2VnWjVGNGdXK0pwMGVLdlRRR3VVUWUzMk9o?=
 =?utf-8?B?ODNUaVhhMFM0NitYM2pyUmhZd0M5elc2K0hHdXpEcEpYYU5lRy9TSmZ0Vllm?=
 =?utf-8?B?SUFrN2Zid2V6OC9QblBROFQ4V0dPcEgwV01ab2ErdGNQUlhJa3pRbDZncGs5?=
 =?utf-8?B?NFFCbWloNFZ6ZXJGUzJOcGZqckwrekE1bGxUOVhONXRGV3owMFhIQTVxQkVr?=
 =?utf-8?B?SVp5MkZCVkovcGV5TVpqM1JKckZvSWVKZXo2NDBjNUcvcGRIK21lQkU0Z0FH?=
 =?utf-8?B?SXU0RWJ4SFdrbk9wN2lUYlZ4RS9OdVgxb1o5RUVyN1pOWFowUG12WWZHOFdB?=
 =?utf-8?Q?7tEA6nQA5Jk7XJzDqOuYdvcfVtv+jnled4b34OZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f50af67-914f-4403-9dc5-08d9931be731
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 16:17:10.3573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lx47hmL3oS1J1/jqH1h+nI5xkeq6ZJ9lOyc6/0wNGSCy5vCNeQzUTe+LNu7ZmR7d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
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

--------------niTJu9d0qUCSOvd0DyUeSbXd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

With two nit-pick below.

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

On 2021-10-19 11:56 a.m., Alex Deucher wrote:
> Roughly the same code was present in all VCN versions.
> Consolidate it into a single function.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 +---------
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 +----------------
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +-------------------
>   6 files changed, 31 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index c7d316850570..dc823349f870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -949,3 +949,28 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
>   		return AMDGPU_RING_PRIO_0;
>   	}
>   }
> +
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
> +{
> +	int i;
> +	unsigned int idx;
> +
> +	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> +		const struct common_firmware_header *hdr;
> +		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> +
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
[JZ] Add check if i > 2.
> +			if (i == 0)
> +				idx = AMDGPU_UCODE_ID_VCN;
> +			else
> +				idx = AMDGPU_UCODE_ID_VCN1;
> +			adev->firmware.ucode[idx].ucode_id = idx;
> +			adev->firmware.ucode[idx].fw = adev->vcn.fw;
> +			adev->firmware.fw_size +=
> +				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +		}
> +		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
[JZ] DRM_DEV_INFO can be used instead .
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 795cbaa02ff8..bfa27ea94804 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -310,4 +310,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
>   enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
>   
> +void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index ad0d2564087c..d54d720b3cf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -111,15 +111,7 @@ static int vcn_v1_0_sw_init(void *handle)
>   	/* Override the work func */
>   	adev->vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		const struct common_firmware_header *hdr;
> -		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
> -	}
> +	amdgpu_vcn_setup_ucode(adev);
>   
>   	r = amdgpu_vcn_resume(adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 091d8c0f6801..3883df5b31ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -115,15 +115,7 @@ static int vcn_v2_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		const struct common_firmware_header *hdr;
> -		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
> -	}
> +	amdgpu_vcn_setup_ucode(adev);
>   
>   	r = amdgpu_vcn_resume(adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 59f469bab005..44fc4c218433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -139,22 +139,7 @@ static int vcn_v2_5_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		const struct common_firmware_header *hdr;
> -		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -
> -		if (adev->vcn.num_vcn_inst == VCN25_MAX_HW_INSTANCES_ARCTURUS) {
> -			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
> -			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
> -			adev->firmware.fw_size +=
> -				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		}
> -		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
> -	}
> +	amdgpu_vcn_setup_ucode(adev);
>   
>   	r = amdgpu_vcn_resume(adev);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index e311303a5e01..57b62fb04750 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -123,7 +123,6 @@ static int vcn_v3_0_sw_init(void *handle)
>   {
>   	struct amdgpu_ring *ring;
>   	int i, j, r;
> -	unsigned int idx;
>   	int vcn_doorbell_index = 0;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> @@ -131,24 +130,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   	if (r)
>   		return r;
>   
> -	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -		const struct common_firmware_header *hdr;
> -		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> -
> -		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> -			if (adev->vcn.harvest_config & (1 << i))
> -				continue;
> -			if (i == 0)
> -				idx = AMDGPU_UCODE_ID_VCN;
> -			else
> -				idx = AMDGPU_UCODE_ID_VCN1;
> -			adev->firmware.ucode[idx].ucode_id = idx;
> -			adev->firmware.ucode[idx].fw = adev->vcn.fw;
> -			adev->firmware.fw_size +=
> -				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -		}
> -		dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
> -	}
> +	amdgpu_vcn_setup_ucode(adev);
>   
>   	r = amdgpu_vcn_resume(adev);
>   	if (r)
--------------niTJu9d0qUCSOvd0DyUeSbXd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>With two nit-pick below.<br>
    </p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>

</pre>
    <div class="moz-cite-prefix">On 2021-10-19 11:56 a.m., Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211019155644.338589-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Roughly the same code was present in all VCN versions.
Consolidate it into a single function.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 10 +---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 +---------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 20 +-------------------
 6 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index c7d316850570..dc823349f870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -949,3 +949,28 @@ enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring)
 		return AMDGPU_RING_PRIO_0;
 	}
 }
+
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
+{
+	int i;
+	unsigned int idx;
+
+	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		const struct common_firmware_header *hdr;
+		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
+
+		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+				continue;</pre>
    </blockquote>
    [JZ] Add check if i &gt; 2.
    <blockquote type="cite" cite="mid:20211019155644.338589-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">+			if (i == 0)
+				idx = AMDGPU_UCODE_ID_VCN;
+			else
+				idx = AMDGPU_UCODE_ID_VCN1;
+			adev-&gt;firmware.ucode[idx].ucode_id = idx;
+			adev-&gt;firmware.ucode[idx].fw = adev-&gt;vcn.fw;
+			adev-&gt;firmware.fw_size +=
+				ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
+		}
+		dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmware\n&quot;);</pre>
    </blockquote>
    [JZ] DRM_DEV_INFO can be used instead .<br>
    <blockquote type="cite" cite="mid:20211019155644.338589-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 795cbaa02ff8..bfa27ea94804 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -310,4 +310,6 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 enum amdgpu_ring_priority_level amdgpu_vcn_get_enc_ring_prio(int ring);
 
+void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index ad0d2564087c..d54d720b3cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -111,15 +111,7 @@ static int vcn_v1_0_sw_init(void *handle)
 	/* Override the work func */
 	adev-&gt;vcn.idle_work.work.func = vcn_v1_0_idle_work_handler;
 
-	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev-&gt;vcn.fw;
-		adev-&gt;firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-		dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmware\n&quot;);
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 091d8c0f6801..3883df5b31ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -115,15 +115,7 @@ static int vcn_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev-&gt;vcn.fw;
-		adev-&gt;firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-		dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmware\n&quot;);
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 59f469bab005..44fc4c218433 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -139,22 +139,7 @@ static int vcn_v2_5_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev-&gt;vcn.fw;
-		adev-&gt;firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-
-		if (adev-&gt;vcn.num_vcn_inst == VCN25_MAX_HW_INSTANCES_ARCTURUS) {
-			adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
-			adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev-&gt;vcn.fw;
-			adev-&gt;firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-		}
-		dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmware\n&quot;);
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index e311303a5e01..57b62fb04750 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,7 +123,6 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
-	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -131,24 +130,7 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		const struct common_firmware_header *hdr;
-		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
-
-		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
-			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-				continue;
-			if (i == 0)
-				idx = AMDGPU_UCODE_ID_VCN;
-			else
-				idx = AMDGPU_UCODE_ID_VCN1;
-			adev-&gt;firmware.ucode[idx].ucode_id = idx;
-			adev-&gt;firmware.ucode[idx].fw = adev-&gt;vcn.fw;
-			adev-&gt;firmware.fw_size +=
-				ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-		}
-		dev_info(adev-&gt;dev, &quot;Will use PSP to load VCN firmware\n&quot;);
-	}
+	amdgpu_vcn_setup_ucode(adev);
 
 	r = amdgpu_vcn_resume(adev);
 	if (r)
</pre>
    </blockquote>
  </body>
</html>
--------------niTJu9d0qUCSOvd0DyUeSbXd--
