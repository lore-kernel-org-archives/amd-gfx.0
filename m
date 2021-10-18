Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB1BC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B69D6008E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 10:47:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B69D6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1BA26E9D2;
	Mon, 18 Oct 2021 10:47:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0ADA6E9D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 10:47:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVAA/vIBeCpQb7aWRUJcdzHgEXk+LkLICBKo4a6bx9VnQUBh9SVyIbA+DRNLOm/W60AsyioldKogc4KZlHpH0uSCtvnWrFuRIo6RMa93gDem0zQSjmVwu+V6FTcX/G6A3fZNnYaU/vShu+Z1LpU5fSqcVhv19cWgHELqvGbyHoiq31ASILKGq5IauHIyOJBaN3wtxR9crgr4Xq76S17VTTVWkKCFj/4jEPsbBbVxa4B05ruUreFXoQK7vb9zDUu8X/XIrHK/Rc1lh9rW4Vs6pNwe7sZp7XbpwmIqIWvFlRgxB8xS+D5YsOonsCTaWI9CwlsTt1AkMrpj0S4LkukfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6S659FbNc5TL/dsKFz96uUxGEtMsw3n1bLJ4EzoqMmw=;
 b=bHZlegjwJ2VSsUla9pR+xXWJ4RP8gXdS8gsxcKoMNRa/uGqOfTapymEJ0itCr7md17LKsgYXS2XIk1j2dIshS0QVJ9f1n+vhluluvwXx8hnv9zvYtCLdUM47Yq1Pa73cVzqwO3Br1npvsf5wyOwIgPAN0EfEYxX1mJqCqd3bKLzNlGsrfUlGCq+bzClnakTZ/jqALalw1irMEm19SyhFWM3oL3E18fTgJf7NN8r4aFGE5fD36AgWijflC6g9t2h5W5SkBuBK1/3H6GJga16GplGZF3IO/OEhjRxQpnvWk1kohKp/+cDycbKUTS1tNswHNiG51bqOT3K22oS0DhYQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6S659FbNc5TL/dsKFz96uUxGEtMsw3n1bLJ4EzoqMmw=;
 b=4oLUbi+oCm8qvMdqj8R11EWG5fF3K1fvPEKHXkCcQGUwD/0aIKWZSbdG9rpA0/G68w2o4RtLmqpzeP3jMFO380jCshvOkW1qrHRdLtHGCwcNJpsuI6QHV6P+1tJoKXqu7dPkM6JRfogSUJiiu4OIdwt06rl+u+RO5B4gsea7vys=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 10:47:35 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 10:47:35 +0000
Message-ID: <1bae8d09-ebe4-6b1f-aef6-e39905a441bf@amd.com>
Date: Mon, 18 Oct 2021 16:17:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to UVD
 suspend failure
Content-Language: en-US
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "bp@alien8.de" <bp@alien8.de>
References: <20211018073432.1525697-1-evan.quan@amd.com>
 <c995c339-1b9d-2a8d-930b-ae48ffe44b99@amd.com>
 <DM6PR12MB26195457A0FA18D65FA93DDDE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB26195457A0FA18D65FA93DDDE4BC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::8) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0086.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.14 via Frontend Transport; Mon, 18 Oct 2021 10:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21e07a0e-cf20-4412-6e51-08d99224b1f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB425078B4A73828D9B2538CD797BC9@DM6PR12MB4250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51u0HJibvrtNRDQySB0q2B7rCYMavtUwtq44C0ChiVi9BfLaZrZUJHP98Cnv8L7ZwB+p1rFU5QvfrShjR4iZXIBFzyZujplvx4EkTg42BOcdR2/2oDS5UdfvejUDp2y3s0bVQtLdgKzGXoawDsCPYOgQcSDln9cPcYvwCjZa/+PXQK52ecoh8dLOpih2f38bbAp4JEljuhJUZ6VkTRbgyBZOKYyfsotW90MbED6WxCVp3Z7EVTLbfvs0za82RR2bOFBneWt5Rdpo5cFCYJdQknl4JR6lfEb9XnhKBYDANf/qCXDITZH3bETizyVIqcpYvuaG52e/LEgQ6WYiVC4tF8wUdtTA2mt282Ab4z4CmHZH1bhfWrC0gBmcubSSk7rLWQs/YPm2osit/A0P4fgEItFZv8FNPZXSccKtRsIc2Ja9rgokiqqixpno2/wU/AqPASE0uLCz9EVsvHB4oMxLdLI4dkR6RqgFbaCq3wG5BdIpgOgJdCO98Vywj6glOjDKdOHoDCy2S+oodGbESJDYAPjOh895KuJrMkCgTugeZ7+ME9TR98JkKScc0bQnztSP9iDTg8tQZfCJsoafvI0zS9dAwg/7e8ZswMEpxMmrsz2ocRNsZE0kNdaEFiorNfsUf54nXVUR4Wjx68f1RCAIE2KjnyGNLT3vMyCaaKJhEploaYvSMZvfCOW9XOH3zuuHoyCO3OBr2Mu6ef548UbLIlLC6hLZLFylZj6LhAic/C4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(2616005)(956004)(8936002)(26005)(66476007)(2906002)(508600001)(66556008)(4326008)(15650500001)(53546011)(83380400001)(66946007)(31686004)(54906003)(16576012)(38100700002)(6486002)(8676002)(31696002)(316002)(86362001)(36756003)(110136005)(5660300002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpxekRoM3RUMmpqWkZ5U3Z5NVYwdGpucFRVM09OMGRmb01SbHBUOHBoZmk2?=
 =?utf-8?B?Vm1JNldwOUJ4VzhSeGU1ZW93NE9IeHlVYmRQK21mYmo3ZlZPeW9CYlFwYlVz?=
 =?utf-8?B?Qm51Y2srMzJaR2pOd1piR0tnYjd1KzhzZ1ZQa2FHdVUzeTFwaXBZZnJGWnNH?=
 =?utf-8?B?Qmd5dnJTRTgrTHZHSmdUVG82bGVoNjdQM0dzOVFuMVp1c0JLK1B6b1oyeThq?=
 =?utf-8?B?d0phNVBZMGZVbEtHQ1F4Z0M2Ti9rTzgwV1ZteU5pNG14RGFNSmJxOU9xM3Nr?=
 =?utf-8?B?eVMzMyt6RjR1L3dRRldkQnBOemRJSzhmclhEaWlqdmlGTlUveHM0V0cvT1pG?=
 =?utf-8?B?aCtpRjE0eVFxT2t4Q3Vrc1hORXNabFFwQ3llbFd1bm5KWEhmMlFIQjR4VCtS?=
 =?utf-8?B?YXg4U1F0TWVmWmIvb1d1VFFrN05iSmlCbk5wYW1rak1lcUdGbk16ZFk2YzM4?=
 =?utf-8?B?ODJBU2R3SnYvR1g3bDE1bGhkcXl0S2hyRjF5WThIMmxDSUFscjdxTCtBSldO?=
 =?utf-8?B?M1laQU9lUm5HTVVnVUlTdmJLVTlucHBZSkZ5bUhtT21sQXZOdDF2T0ZWUjhn?=
 =?utf-8?B?eERGZGw3MSs3d2gzZEFhY3YvRFlESXlENFJ2bk01MVd2TTQ1a25NMm9SbzRk?=
 =?utf-8?B?VXVmdGhwQ2pFRjM0RTFPZmJLRnVDZUhiZTFWdTJYek4xdTlJbkFiVURCUGZr?=
 =?utf-8?B?dHMrcmRTSFZUL0FDbFVZYWVPQk5uYm5RWFhXbjVIOG15eHNzVWpoeVl1dWVp?=
 =?utf-8?B?RmxCMXBQTGtSU1dWdWZodTlNODZyekU3ay94Ykw4VHhYQlZXUEpLc00wdk5F?=
 =?utf-8?B?OElNcU5TRjNLb21vdXlMeG5NZU94ckF2cnNaMlBoNDNUTEsrTERIV2NFLzly?=
 =?utf-8?B?WXdNOU1jZ3R3V0xRQldmZ0VZbWxSdlZtSjJsbXNLblpWbjdqNHBlNERzTFZt?=
 =?utf-8?B?U2VVK2tnMDJ4NElpTHRoSC9DK1Q4KzN0WjNySngwcTFyK09nbXFiSnhld2xT?=
 =?utf-8?B?WGd6aVdMYUdCanFMM2I2Q2c4SWhPN2xvaE8zWWJXanA0dGF1Tnd3UDNObjNN?=
 =?utf-8?B?cU9TZElZZWlaV2RrSkdnUjNCa3NQMXBMeVhObTN6TFpJbDIwa3JoTi9Belly?=
 =?utf-8?B?V3Z3OXZxdFRFQzk4dExWd3FKYXIybXhicytQUWVIMjJHYjh0TDQ3WVM0TlJz?=
 =?utf-8?B?NzJENlFwU2IzRE5QTkppR1RNSDBydU11a25EbGtXY2srR0tmUEFlRHBkTkUv?=
 =?utf-8?B?b29pLzVyQ241amhQa2dEeDBhTmpzL3BzVEE3Rmt4UDJUbTVrTFc1cndNeEpN?=
 =?utf-8?B?Z0U2bkk2SWg2RmxXUVRIbGdxZWJhanZCbUtreXhkZEFBaHB1ZnhTSk5sVjJZ?=
 =?utf-8?B?NCtKZGtpT090Ky9udzk5RFdIOVYra2VwV0F5dE5LZWFtdVREaWNyRHRsNDNm?=
 =?utf-8?B?amwxSTgvOVpwL0FvNy9jbHE0M2NkWURMT3NKN2Y3a2RITG9RS3l4RU1FNHhW?=
 =?utf-8?B?Q1BPb1FCL2dTeVpuOHUySmlUUFRBK3d0cjFxZHNGTytlK2xiUlB3aTBObzRs?=
 =?utf-8?B?YndPVTZmS3BtMmg1N1hvNmQwUXpHdEYySzMwU1hPbjZZMytGYWJlMUZwTXBY?=
 =?utf-8?B?eGFicUE5OTEzK2k1dkdQQ3ZENGJ1Nk1HaUFCTC9TeWh5cWsrS3A1akdRRDZZ?=
 =?utf-8?B?MGxjWDhncmlIRnRCTHp1MWJqUEJCVHhnTHpJUmVNNDJFWHcxY1lWSndsUjRo?=
 =?utf-8?Q?Z8qBOXTbrscG+oFxIFYhJgtJK/5yJIqjVjLCZ0U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e07a0e-cf20-4412-6e51-08d99224b1f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 10:47:35.5382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPtbmLDc7UOPV6qtnoi5D6D8biEIy+e/wvhmueN8+PKEqklqBImzlEzOfK8F/Zv/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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



On 10/18/2021 3:21 PM, Quan, Evan wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Monday, October 18, 2021 3:58 PM
>> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; bp@alien8.de
>> Subject: Re: [PATCH] drm/amdgpu: fix the hang observed on Carrizo due to
>> UVD suspend failure
>>
>>
>>
>> On 10/18/2021 1:04 PM, Evan Quan wrote:
>>> It's confirmed that on some APUs the interaction with SMU(about DPM
>>> disablement) will power off the UVD. That will make the succeeding
>>> interactions with UVD on the suspend path impossible. And the system
>>> will hang due to that. To workaround the issue, we will skip the
>>> UVD(or VCE) power off during interaction with SMU for suspend scenario.
>>>
>>
>> The original issue reported by Boris is related to sytem reboot and hw_fini
>> calls (SMU is hw_fini before UVD/VCE). Boris also mentioned that it got
>> solved by reverting the disable DPM calls during hw_fini. So, I'm still not sure
>> how this is related to suspend path.
> [Quan, Evan] hw_fini() was not on the path of system reboot as I confirmed. It's different from the issue Andrey found(during driver unload).
> The call flow for system reboot is: amdgpu_pci_shutdown() -> amdgpu_device_ip_suspend() -> ...
> 

Sorry then I misunderstood. I confused it with pci_remove and the 
hw_fini sequence. It was suspend() calling hw_fini() then.

BTW, is this unrelated to the reboot issue then? in_suspend is not set 
during amdgpu_pci_shutdown(). Wouldn't it be better to skip uvd/vce 
poweroff when their DPM is disabled?

Thanks,
Lijo

> BR
> Evan
>>
>> Thanks,
>> Lijo
>>
>>> Signed-off-by: Evan Quan <evan.quan@amd.com>
>>> Change-Id: I7804d3835aadbc7cf4b686da4994e83333461748
>>> ---
>>>    .../powerplay/hwmgr/smu7_clockpowergating.c   | 20
>> +++++++++++++++++--
>>>    .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 16
>> +++++++++++++--
>>>    drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c     |  4 ++--
>>>    3 files changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git
>>> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
>>> index f2bda3bcbbde..d2c6fe8fe473 100644
>>> ---
>> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
>>> +++
>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_clockpowergating.c
>>> @@ -57,7 +57,17 @@ static int smu7_update_vce_dpm(struct pp_hwmgr
>>> *hwmgr, bool bgate)
>>>
>>>    int smu7_powerdown_uvd(struct pp_hwmgr *hwmgr)
>>>    {
>>> -	if (phm_cf_want_uvd_power_gating(hwmgr))
>>> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr-
>>> adev;
>>> +
>>> +	/*
>>> +	 * Further inactions with UVD are still needed on the suspend path.
>> Thus
>>> +	 * the power off for UVD here should be avoided.
>>> +	 *
>>> +	 * TODO: a better solution is to reorg the action chains performed on
>> suspend
>>> +	 * and make the action here the last one. But that will involve a lot
>> and needs
>>> +	 * MM team's help.
>>> +	 */
>>> +	if (phm_cf_want_uvd_power_gating(hwmgr) && !adev-
>>> in_suspend)
>>>    		return smum_send_msg_to_smc(hwmgr,
>>>    				PPSMC_MSG_UVDPowerOFF,
>>>    				NULL);
>>> @@ -82,7 +92,13 @@ static int smu7_powerup_uvd(struct pp_hwmgr
>> *hwmgr)
>>>
>>>    static int smu7_powerdown_vce(struct pp_hwmgr *hwmgr)
>>>    {
>>> -	if (phm_cf_want_vce_power_gating(hwmgr))
>>> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr-
>>> adev;
>>> +
>>> +	/*
>>> +	 * Further inactions with VCE are still needed on the suspend path.
>> Thus
>>> +	 * the power off for VCE here should be avoided.
>>> +	 */
>>> +	if (phm_cf_want_vce_power_gating(hwmgr) && !adev->in_suspend)
>>>    		return smum_send_msg_to_smc(hwmgr,
>>>    				PPSMC_MSG_VCEPowerOFF,
>>>    				NULL);
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> index b94a77e4e714..09e755980c42 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
>>> @@ -1247,7 +1247,13 @@ static int smu8_dpm_force_dpm_level(struct
>>> pp_hwmgr *hwmgr,
>>>
>>>    static int smu8_dpm_powerdown_uvd(struct pp_hwmgr *hwmgr)
>>>    {
>>> -	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating))
>>> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr-
>>> adev;
>>> +
>>> +	/*
>>> +	 * Further inactions with UVD are still needed on the suspend path.
>> Thus
>>> +	 * the power off for UVD here should be avoided.
>>> +	 */
>>> +	if (PP_CAP(PHM_PlatformCaps_UVDPowerGating) && !adev-
>>> in_suspend)
>>>    		return smum_send_msg_to_smc(hwmgr,
>> PPSMC_MSG_UVDPowerOFF, NULL);
>>>    	return 0;
>>>    }
>>> @@ -1301,7 +1307,13 @@ static int  smu8_dpm_update_vce_dpm(struct
>>> pp_hwmgr *hwmgr)
>>>
>>>    static int smu8_dpm_powerdown_vce(struct pp_hwmgr *hwmgr)
>>>    {
>>> -	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating))
>>> +	struct amdgpu_device *adev = (struct amdgpu_device *)hwmgr-
>>> adev;
>>> +
>>> +	/*
>>> +	 * Further inactions with VCE are still needed on the suspend path.
>> Thus
>>> +	 * the power off for VCE here should be avoided.
>>> +	 */
>>> +	if (PP_CAP(PHM_PlatformCaps_VCEPowerGating) && !adev-
>>> in_suspend)
>>>    		return smum_send_msg_to_smc(hwmgr,
>>>    					    PPSMC_MSG_VCEPowerOFF,
>>>    					    NULL);
>>> diff --git a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> index bcae42cef374..4e9c9da255a7 100644
>>> --- a/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> +++ b/drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c
>>> @@ -1683,7 +1683,7 @@ static void kv_dpm_powergate_uvd(void *handle,
>> bool gate)
>>>    		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_UVD,
>>>    						       AMD_PG_STATE_GATE);
>>>    		kv_update_uvd_dpm(adev, gate);
>>> -		if (pi->caps_uvd_pg)
>>> +		if (pi->caps_uvd_pg && !adev->in_suspend)
>>>    			/* power off the UVD block */
>>>    			amdgpu_kv_notify_message_to_smu(adev,
>> PPSMC_MSG_UVDPowerOFF);
>>>    	} else {
>>> @@ -1710,7 +1710,7 @@ static void kv_dpm_powergate_vce(void *handle,
>> bool gate)
>>>    		amdgpu_device_ip_set_powergating_state(adev,
>> AMD_IP_BLOCK_TYPE_VCE,
>>>    						       AMD_PG_STATE_GATE);
>>>    		kv_enable_vce_dpm(adev, false);
>>> -		if (pi->caps_vce_pg) /* power off the VCE block */
>>> +		if (pi->caps_vce_pg && !adev->in_suspend) /* power off the
>> VCE
>>> +block */
>>>    			amdgpu_kv_notify_message_to_smu(adev,
>> PPSMC_MSG_VCEPowerOFF);
>>>    	} else {
>>>    		if (pi->caps_vce_pg) /* power on the VCE block */
>>>
