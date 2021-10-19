Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28280C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED131610C7
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 15:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED131610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1A16EA83;
	Tue, 19 Oct 2021 15:50:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CF036EA83
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 15:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNSRnGvTBbevVLDUbG2YQECMiz8OdJ/E1hcPPoAQoTWd/z3cYRcSFExpI/T2XaEdASjkTxNX7c9CgCRbo6mdO9m+LLeX+s++vD9r6vjJk+yV2j3K2lAkBnPn3HabOQx8U5rj6Xqh/Fvr0TsQTlVQqhT9+tVPxnnwHN8ovCyBs15NNxxGndv2kKv8j8o0nWy5B7T/V8fsnzJxMXafYuBynpCKpCoocdtWkKjjdkhLIanoT/5K1A7PInzNvGgmrcm//xnFqCqek7++/J2It1rCMP4n4hH+rBfsdsP8LEn39A4zDPZ6mbzfry8atAmHM7/yhe6ZC5uphsaKNCu6xdbzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO7k4nGig0fVomrInJyzQKYGBNjuKm0tuFQTljIWAsY=;
 b=TRnXdlsYmxnVp1i86iQ7q+e3izDvEgJUViizrJ8pN6q+olNi75W5yCEfuLtctT76McEFeK/hkLTPQtBbEjz55ZwhajJKFmqxdz7fi44JsCLcJ30zBWQkO3sm9yjucPfkRd/MQ68FhV+fMRw7HDp5HCvvcUimKLZsaSl70E4UngBq8UpfmH0jVl5veQuOdO70qr82sghvSpOQqu5rQAcAxAxr4qXJHnaHV4NBhoGj6qFhSylIIcizS3DNvXT0OKP6OonvGB9eKPcOX+sxjnJ+rjype9fhBwdjSaKVmY4/PC5jPucALAQDBoUeYNK0eKJHp1z+b3xA2zzPmMfFxSqQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO7k4nGig0fVomrInJyzQKYGBNjuKm0tuFQTljIWAsY=;
 b=5plK2xsarQRfSsj7r7Ah7refMF5qTWzyAFVSNfZZuvWG+Vbc+7ItZXZVQAETY4983dY+lZcTRjRDK3lUDkr6tMiZl71mMrcdpzt6linRqM2Zj8PagzxNQgkRgjJg4pdXJf4S2lhx2IgGlzuLKwY2GV2ysxh23MK7zAubWmAUeJw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 15:50:49 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 15:50:49 +0000
Content-Type: multipart/alternative;
 boundary="------------UeWHL4nQvyXoqOnOZVI7ETrJ"
Message-ID: <792de210-1260-f385-be4b-fbd4d3cee73d@amd.com>
Date: Tue, 19 Oct 2021 11:50:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu/vcn3.0: handle harvesting in firmware setup
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20211019151303.291103-1-alexander.deucher@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20211019151303.291103-1-alexander.deucher@amd.com>
X-ClientProxiedBy: LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::15) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 LO2P265CA0339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16 via Frontend Transport; Tue, 19 Oct 2021 15:50:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8018ce08-161f-4e64-bf7e-08d9931838ea
X-MS-TrafficTypeDiagnostic: DM6PR12MB2604:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26045281E1E91E82141A82E0E4BD9@DM6PR12MB2604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eYi7lsk69WkrVT4hGrOL7cFQDMLA0xCAu+lnNHKFw0NlcjFPkLISd0GmIGwybOl3m9uCwd6DiPxDoADy6lFFE5yHC1EkabnXpZfeVFMmM7RYGMha7ATk/GInWp04HDjpUghh5pecAxJX5TCIBBo27qWNUtu5CADZfaatLG0XDfEvUuISRmnA3JnCCz3NiXBZkSeyl82LILG0v0TXRKDsavYFdW2Aqd05X5CuCo4CPS1U73EdofW/fx/p9CGIQ2y4VF0QnptwdlkHXJjeVEsMgd3eVhdPGgxRd054cq0ZTFkbZV3nMUzqujgn6iEYfg1qC9hWPBejVjGIO9PmcyutNEnI2/dy8sfuJYqsI+mLXVcca5GulgfSO45JlCLdZv6H0dgCoIxb8ZJz83QJ8FBwn9ksHpYtLe2ow5HAtHfCU5lu8wkGTjPYAh+or7udZ7todt5hDMqs4avrvKWw8WLPC81uo9Eou3kAOBZAoXew4r6N6x3ZvthklqN1cfzUBiLNH9QJ7eb87BhdLXTzOoz0MM1APtir4nsF6PBZMhHvbVBWAu6x8FTCdqO0eg4UvVSvwMRMRqg/rcXyDI1NucoISn6TuE3knbX3KLsVWJ+J+k6icKCU8ZoXvz26f21LdRTWEI+W/VXqSJufD5X8sPaexo8aaWWk00p8so7b2NXjVGnSksUgSXxisz41XRmtJm67bdbduCTVlGe5VF8skGIsNNM66wM9MLSU/DfKOqQfCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(4001150100001)(316002)(956004)(16576012)(2616005)(31686004)(66476007)(508600001)(66946007)(38100700002)(6666004)(66556008)(31696002)(6916009)(33964004)(8936002)(36756003)(26005)(8676002)(5660300002)(83380400001)(2906002)(6486002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJEeVZHYXRybU5jUy9paWVuTUJhRzlsYnNyc00vMzdaTUlVampaMHhBWWtS?=
 =?utf-8?B?TFppZTJKTy8rU1pvRHdWUEJ4Q28ydmkrZXZpVlRkM1l0WGNocURZN0hLTktB?=
 =?utf-8?B?Y2xJZWlGRlEyTmxkeEFZamM4L1dJYUF5aGxpYVNYSmwxTlc2aGF0TWJFTjN1?=
 =?utf-8?B?MXdSRUJ5T092d0dTUWZvY3NkQVJlM2p1bEFSanBPRlM2R3gzS3JNa0JWVGQ2?=
 =?utf-8?B?OGI3UlBLN2J1MENlU2hKbXgyd2RyRGY0NkU0aUlMQkxDdXkzVW5IeVpZMzhi?=
 =?utf-8?B?QmtWclhjcHgrTWF4WVdxZ0lRbVFrZ0hKb3VhNlpRNEJ5eXRkcllUVllCdVVL?=
 =?utf-8?B?bThmY2lYZmg2V2t6Q2txd3pNVGd0UVpGUXpTTzR3TTJXajJnRk5Ka2RLQThE?=
 =?utf-8?B?NUtPWFB2M1p4YU1aUHpnK3RGTnhsSzdXOGZqVGIydXk2S0xmUzYxRnM3STE2?=
 =?utf-8?B?REY3Wm9VaTY5Qmp1eUVJR29OUERVQ0FXUzdlOEZVQUJjY3ZIQmI0bEdCSXhJ?=
 =?utf-8?B?Q0FndTZSYTdVUXBVZjBIYlY1MkozdVpsZEErUisvM0Fsb1JzZHhFN0lrdG8y?=
 =?utf-8?B?b0d0TnZaNXY1aEVGUEtBOWRvcDBZdXFFbklMdXpFeE1DWWZiYXBtK2czTnQy?=
 =?utf-8?B?VkkyL2lsbnMwQkl6ek9xRmxjT2NSY2tFOC9TRnUzNUU0Smc5dGJyYm5CNzRx?=
 =?utf-8?B?ek45bWpTMTFzYW1YNkxPelFQdGtRN1kyNHJFTzRqeE1Id29Jbk5Xc2V1QnZ2?=
 =?utf-8?B?cUtzSXFDbTlNUkdleUt1MUJGRGcrUUJreUJ4eEVPbkVBSFgreEdaMUhuRWlt?=
 =?utf-8?B?L1haZjdmc0NDN28vTjd5OERtdTc2d1ZiMmx3VWRUdmpWOGovYlI2TXFOR1hT?=
 =?utf-8?B?OXo2eEgwOGlIVUZ0TVVVUGwzQVE4aEV0amxrOHB0RktxdWFyUmdXL3pUZmVy?=
 =?utf-8?B?VUFhMEZDZER6cndSelpoUTZaOWtSUmdLcUM4aUJiMjRJYUVsL0RWQnE1QUNu?=
 =?utf-8?B?Q0dyazgrMVNpTjlzUlg4YjFjUi9oV1YyNlF4RWk2SDlNa0pRbytDVnVxdnFY?=
 =?utf-8?B?YlViNFVzR3ZMM3FsOUFJZ0JjNjNiTEk1dC9jWk44ZUZhaUg3dFhwaENUSTBx?=
 =?utf-8?B?bE5iYmpNanBwaTdwb2xpaDk0blM2SDRlYisvQU1uUEJQZVUwbXB4aUZQM3Uw?=
 =?utf-8?B?VlVFZHpHZUJudm5qVFhrd1J2akFjYmNhM1pBdWRjN1B0eGpqY2NjbUdmd0Rw?=
 =?utf-8?B?Z1Z4ZlZXT3JQUVpiL2NMR01DVzlmM3hkRGtBYTRJL25QdWgxTmZTRVpQblR6?=
 =?utf-8?B?cjg5b1FMbjcxcHV5QmtadUluSlF1ZktZWDF2MTk2WXlwY3ZXSDl1azJ0dFVu?=
 =?utf-8?B?ZDBQdlZDdWNBSjRVRGhHSENxY2tWcTliTGFFOWVpb2srS1Z2RitPQUlGS0VZ?=
 =?utf-8?B?RjF3ejRhV3J3WXUxVFl5V0pCa2hSdHpxbUpmcjdoTU9sNVRpeXZZcmxWMEtS?=
 =?utf-8?B?RXJ2Z3hzNjVWQkRFZXB3aDViZzRNVTMzcVFtc0drbGh0aERTZVRVaGRGN3Vo?=
 =?utf-8?B?WDlxYXM1SDhtdzg3VkxuczEyVll4WlpmSXAydjNkTDE2R3NhM2RXZzVZNnJy?=
 =?utf-8?B?SjVzcWtibmRrbUNldmplRUtoYW9reTA1NEwrWUw0citkaHZWcUVnUEoyTGtE?=
 =?utf-8?B?R1l6S1ZlbzA2Tk41OWRwRC91YzhKZVVyaTExTTUxM09QL1c4UVJRRU93T0ZD?=
 =?utf-8?Q?OAWW659QwdsDYt+x1jzKClhH4yJCwe/R0Bw7eP3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8018ce08-161f-4e64-bf7e-08d9931838ea
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 15:50:49.5961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sdVIwsgCz3PnLhanYdq04nVv3cfW+evJqjvGovs3Mjw+sUvgKwiV0r8gozf+/jrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
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

--------------UeWHL4nQvyXoqOnOZVI7ETrJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2021-10-19 11:13 a.m., Alex Deucher wrote:
> Only enable firmware for the instance that is enabled.
>
> Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index dbfd92984655..e311303a5e01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -123,6 +123,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   {
>   	struct amdgpu_ring *ring;
>   	int i, j, r;
> +	unsigned int idx;
>   	int vcn_doorbell_index = 0;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> @@ -133,14 +134,16 @@ static int vcn_v3_0_sw_init(void *handle)
>   	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
>   		const struct common_firmware_header *hdr;
>   		hdr = (const struct common_firmware_header *)adev->vcn.fw->data;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
> -		adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev->vcn.fw;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> -
> -		if (adev->vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
> -			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
> -			adev->firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev->vcn.fw;
> +
> +		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
> +			if (adev->vcn.harvest_config & (1 << i))
> +				continue;
> +			if (i == 0)
> +				idx = AMDGPU_UCODE_ID_VCN;
> +			else
> +				idx = AMDGPU_UCODE_ID_VCN1;

[JZ] Not sure if it is worthy to replace idx with (AMDGPU_UCODE_ID_VCN+ i).

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

> +			adev->firmware.ucode[idx].ucode_id = idx;
> +			adev->firmware.ucode[idx].fw = adev->vcn.fw;
>   			adev->firmware.fw_size +=
>   				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
>   		}
--------------UeWHL4nQvyXoqOnOZVI7ETrJ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <br>
    <div class="moz-cite-prefix">On 2021-10-19 11:13 a.m., Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20211019151303.291103-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Only enable firmware for the instance that is enabled.

Fixes: 1b592d00b4ac83 (&quot;drm/amdgpu/vcn: remove manual instance setting&quot;)
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index dbfd92984655..e311303a5e01 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -123,6 +123,7 @@ static int vcn_v3_0_sw_init(void *handle)
 {
 	struct amdgpu_ring *ring;
 	int i, j, r;
+	unsigned int idx;
 	int vcn_doorbell_index = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -133,14 +134,16 @@ static int vcn_v3_0_sw_init(void *handle)
 	if (adev-&gt;firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		const struct common_firmware_header *hdr;
 		hdr = (const struct common_firmware_header *)adev-&gt;vcn.fw-&gt;data;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].ucode_id = AMDGPU_UCODE_ID_VCN;
-		adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN].fw = adev-&gt;vcn.fw;
-		adev-&gt;firmware.fw_size +=
-			ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
-
-		if (adev-&gt;vcn.num_vcn_inst == VCN_INSTANCES_SIENNA_CICHLID) {
-			adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].ucode_id = AMDGPU_UCODE_ID_VCN1;
-			adev-&gt;firmware.ucode[AMDGPU_UCODE_ID_VCN1].fw = adev-&gt;vcn.fw;
+
+		for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
+			if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+				continue;
+			if (i == 0)
+				idx = AMDGPU_UCODE_ID_VCN;
+			else
+				idx = AMDGPU_UCODE_ID_VCN1;</pre>
    </blockquote>
    <p>[JZ] Not sure if it is worthy to replace idx with&nbsp;
      (AMDGPU_UCODE_ID_VCN+ i).</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>

</pre>
    <blockquote type="cite" cite="mid:20211019151303.291103-1-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			adev-&gt;firmware.ucode[idx].ucode_id = idx;
+			adev-&gt;firmware.ucode[idx].fw = adev-&gt;vcn.fw;
 			adev-&gt;firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr-&gt;ucode_size_bytes), PAGE_SIZE);
 		}
</pre>
    </blockquote>
  </body>
</html>
--------------UeWHL4nQvyXoqOnOZVI7ETrJ--
