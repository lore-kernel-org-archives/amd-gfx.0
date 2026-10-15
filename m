Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E4ACC6B2F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 07:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDAF10EB96;
	Thu, 15 Oct 2026 07:17:13 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F201120F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 07:17:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D8IPxcfD3eMQ5xiPRxwnCbOU/smuGcktzCZGRBk61YSTvmWD/SxHuWD/V3pyJBZlUSY1Ns3W4MWW/uxTZ1sBiDoJ4Foa18nMIRhvRPDKs7UQoqn7SNAQXF+CKyEAcIn2Ghkh8GDiGmYeR2JxFROsCmy7FraFX+p4+rAAubX7DyC1zoTT/zRNyHdmM3VleDiuYgBD5tfxirIpIZ5P6AeO4edLXdo3d1Pj+CrUrcQ6p8IXx7MvJvIYq4Jkaf5pYOiz53Sbb7vAiYBNOoKUEAs56hDW5n0gSo8nYScHdSisLT5eotrsb0FKFrLqGhJ5JiEqCSNHTLi9jqRYs+P5r3PpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lw3jJ27BsNrLeWNpWnyiob5jPJsDT+RcPNP7PJrJFBk=;
 b=EjVBO/Q0n1ek3RgbCEgdf6DzXG0JHvO7cqXRuiFLJHo0Hlq/52HyRhFxBrBd/TtCJhzoMtv3yCV4cT9Cn9g0QN+NcbV0vXtKkxKv3LgLflUuQJ2YzlmBsMklEo2cGkYh0btioNp+wUVZuVBPd5jPEfhaSHVai4MswdUjsVn/OXYx6KU8kSYc6Ci0/8AHXEioP/XncbV3xub5jb0AfL6aDJ2vL89Pku8xI0uwSyoiZJqSAwkIBBb4zWlHMEJd3Pi/gm+ffyZZiZjrbmJUtZO+M13JnLzHR+Adlxhxn8q5CoI95HLzW/qFnyxtUPR44kvqjhCDV3kHA83gqzcCyKYS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lw3jJ27BsNrLeWNpWnyiob5jPJsDT+RcPNP7PJrJFBk=;
 b=q+MU9oBFaoCSZK77ukGG+rfASw02IlkoWN3htQZXB9sQiPnMfXoUZghDceQtvxwf8nWIga9ERQVtCIWgR9peL/zNS4rljTgNFzdCr/EE/tNfOaev05jiZSpStAUWJCXZGc2rJ3wAE1H2bW/6/RP/KhgfK77djRYfDtj5bGFErDw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 07:17:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 07:17:02 +0000
Message-ID: <2c40d592-71ad-4bce-b9aa-1918d0e7dd6b@amd.com>
Date: Thu, 15 Oct 2026 09:16:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/gmc_v11_0: fix flushing mmhub by pasid
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
References: <20261014150521.2766488-2-benjamin.cheng@amd.com>
 <fa3027ae-12a1-4a9c-88b5-f63c929853a2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <fa3027ae-12a1-4a9c-88b5-f63c929853a2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abcf9c0-97b3-4a72-867e-08df2a8c4f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lfXOXkCxqBrRs+gnJ0aBZsrKhgAteCS3ojAT7ANhgByykaKMwkxMye+reX/GNbUyZnCtqzRT7HCzwBEF7aHfUHZ52VwkyKYK+9DXzw40pueVVXNs26tBVHxWUcjf59w3ob4Bk2UxHxJ5RTgMbkS7OCvlbBtYHSbwWKVRnB7SV2SSRABZ5vh1iFCwyl+xJeuqH8UZpRPFPqlWGajVSG8dMXUS/0tpf6/GK0DDfdw+f2a8AK4QZbZlL9wJQRVOCKI9Wa/vhCDaayrbWisFMOfUoGJ55tYkOpwhIufLoH/M9th/k3GC3RLwy3ENTFnQxcBK5wY1PmrnxMbu6mAuRgrTIPBypv0Hvcl19n4/eea7Z1WsbG8FP9l7gyvqAhrRpcMA4UiZib6yfynw3JADNWmvc1P+xWmfX1zPHy4oB2Dc/Eg0+D+XFZ/fHvKSEfuHYHoq2mR47dOu4K+qbksC1i3pUwoD/1D6gd/aXbNIZChNnWBKLYtiMswMRggbq6QEE+1BA+NX1OhZFm4Oz6e6ed0ww75r0T16TpLHt3dxxyCGzt3x8FLvREN+8STJX8Q2nFuFFvYkdDcRsS6YvIpQKYNCBEKtLQqPISlhyk2LVqABp+MZJLMX0/IWMxcySY5WA7SIKVxt1Tz5aoUXF5a/7Xjqfgt0BnqapdC2TdFXIRKsP1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hVZytESnRjdjRCTlZFYjZsL3BxR2JXN205cGhyWWlVOVVJbWVGNGI5Rmlq?=
 =?utf-8?B?KzJMVTY2SHhBMXI3ZFNZVEhJL0xCcUYzcFlpamZMRThQUSs1WU9hM3RUcVRX?=
 =?utf-8?B?UWgwd1lSbi8wTGNnNmZCdWFTRWlHNk1zZVo3ekhaNDZtd05ZNWRwajJGQ0Ev?=
 =?utf-8?B?ZnBIRFpyakRGSENWSmsyYTJYaFRqVVNnamxIUGhxdEg2SkxkQ3BJMWhUTmlM?=
 =?utf-8?B?cmhMV0k1bTZHRlY5THc3N3RVUjB6dkJSbTFKa2t6Ykd1UEl1Ynp3a3FqQkh2?=
 =?utf-8?B?RlRlU0x2NzNCVGZQRDZXekwvblIzcW1iMTR4MW1LT2ZhbzBZc1VVZVZhUHNw?=
 =?utf-8?B?RW5ibDQ5dTlJZHQ3QVpYMzZkeGhoTzh2L2t5UCtJRUJ5bGpBajE1QWlGbGpp?=
 =?utf-8?B?MmdOU2lncXpubzZsbW5PbDNSN1NCZWcvVnAwWW1oRHU2dEo4bEk1aHdCUWlG?=
 =?utf-8?B?NGs3VDFJbVVMVWthcUp1WTkvUUwvcUdtRDhxR1NRd3pMTFhzTGhJT3hzbTJp?=
 =?utf-8?B?Y3ZrbGdYTFNxQWxkQ0xoalQxVHB0L2hhRzFQVlNrdHJBclp1VFhQS3NOZ2dF?=
 =?utf-8?B?ZmRidzdrUTJ6VTF5Mmc5M0ZXUmZwS01LYWpzOVhkSlE3alp1dWhMN0tCSjdh?=
 =?utf-8?B?QVVaQTg5bUR1aGFXUVNhay9pZFJPb3oycGdNenVXdnJXV01jQ1V3UUtST3Fk?=
 =?utf-8?B?UHE3ak0zeWJEYzJ5OFNTUlVEYXVaczZCZFBHSFFtM2tQS1d4d3dzeTVpbnlo?=
 =?utf-8?B?aitrRHVpamM4RnFrczlDdUxDVis4RlFEK1dMM1J2K3dRVkdtVHJ0djc3NG8w?=
 =?utf-8?B?M1VVSk03aG9ndWNLQ3k4alZCYnpBa1d0aHZqbDN4cHN0YlRLNWtQbzN0WXR0?=
 =?utf-8?B?U0Fpa1EzZ1VGSnIwRjd4QmlRNEFsb1lRZFJHZjNzYjJHK1BTZlNnOWs4TTI0?=
 =?utf-8?B?Q3ppWnhpeDloQWNsanltazJmbWl2NXUrZzRobklPTGhqWTFhOG1ycldHZkpX?=
 =?utf-8?B?SjJEZGE0NGZMakI1a25VcTB1dFRzUklveFFJczk0VFdQcVJRc2xmQUpBN0tl?=
 =?utf-8?B?cDMyRjR0NWFReTNpdHFLRGpDSlZRZEhqWmk0SXRLNElHMUxoMHJMcTMvdHpW?=
 =?utf-8?B?OXJ4eCs5UHNKRmI3RkYyOXlDYkVrUEl6dDRpbmk0c3YxOHpPRFRnaVYyU1Q2?=
 =?utf-8?B?dk5pY3VJNnNQVWEwT2ZxOEFoTFdXb2hVWnpidy9FRXZoYUxCK2srdXJKaGtK?=
 =?utf-8?B?aEhjMWtFYWZlY2YzdWNHdFNxSkNhd2VTSFJHTnhoaFpqMFpFNGFWY2RHYk85?=
 =?utf-8?B?aG1lL1FCd0xGM1VTSVNCM2ZNR3cwcm56Wnlidk50eFpPMnRRYzduSU9KSUhy?=
 =?utf-8?B?c3BLbFFnd0U5YzN6a0dFSUNQZHQrdGZMRnEzNVptejdzVjg5bFhmemxPdUVD?=
 =?utf-8?B?TGRPaERSaTdoOW1lTFVPV05kUHBJVUlEbUFLWUVzS0RhaFhzUmVDSmdZSTZR?=
 =?utf-8?B?SmwxdDN1NDE0L3FIYThIZFF2MFBlN2lkSlpIUitVcTBHbXBwTjUvTng0MjQ2?=
 =?utf-8?B?STdaa0czNWNwWVlGWWdMSy90blByRXZrdnl1bWEwSDRPQnlqRFI5T0NiTEJ4?=
 =?utf-8?B?bk4yWWEwdU8vNzd0UFZyZkdmMGdOUnBuTXVlN0NzZE9aN0FUOTczTXR0d1VS?=
 =?utf-8?B?SFpGY3lNeXNnU256UmVxZGhHTEJsTlFyeXlralpQV3hGNHNuZWF4K3dtSlV0?=
 =?utf-8?B?dlcvWjFVcnlKS01GYzF6SlVrUW1QWXNHNDNRRklvRVh3WE5HSmRYbld1aWNo?=
 =?utf-8?B?Wi9qbkFMWUgyeStyZ1IxYWo3RjVqMHJCQlQ4Mm1wRk94eUp0Rm5lbmFrd1NN?=
 =?utf-8?B?UnB1cndDeVNWNy9WTTdlQzBUMzRhbVlFVVJEajd5S2NhZXFuWkdUaVpkTzEx?=
 =?utf-8?B?WmxPTC9uZ0lDMjVXam82SlVqQy9pQTZrcWpDamF6eTEzdWxYWmVjVk9jd2VZ?=
 =?utf-8?B?bE1xdmd3T09weVhLdTBjU0FUREY1TEZJa2ZERzViYWlSVzgzNnQ1YkQ2QlJi?=
 =?utf-8?B?VVZjV3Fjem4wZHdENVBUMno0VVhvZGVWa01EY1JjeXNSVHFmZEtDRVJNQ0hD?=
 =?utf-8?B?U3lhdUFwSE5QN24zNTIyQnF4ajdTc1BaT3dwV2RXMGlqMDlnZERlbVc1K25t?=
 =?utf-8?B?R2ozU1NoUkRSUmN5RHE4cVFucGgyK0NqdHJhQ3BKMUJOZ1JIenZzVHMwYkZR?=
 =?utf-8?B?MVhSMDJPemRtT3Z2MktMWmZodHpubTVkcWlZeTlnSi82UFNhRVFlRHQ2ODFz?=
 =?utf-8?Q?x2kdBaWT/N/2bK62NT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abcf9c0-97b3-4a72-867e-08df2a8c4f5b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 07:17:02.8161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLax55sVavAUbPCzkMIKaNoA5UDaCHkKq4C04FajFcpMeyx2hy71OnXF6ewmaaaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869
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

On 10/14/26 17:19, Benjamin Cheng wrote:
> On 2026-10-14 11:05, Benjamin Cheng wrote:
>> Each vmhub has it's own vmid to pasid mapping, but the code was assuming
>> that a gfxhub vmid would also apply to mmhub and flushing mmhub using
>> the gfxhub vmids.
>>
>> Instead we need to find the vmid mapping for each hub individually and
>> flush with that.
> 
> 
> gmc_v{9,10}_0 have a similar issue, but at least by my reading they won't be affected since only KFD uses it there.
> 
> gmc_v12_1 might need a similar fix, but I'm not sure how it plays out with the IH_VMID_LUT_INDEX. I'm looking for some advice on that.

As far as I can see the fix is currently unnecessary on gfx11 and gfx12 and only academically interesting on gfx9.

The per PASID TLB invalidation is only necessary for VMHUBs which are used together with userqueues, e.g. the classic KFD user queues or the new ones for starting with gfx11.

Both variants only support GFX, Compute and SDMA queues at the moment, so only on gfx9 where the SDMA is connected to the MMHUB we actually need to invalidate the MMHUB as well.

Now on gfx9 the HWS always uses the same VMID for all VMHUBs, so the current handling is actually correct. It is just extremely awkward and not documented at all.

We could argue that we are going to need this when the MM engines start using userqueues as well, but a) I currently don't see that in the near future and b) we then need to use the MES for the invalidation.

Talking about MES we should potentially remove this code altogether for gfx12 and rather make sure that we always use the MES packet to do this.

Regards,
Christian.

> 
> 
>>
>> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 47 ++++++++++++++++----------
>>  1 file changed, 30 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 709c3d1b9998..715ccce8e4eb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -204,10 +204,25 @@ static bool gmc_v11_0_use_invalidate_semaphore(struct amdgpu_device *adev,
>>  
>>  static bool gmc_v11_0_get_vmid_pasid_mapping_info(
>>  					struct amdgpu_device *adev,
>> -					uint8_t vmid, uint16_t *p_pasid)
>> +					uint32_t vmhub, uint8_t vmid,
>> +					uint16_t *p_pasid)
>>  {
>> -	*p_pasid = RREG32(SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT) + vmid) & 0xffff;
>> +	int reg;
>>  
>> +	switch (vmhub) {
>> +	case AMDGPU_GFXHUB(0):
>> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT);
>> +		break;
>> +	case AMDGPU_MMHUB0(0):
>> +		reg = SOC15_REG_OFFSET(OSSSYS, 0, regIH_VMID_0_LUT_MM);
>> +		break;
>> +	default:
>> +		/* There shouldn't be any other VMHUB. */
>> +		WARN_ON_ONCE(true);
>> +		return false;
>> +	}
>> +
>> +	*p_pasid = RREG32(reg + vmid) & 0xffff;
>>  	return !!(*p_pasid);
>>  }
>>  
>> @@ -330,24 +345,22 @@ static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>>  					  bool all_hub, uint32_t inst)
>>  {
>>  	uint16_t queried;
>> -	int vmid, i;
>> +	int vmid, hub;
>>  
>> -	for (vmid = 1; vmid < 16; vmid++) {
>> -		bool valid;
>> -
>> -		valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, vmid,
>> -							      &queried);
>> -		if (!valid || queried != pasid)
>> +	for_each_set_bit(hub, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
>> +		if (!all_hub && hub != AMDGPU_GFXHUB(0))
>>  			continue;
>>  
>> -		if (all_hub) {
>> -			for_each_set_bit(i, adev->vmhubs_mask,
>> -					 AMDGPU_MAX_VMHUBS)
>> -				gmc_v11_0_flush_gpu_tlb(adev, vmid, i,
>> -							flush_type);
>> -		} else {
>> -			gmc_v11_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB(0),
>> -						flush_type);
>> +		for (vmid = 1; vmid < 16; vmid++) {
>> +			bool valid;
>> +
>> +			valid = gmc_v11_0_get_vmid_pasid_mapping_info(adev, hub,
>> +								      vmid,
>> +								      &queried);
>> +			if (!valid || queried != pasid)
>> +				continue;
>> +
>> +			gmc_v11_0_flush_gpu_tlb(adev, vmid, hub, flush_type);
>>  		}
>>  	}
>>  }

