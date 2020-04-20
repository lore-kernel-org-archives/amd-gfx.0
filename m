Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C1EC3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAA44206F6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1mpU++qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA44206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8096089452;
	Mon, 20 Apr 2020 15:32:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278B089452
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcpPkH5BzY494rYMlnAfZ14lHhkOeuj4ys9/hQaGiSjyZRyUVnL0C83vCslJazQJuHio4lxCvIj/aTk5CgwwNsfEChJL+0mkgZ8IxxsZDrZabhyY8f3D+Y5ppkguqIuDykkM9SQDzSrzIArnrnfcdHwvJVBmXcbSqBBLIdsIG0oRlfP1KKoS+sWR8/59Qq7VQD6OxdM13cpfuZYJMCEFNa3+j0rIfaidUJRrqPkfiDkFo3n8oNML7JmIvkVHqgVzqmUnrB2uxrzO9FvfTiRG1HJVe3efzlBXYFd9kfOvm7ik8/N1fvJKJit75vbuZODLwajiwio+b+7WDZ+0Hznd5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLiVYoHt07QGvuZR5UwEqVLcmcErHTUd2IECiT31aUM=;
 b=j2aG4QN2kJGhSTxVrntPsISDAO9U1lZzzjqBvNdwvN3YWOgfj0f+p+nKUuPa342plUd+diZNyZDnv/a2yr8k/V9rhv91VLwZB5LWZ4ogzjJ26P0fcuw8M7xTJf0jYm12CzvRo9+NfkS8l1P9HpoEPoDRRWHDy9fZQe5CsfnSTpsKOFJxJBbyiV50J1j0cT6EQ0lVZiL6I4OM5B1aPMDQY15HRIbHE9TaYmdWlM8/c/xhEs095TgPm/2ZTvlZZvldJhcfalUIrsV0XymHjPQU9T1+EkuS7W7cpzfZ9z1jXesEFZjs3pbz9MEG5/DG3pangGEMwOHSpXib+VOo5dLxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLiVYoHt07QGvuZR5UwEqVLcmcErHTUd2IECiT31aUM=;
 b=1mpU++qA1Fw5SV6dI9NgMOBVXwM8UnHVflykNqyBNbVqEcJSB/Pgmwlui4KBJzn5mVRLeqbDVbVM2qS+gaqaqOOUhazHHFJW2LSzi8l4fOpWU+M5M3t3ssckNFPxiWoKuBIpT/AUqnU9W7sL2A+0wpmuAwLTTFeL5BfFCLonRDU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:32:46 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:32:46 +0000
Subject: Re: [PATCH 4/8] drm/amdgpu: add helper function to init asd ucode
From: Luben Tuikov <luben.tuikov@amd.com>
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
 <1587377804-3836-5-git-send-email-Hawking.Zhang@amd.com>
 <00df5041-e8b8-9662-dc42-17d0b1c1f44e@amd.com>
Message-ID: <acb1c883-d350-edc7-f4a3-6bd837c87da7@amd.com>
Date: Mon, 20 Apr 2020 11:32:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <00df5041-e8b8-9662-dc42-17d0b1c1f44e@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR21CA0008.namprd21.prod.outlook.com
 (2603:10b6:404:8e::18) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:404:8e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.2 via Frontend Transport; Mon, 20 Apr 2020 15:32:44 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a224f456-dc22-4024-8869-08d7e5401349
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:|DM6PR12MB3148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3148F3A9A3ADC775BF41FD4A99D40@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(5660300002)(316002)(2616005)(31686004)(186003)(44832011)(16526019)(966005)(956004)(110136005)(2906002)(8676002)(6486002)(26005)(81156014)(478600001)(6636002)(36756003)(6512007)(45080400002)(52116002)(53546011)(6506007)(86362001)(66556008)(66476007)(66946007)(8936002)(31696002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0FFt85o3wVEfIU7ajRHsjzuYpPklDo6FJFTWXLM0Iv0psFwRrJZehDmh48L0OEptcghGg1plALksfI3dZmcL+Ld9tGbO/vKAp7px28Wg1LeOsjiaAIpXrUVOzCgCIMWKOXLyLknJC3mfmdCAnp9JLCg5ZhwukrkQQ4hfZdbdRIImJOtpyPQX/qfgPZiAduTQelomO4J33FYvbXmYYY8nKIERTlld7Pfj2rUmSkoFKy3gDh6QyRf0DGCBpbnKM8/TQhUGEyf5E391PUFpEGB0ekQJibqmUWhEpvENbg4LMFi0UyLohz2HZGIkDxSrJ3kxP9kXr2TDM/I3LyWGpBKqWtugZx2gkVKNtBKIa7qxAAjEwMwjtZjWuAHi70Bw7snuwg2NJwr3/YR/QpsN1B4pOsxZaoavOSegfaeCZtvvqVhOTttZfFmvHoqAmC4/+jRhCMbx36AZIJfY6LqEV3LtEmeT43+oMtJQNaXCo8ydiQ=
X-MS-Exchange-AntiSpam-MessageData: AL4cotaEwdpGsXc73P3dW3bdMqJhID+fDAy4yJQebkDsLumPRIXLCd6KwXhzrfAHjrKEyFJEuvo2L4s3nFySaj3GLkJwDBABnPrbCcsTYnNM+Pwa1dLnV1b7FNns+9z2mc6/lRXu8r4GmFNA63r7wlJjDU1SV42A9egfOZ5QDCVUmWM/xJjEXlv3EYFv8RbYE/RAqKJ6MJJjORyxX0WjCSx8sNG5nwFICjUBMUT9ahmfYDm3mTWjA+mHbx/M3GRXTa6VB0fFtiJ5WkSXHnPsyO97rgzvi7aCHTAR3x5I9CZa7RAlufH0hK9tydh46kPYdcJ7rmMHM1rcCDTe0WCDbn5Igpr8kdVVtDTx91Hmqk8BMw6SWCQGX0/VWAAdJ2qw9d3ChPoSAkIVNI2kQzHv3lM4uBoGELR2sADEiFyZiCiFvUi0Ee/96jlYv+TUjutzgprpv9+tTHMHjOHLD3Kb4r/R1wB6VsdleiEUENPmuHngfqXu4XHW4nz+PaFUc8rZ/38BcTSYcM915CyoHzs0mXLWkkgYGj8tQU5Ks7ioI6VPP+a3k8u7Bw7guYCK3vaqQUVsBDu1Pr0WpWb8NDoKUAm7w6MMBU7C4S5/o+pWD2QzF9eqt2jFRAt+5fyD9/o3VkxVyt5mL186eFhIUTmGxgSvXl+/dhlKZOsj0Q3B6zrOPo0cd4IqnMwWlsETscv7kPrWdw3Db5Jsg4e0plW9d6gY09AB5MyEXlU+Lg6OVMc2gi0m0bJ38Rg49IGbQD/q+AG00TORPI+EzmosA+rLksVA9FSlJ1fvUDVhfNAWizo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a224f456-dc22-4024-8869-08d7e5401349
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:32:46.2377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b5G4lk3uLLEvcx/SpU+uTqXdpMJrjRxfnS2Xn+wxIyA3g6pIRyfWPBkNa42tdQh
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

On 2020-04-20 11:29 a.m., Luben Tuikov wrote:
> On 2020-04-20 6:16 a.m., Hawking Zhang wrote:
>> asd is unified ucode across asic. it is not necessary
>> to keep its software structure to be ip specific one
> 
> Sentences usually start with a capital letter.
> "ASD is unified uCode across ASICs."
> The second sentence uses "it" twice and it is not clear
> whose software structure?
> ip --> IP and the sentence should end with a period.
> 
>>
>> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
>>  2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 7797065..3656068 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -1840,6 +1840,42 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>>  	return 0;
>>  }
>>  
>> +int psp_init_asd_microcode(struct psp_context *psp,
>> +			   const char *chip_name)
>> +{
>> +	struct amdgpu_device *adev = psp->adev;
>> +	char fw_name[30];
> 
> I'm not sure that that length is going to be enough in all contingencies.
> /lib/firmware and /usr/lib/firmware are indeed the same inode (hard link),
> but if/when using /usr/lib/firmware as opposed to /lib/firmware, some names
> for ASD firmware are at 40 or more characters:
> 
> $for F in /usr/lib/firmware/amdgpu/*asd*; do LL=`echo $F | wc -c`; echo $LL : $F ; done
> 42 : /usr/lib/firmware/amdgpu/arcturus_asd.bin
> 40 : /usr/lib/firmware/amdgpu/navi10_asd.bin
> 40 : /usr/lib/firmware/amdgpu/navi12_asd.bin
> 40 : /usr/lib/firmware/amdgpu/navi14_asd.bin
> 41 : /usr/lib/firmware/amdgpu/picasso_asd.bin
> 40 : /usr/lib/firmware/amdgpu/raven2_asd.bin
> 39 : /usr/lib/firmware/amdgpu/raven_asd.bin
> 40 : /usr/lib/firmware/amdgpu/renoir_asd.bin
> 40 : /usr/lib/firmware/amdgpu/vega10_asd.bin
> 40 : /usr/lib/firmware/amdgpu/vega12_asd.bin
> 40 : /usr/lib/firmware/amdgpu/vega20_asd.bin
> 
> And when using /lib/firmware, the above line lengths are less by 4 characters,
> which leaves it too close for comfort given that ASIC names could vary.
> 
> So, I'd rather see the size of the path name be something larger,
> say 50, or more.
> 
>> +	const struct psp_firmware_header_v1_0 *asd_hdr;
>> +	int err = 0;
>> +
>> +	if (!chip_name) {
>> +		dev_err(adev->dev, "invalid chip name for asd microcode\n");
> 
> Here, "chip_name" is not "invalid"--it's NULL. The message
> printed in the kernel logs should be more clear:
> 
> "No chip name given for ASD microcode."
> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", chip_name);

Ah, I see you're only printing "amdgpu/%s_asd.bin", so I guess 30 chars
should fit.

Regards,
Luben

>> +	err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
>> +	if (err)
>> +		goto out;
>> +
>> +	err = amdgpu_ucode_validate(adev->psp.asd_fw);
>> +	if (err)
>> +		goto out;
>> +
>> +	asd_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.asd_fw->data;
>> +	adev->psp.asd_fw_version = le32_to_cpu(asd_hdr->header.ucode_version);
>> +	adev->psp.asd_feature_version = le32_to_cpu(asd_hdr->ucode_feature_version);
>> +	adev->psp.asd_ucode_size = le32_to_cpu(asd_hdr->header.ucode_size_bytes);
>> +	adev->psp.asd_start_addr = (uint8_t *)asd_hdr +
>> +				le32_to_cpu(asd_hdr->header.ucode_array_offset_bytes);
>> +	return 0;
>> +out:
>> +	dev_err(adev->dev, "fail to initialize asd microcode\n");
> 
> This message is vague, in both counts: load and validate.
> The rest of the driver prints something like "failed to load %s firmware", fw_name,
> which is more descriptive an_ it shows the file which failed to be loaded
> or validated (giving the user a visual check of the name).
> 
> For instance, see gfx_v10_0.v at the bottom of "..._init_microcode()" function.
> 
> Print something like,
> 
> 	dev_err(adev->dev, "psp: Failed to load firmware \"%s\"\n", fw_name);
> 
> Regards,
> Luben
> 
>> +	release_firmware(adev->psp.asd_fw);
>> +	adev->psp.asd_fw = NULL;
>> +	return err;
>> +}
>> +
>>  static int psp_set_clockgating_state(void *handle,
>>  				     enum amd_clockgating_state state)
>>  {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> index f8b1f03..a763148 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
>> @@ -385,4 +385,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>>  			uint64_t cmd_buf_mc_addr,
>>  			uint64_t fence_mc_addr,
>>  			int index);
>> +int psp_init_asd_microcode(struct psp_context *psp,
>> +			   const char *chip_name);
>>  #endif
>>
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cluben.tuikov%40amd.com%7C3bf4ce6df8a348e735a608d7e53fada3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637229933975152085&amp;sdata=Vlq1qsHb8ygT46RJgf9fHamzUGAFuWB3%2B1xKaI06H2o%3D&amp;reserved=0
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
