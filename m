Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56270C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D2964F09
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D2964F09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729766E133;
	Mon, 15 Mar 2021 19:17:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFAC6E133
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVKyp8IBCcP+h6/+4/MFam8Ynvrbi0vt7n0/UaQs4TBbQWl5LEOz3qAe9o1L/dD5I17jHx8BLKCLFRnhhsQI7rJHIc8Jw5jLYMDr3essT0fjXY42fLClVy9u/YdN6Au+tAXXe9o6Iionl6Ncc2FmbyAHG/s+wM8eZV/PyUt93taB/Fo9UlZ4W/T6+yj5Ya/nDQ1cgrQ/mVWDvtbDeCwJmbB1OaIYQVFtHHXvTSfhT31mzItO2Zr6XzRlcR7wIp9JQejvpmQeVORcqxX9R1wOPyG5MJP//zRWPcSukWTKwYDdzYPaQw2e4OQNL8nq3ZOB8L3sr8ZMMxiZDeC6EA94Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFeCDukRMLgc/A88CFpFhX5TIlF6yLHfisu5Jhp4AMU=;
 b=BXWrec0TJvX84aBHP7DvD5kNlb+OFZd39HMN0XYt+7gP7eekLrVx1qn4JQQ0TK4qPCEBzLSU5l58qOo5SR4+UPhysRmpZLhy1h8ddFX+qYi8GjL8pI37YKcWrvFc1LivV+P3hN3TwdO6cZGV1HyxCjbCHNuxMMRQqjNAEaZPqLsnEayHVHWNZDvGHrMiMp6N9S0GrHV2FSuafj1TLHt2gaioVB9Y5esWZXlYyAxKI6uiM+zf/LiZszOhTOBX3C8+YfLD2kZgpP8o/fc0mMwKJl26waifRW9JIsrunHdRLnTlwCmv+h4ylVTWCicz+fO0YPHZumV4yTCpj63g3YOOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFeCDukRMLgc/A88CFpFhX5TIlF6yLHfisu5Jhp4AMU=;
 b=uCs4eVh5LiIOGYzPBKTraAlrBNhIQmEUkQFvngsWeHZUDiroq3qDuyMhpGWH2yGyhDKi0spHw6iqlGqg+FnymKCN677gobuBUPvtRgseLCboXwwxj/IADfwwENojFO3oEyac5BtB+01lk9Kb/Zzdk623OSCpn2KDX118W0+d1Ks=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:16:57 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:16:57 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Zeng, Oak" <Oak.Zeng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1615433344-16267-1-git-send-email-Oak.Zeng@amd.com>
 <34b7c10a-b255-36f1-4cbb-f3d05c760590@amd.com>
 <MN2PR12MB44889671D32DD33422D00820F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <d05f8abd-312b-5f30-5045-e17b7e4066be@amd.com>
Date: Mon, 15 Mar 2021 20:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <MN2PR12MB44889671D32DD33422D00820F76C9@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM0PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::47) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.190) by
 AM0PR06CA0106.eurprd06.prod.outlook.com (2603:10a6:208:fa::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 19:16:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d6b5c94-6af5-41a4-a758-08d8e7e6e6e4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB24684BA1AD3F4B5B1B6FC09D8B6C9@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jUXMWU8PcordLNNpzWEbCemuyFXDic5TKTG3wsudGubMjIV1ivmgr+ojopFsq9JPzA9R9CDcACix2A+rR2g9Z+1Zlwg7LhgDdUvvilP8tZC8qh1G7uaE0UVUUH3YAhi95coiLZ40m2MbQBHE6NVEsaMXmQGVUgEl1hYbxmmY3OOGT+MjfgcUSARGE5zNOf5ZeyF1i0envYJJq7HeK4AqLTBezGTAoD7zmWLRbQGTtRh3i3FQWw0gfKd5ahNI8Gsot+QVqhQ7hg1XUVBXrt67JkKgA+dEECDD0ohX7hHTemb8+qOp0DyvNHm5aF7MSo8U/kSITki+X4AkfJdS1aA/RsH6+BCyxMr8Oaw38l9roLtNXiwi7ve8mMvQMQ0dinfPMCXoxo0eBcEMXSUUOhlBuCxmYLlZCsURIKiL53fcH5rj5S4Yy5JzNvveWfOV0d2z1U+Cjta0OX+HJZ7aaKlvSo1X2YPN3K8kC1Vxc3HK9MJUehhlgUExfg6sPNPlFyzZkSeEDR6tnAYBeNsQrGidS3CtAJUShS64xE7C+8VHh1yv9ls+T7li0ZkShZ5RfUCvgsDnsERoNSzxTRbBCkPoRqTuFkTjzMx9R04NqBfbh4TTXJL9KXb7xOruo4WtqSgjIIOxMT6GY0Z1Yb1Epch+BMHQPXf5DULXSfjkvALbBHGXjBRDMeXjl1RIfR9cizMgfZYqKsrWUufY7qnnkHoREyP3hqHRybRafaKVTXbDv0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(5660300002)(31696002)(53546011)(316002)(45080400002)(6486002)(16576012)(66476007)(478600001)(66556008)(110136005)(31686004)(26005)(36756003)(2616005)(6666004)(8936002)(52116002)(2906002)(186003)(966005)(16526019)(66946007)(8676002)(956004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TWo2N05vbVh1ZzU1dUNLek5kVVZYZ3hSTGdZRWd5dkFXb2xTMWRtbXFwS3hQ?=
 =?utf-8?B?SFFFR2tsaUdJZzloY0ljYm1wMEZPQnNFam5IcmUvbXNxajRNL28rTnN5bmt3?=
 =?utf-8?B?d1BSbCs0SHM5VzlvM3UyM042M015NHZvNHNVeGFLOVFKN1JXSjNBdk53T2E3?=
 =?utf-8?B?ejhneERMREd5dmZveURoQnhVbk94ZVFtZ3FPK1VJbTRkYW03MW1HNFRSSzNY?=
 =?utf-8?B?ZkhZSkxuQmlBcGF5V1JDQ241ZERxV091SldGekM0L2ZRdmtkZC95Y1pGUmR6?=
 =?utf-8?B?SElsclFuRFVnK1Y5VStQQjljVlZ4eWlWZHZaaDZvRklUMEp6NDQzeVNjMUQv?=
 =?utf-8?B?SWdaeXVvQ05kdk90RGNuMnFLaFVpeE0zMUdBK0hGKzcvMjRadThsM2VtNlFk?=
 =?utf-8?B?dzFuV09Wc1VKZ3RnT256S1AvNVlnS3grQ3FKOVY4ZnhrQ21peE9CcitIOEQw?=
 =?utf-8?B?L2Q1emxzdUlwamFDRzloVlBoU1pkWUhtNUFqYXlXZG8wWmp4c09KS0JjVStF?=
 =?utf-8?B?eDdVWlZtVG9BenU3MHVxYVlkOHNtVDVqeWYxRkcvRVRqbHMyT1Nla3ZHZnoz?=
 =?utf-8?B?cE9vdUhPTmNHaTNoaXlGRGVwTklMSXRkN1RPS2s4NmhINzVIVC93VjlxeE9s?=
 =?utf-8?B?ZnM4Qm1KY2pZdXhvR3l5eXplNnd5NER0SlZMcmQveWg0dVFxN3NMMm5VZzds?=
 =?utf-8?B?a3kzMlVVN2dVNUVUdkVQclRXY0FCbElKNDkwMkY3a0EwQ3k3ZDRDT3p6aXFJ?=
 =?utf-8?B?eEJicTVLK0pZZmdweFBlYTVIVGVEak9odCsvL3Nvb0hoK0ZWRTRKQ1RVN3RY?=
 =?utf-8?B?YVVnT0dueEZ1VitUZGlpUFh6V0hvNlFlZ21HdG85L0ZLdU0xSmdpNllINUtW?=
 =?utf-8?B?NXBhV3JsNjYvT3prVG1OY2xzek9laWNvRDBxa1pERFNOYkpGSmFsLzlCZldT?=
 =?utf-8?B?SUVZR3RFMW1MbzNjb3l2ZjNaaEJXUjcwdTdCOXpxZTBnOGVkR3lCNUp6bGl6?=
 =?utf-8?B?VnA1elUyOFFPV0ErYTRPUXlsV2ZMNytBWEhmMkYrUlhZc1RJV2FPNDhYbWxY?=
 =?utf-8?B?WkZ0NklZYm9wd2NQeHBwZlJCbExtcEFFQXVrUGl2UjIvaHI1OHpzSWNoWlkw?=
 =?utf-8?B?dGo3dnFuMi94V0s4cW9wSkk3UWZCaDRYZi9Xc0ZjMEFOVmFuaEFqSlJUc25p?=
 =?utf-8?B?SzBMZTMxNHZXclUrUDhRSGJvUmNzeG9YeDJDY29mL3huZ0JDdUNocDh6d3d4?=
 =?utf-8?B?ZzRTRjZCcENzZ0tiWkRSTWZTalE2YytJWkVwYUV2VE91NUJqc2hISk5NMFk3?=
 =?utf-8?B?ZG43TzEzRElSdm95WG1iK0d3bjhqV2tBc0E1QWtVczg5eXNSWWNjQXNneVpX?=
 =?utf-8?B?bGdZTjNuY3U5ZkpRTVh0UjBaUEo3UlhtbVVnRGNWK3lQUHNTcURnQnF1Z2hL?=
 =?utf-8?B?dUhkaGJxWURmR000b0RpQUFLekd4QkxTYjd3bS9zRHQ2VEhaNWNPY2Z2Y1Fm?=
 =?utf-8?B?L1NXVFMwVTZOYWFEaksxaU9MZnU5aUUwS1pOS1pKRXZVenlJRDF1amgvUGUw?=
 =?utf-8?B?ZWQ5UWtZYVhSSWZ1QjIxRG80emlvbzhlME5qRFh2RlMreFkvZCsxMllPcmtW?=
 =?utf-8?B?c2V5aDd6Sno5bHZUc1A5NXlDbXBrMEdLRmoxMCtxaHMyekJYVnhVYzJ3NU1H?=
 =?utf-8?B?OVBKaFNRMnNlNkxMU2RCMkxhODV4TDdnM3JhazFUR1U1SWp3TktXa2ZRUGpm?=
 =?utf-8?Q?AsKVtPkwZg/CpjIkk4m16z9kxSrPzzR4EWTcmKE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6b5c94-6af5-41a4-a758-08d8e7e6e6e4
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:16:57.6493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDs/ZwC98nB8ln9qRdh9fosYwhDV7z6K71Sv1lkj4nZ7rhtm7l/7AH0eLNBRjbhr9vLLyRYxrUPWiB+tzP5f9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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

Hi Alex,

On 3/15/21 7:46 PM, Deucher, Alexander wrote:
> [AMD Public Use]
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Nirmoy
>> Sent: Monday, March 15, 2021 2:43 PM
>> To: Zeng, Oak <Oak.Zeng@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdgpu: fix compile error on architecture s390
>>
>> Wouldn't this restrict amdgpu for only x86 platform?
> This particular case will only be x86.


If I understand correctly, we map all the VRAM at startup to avoid

mapping each BOs. Can't we do that for other Archs ?


Nirmoy


>
> Alex
>
>> On 3/11/21 4:29 AM, Oak Zeng wrote:
>>> ioremap_cache is not supported on some architecture such as s390. Put
>>> the codes into a #ifdef to fix some compile error reported by test
>>> robot.
>>>
>>> Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
>>> Reported-by: Kernel test robot <lkp@intel.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> index 37751e7..1091585 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>> @@ -1817,7 +1817,7 @@ int amdgpu_ttm_init(struct amdgpu_device
>> *adev)
>>>    	/* Change the size here instead of the init above so only lpfn is
>> affected */
>>>    	amdgpu_ttm_set_buffer_funcs_status(adev, false); -#ifdef
>>> CONFIG_64BIT
>>> +#ifdef CONFIG_X86
>>>    	if (adev->gmc.xgmi.connected_to_cpu)
>>>    		adev->mman.aper_base_kaddr = ioremap_cache(adev-
>>> gmc.aper_base,
>>>    				adev->gmc.visible_vram_size);
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
>> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6fab18a743
>> c84b8abbd008d8e7e21e10%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
>> C0%7C637514305648085244%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
>> p;sdata=KLYRSc45rllptRvyiOF18qA9IFt5zAGXL1zsHasgdLs%3D&amp;reserved
>> =0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
