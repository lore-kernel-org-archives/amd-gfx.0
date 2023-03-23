Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35AFC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Mar 2023 09:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E0CD10EA55;
	Thu, 23 Mar 2023 09:49:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E01310EA55
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Mar 2023 09:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsK2tM+Y8MGoDeH1Gbu3R/6OJ2GfRl6icNA+9ygJXXuEPDjYtzgMRDMYKmMYPhgOFyaDXUBgcU1peeV/a8sSWaa355rajXFgosEZiWAhYkhOiBSukL2OrBezVkhMB5gOrU3QDNKrygQVhcryWZZvdWes92+bGnIeneeQEf0D7G73joLhvn/YKj1Qm0q/T+ebHuoFLeUFLe6tYzxO2BQ/ectHk3mTyO8+6HZwxXfFf6EoQSI4Ew96MNIbG1o4aTU9nvSBcQ4v4+kPmN+WH/GGf2E6Y03/YtxRpGrUaWQA1uhGkkKFKv08xxaXjg0NBwnaAYQHKNjlVEIu6ZQphS6OKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdB783EZoLN5+8dGakoDLhrdG5+e/6OMWuskWT7mGjU=;
 b=l+EPeNKqIV7AORtniCb7jiGWTU5woyFKcjDknPt9DdEhiTYPxeX53j+tv2/QopKQTR80FrRya/nph1RLV7i5/ycPg1JoOzo76ReJjwodOmntwqrqnOMv1ogMwr6OL/6s6oQktMHx5iZfIlhcO21q4Vz2mfPdBIGo4s6ZI2o3nS1XUA3kvlZyp1yHrninRXa+fIKayMtDjJgXd/y8rvpgTFH0xcNd542ixytcG/Eh03lAdBGl0MN4wg+5aIitWiUPKTgUocMv3rTF9QlxBaAFYEyqqxWb9KKGgfvV1N/hDtgfA+uaUwpOL9nSwQs8ELA1afWcVCUnkp82uTg+uvGZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdB783EZoLN5+8dGakoDLhrdG5+e/6OMWuskWT7mGjU=;
 b=zJnI0ijQB9zsQgFcDesekAT3sLMZzCY2tVDyi3jOd/P/v6kP3KeCaN0iGxXt3EdZd2mAiGFnrDCSpYmvfM0QZ0zprTbu6DRDMVyv+13LVTiVUSv7WJpinmmjp+N+mc3L3alqVpeCZE3DDEmOYe2QoWOMzv3TZwhFJNuwOs3hRg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 09:49:10 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 09:49:10 +0000
Message-ID: <fcd4b506-e03f-a1c1-5a89-af896b5e9fbb@amd.com>
Date: Thu, 23 Mar 2023 15:18:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable message to
 pmfw
Content-Language: en-US
To: "Yang, WenYou" <WenYou.Yang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <20230322091607.1609145-1-WenYou.Yang@amd.com>
 <20230322091607.1609145-3-WenYou.Yang@amd.com>
 <94cea821-dc35-4324-6b65-6ed82a55b442@amd.com>
 <DM6PR12MB35319D3D541B075510AFFDE1FD879@DM6PR12MB3531.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB35319D3D541B075510AFFDE1FD879@DM6PR12MB3531.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 113600c7-e7c4-43be-c10d-08db2b83d9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4gagvLc8iV6EmZSZ7c8OWEEheiDM8FKNKhECPlL/ETHBgxsYM7Ry/iULPo78wTUkR0rTEqWXAdIZwokrzdMVi8XPXlT45KnfQYqlWA34jhQ0Tiv9p0DfCu7nZQHc2cozi8HRO2XrRaIN4fhLLZfKl8uldQPh5bUb46F+23FCqXwkt5QbcQnBTI6imhAwez9RxuGNmkmQyEaYlbxzSDLMjOcO5ST6v9f7Mnb+FXtrGM/sLA74Fy0ELquY2DSoWOHgt2YAa66yUZXH5umZMueWjFZ96nDo45p6ZKf5TKV4GeS7woGzKrzzVm7Xx8H5QMTXdBw9AHun8ZBjSLhhInZDarFjv46lvvHa/lVOZLUvi4X/WPENGvUhVfPj3Nb90G26Lsyk5gVJFijKEw0MBjAGeNNUz7TF/40C9H+TeIrNfRSe9wheo+uAuoaUYB2q2DdJWPTV8N0Js0mNzLt3FWQbtl1tNxUn6D8lbH4BqM040qo9yQnQ3KuW6YBZEuCza7Bp48+0erVPqLvhZUlyi39MpQ/i949dNKJlPqy4bejKIdL2b/CNklWTuNAJx7wLqbVANG7ilvyqe/sy7JFeJRhIK4N5Rh/XWuAqKdIcYHVHJjCsT4n8K4H2imGkYF6F4xlWSkHh/oY22XT3P6EpH/eKVYIjKa4bk9JzSA4WxOu3SaxzKnxaihV7knjtbVpnnJagxee5Tm25fazk3cmkSYWz9ZWQOfUV5OWoKT8Z1aiprQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199018)(8676002)(31686004)(36756003)(66556008)(6512007)(5660300002)(66476007)(15650500001)(66946007)(2906002)(8936002)(86362001)(31696002)(38100700002)(4326008)(6506007)(478600001)(6666004)(316002)(110136005)(53546011)(54906003)(6636002)(83380400001)(6486002)(26005)(41300700001)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3M4azRYWHhVenlsVlBIN3dOUGxjVVdaMkVqOFZLcVBQS253aTAxMjd2M1Zk?=
 =?utf-8?B?K0JrUkZmMlBTeFF2UXBQZm9HRU4zMENzKzg4ajZnZnBjdmdzdUhpU3YyTGtC?=
 =?utf-8?B?WDRLdk5TSUZGMml1cFNrM1kwNkUrU3YxdGZ0dkRwUUI4SWhoV0UvVWxWdTc5?=
 =?utf-8?B?bFlxZW1ucGowN2pEbDNhZEY3ZnpyR2htWjdPeGQzZWpmTE1EUmZ5NnBBZi9R?=
 =?utf-8?B?Y1NnVlJLcys2WjZZU2M4WlRVTjJqVWNrbTNCOW05RmE4SUw5L2FvNDh2MVdv?=
 =?utf-8?B?MkVrQzlnc01BTGtpLzdjSXZqTG42ZHQ1OUhSL3N3cEV6djE4SzJpME9kZmxm?=
 =?utf-8?B?TVcwMVhtMEdLcGxCRG41YTNHUXRNVDZpZzg5SHY3L1FVTzRmdUdUdmlocDlq?=
 =?utf-8?B?U29BbFdnODVRQmNFQk1mZU9iemtJVkJjNHZmS1V0dlpFZmoxSC96M3ZFV3li?=
 =?utf-8?B?V3p3MjY1NmFCbWpIZDk3c3ZOMlk0MW1jRDd5MmxQWVUzUmZrdFllcFFaOCtQ?=
 =?utf-8?B?Y1BTWWxtNXo5UlMzNlJQVlNxRVhLc2R5K2lwQnhpd1NlZlhMVFJCMFhwWklR?=
 =?utf-8?B?Q1hCUHA1V1hvWjRUaVFiYXZBcTlYTXFaaXFzZnM2VFpTdjM4bkNVRWVoWTh5?=
 =?utf-8?B?MGhJS3UxbStObWZ2blVVOHFpZW1Lajdia1pOdUU3dlQ4NENzcTcwTlJZWk55?=
 =?utf-8?B?T1l2Zzl1OEVaaW85MGpIazdaYkxsQi9nZ3R4M05HQmJ5NllIZ3dGK0xwbXN5?=
 =?utf-8?B?WmJjT1FzS1R5RTh1Mm9IeDBLaUFqQ3B4aCthaDZyTkd4dzVFcG0yaGVubHdU?=
 =?utf-8?B?UGs3ZnRaa0tMMHJUcnlpSEd4YzJiQ3ZGc3pHaU0reFBXU25ZRXUyNGI2YW5y?=
 =?utf-8?B?b3ZWelNEdkpOd2VIR25LWTBJY1V6OFMwWDM3VHlYWk5WS1NSdHI4VEVVc08v?=
 =?utf-8?B?amM2Q1lhSk1NKzRpa0I4clhua3l0NGJCZXljOXFHYXZRZjVVeHd3TWFIcW5w?=
 =?utf-8?B?aUFnWXZ0WVRBMXJqSS9GY1NUa0s4SnJhTEhESlU2VVJNTk9rL05TRDIybGNr?=
 =?utf-8?B?ZHV1dUwzWUV4QjBOTHNITlgxWFhoRzQ0SC9hVXp5VTlsY0NJR01YTmVlSlpx?=
 =?utf-8?B?cUtnQ1ZZU1hpOURWaVNVcDhzbG51S1dtN3F0NkdYcDNPbTZwekZWNmUrY1M4?=
 =?utf-8?B?a3Y0VjBUbmRRSkxvMG1YQ3ZVNW96ZWNDNWNmQ3pQYjRLTWwvZ25FMEhUdDNh?=
 =?utf-8?B?L3ZDNlVJWjJpMk15SjgrK2E1RDJON1RUNHJ4aDR5L0cxemZNUFNRRWQ5WEVD?=
 =?utf-8?B?d3lsaW5qUUZMaDk4WHdhcTlMWXplUDZGMVJ0NVVMYmlDbVVOeGxWUHprcDRo?=
 =?utf-8?B?bW9kNTlSbEZNRFR3cElYS1dTRWEzbjJ4NUp2Z3BkOHArdWZ2ejczL0p4YWxa?=
 =?utf-8?B?Tm9tOW10YkliYm01bk5tWGN6OFRCQVg2NG1zMUtIUElrUmxyTGU2TVloWEM3?=
 =?utf-8?B?RCt5K3lkYnFJcVprUk5mWDdQU3gzcVNUNEJPSGxpM05SYUdwZjlyV3FsWTFu?=
 =?utf-8?B?dmRleXBBYXNnNzJwSlgxWEtYSncyNGFkeHduVml2Uy9SZThndzRwd2RvL0pP?=
 =?utf-8?B?cnlVa1hTNWRDU2Y4UHhCTnNwc1Bmemx2bE4vZnJrRDZ1cW44MERiak9NN3A1?=
 =?utf-8?B?OWFrYS9FekVPK25mL3ViS3ZXaEwweWpDNXFqQW16OGZ3bEt0ek5yWE41eVN3?=
 =?utf-8?B?cEw3WStYcGpRcThLN2RadlhiUzBwYS92NGN0SXhmSmJFNDRHUUdRMHNVMXRY?=
 =?utf-8?B?M1orZmRjZ1dqM1UxTkROeFZQMzk3NkQ2TlBSeFNPTHBDdEtOem9kVGN5c1BT?=
 =?utf-8?B?YS9CMW9wdTRoRVdYeVpuVXBnb1BoSDc5ejYrVlpKWC9GNG5mSDU3YUk4dGVz?=
 =?utf-8?B?NFl1R3dyNlNJZlhjQzN5bjQyMmxua0JrZnQ1cHl3dUN4Rmk5d0diOE1EK3VH?=
 =?utf-8?B?WEFKK1ZONDVEellCOVBYL1dSaTBSRVBSa2RqMGo0S1M5SCt6dEhhMGNGcXlr?=
 =?utf-8?B?dERHTXNkQmFyOXJBRFBXNWxBVXN3NGU4TlpUMGxjZTN5NGxObk9jRjNXS0oy?=
 =?utf-8?Q?rmJ1/cVCQAPWYv2MMHHAu4TJa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113600c7-e7c4-43be-c10d-08db2b83d9f9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 09:49:10.4697 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibuWI3WoSjFhJskac+nsXDP3dvRi/WmN9kn8hozwnl/5xE01m1xFm4Viail+3D0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460
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
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/23/2023 3:04 PM, Yang, WenYou wrote:
> [AMD Official Use Only - General]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, March 23, 2023 4:29 PM
>> To: Yang, WenYou <WenYou.Yang@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>
>> Cc: Yuan, Perry <Perry.Yuan@amd.com>; Li, Ying <YING.LI@amd.com>; amd-
>> gfx@lists.freedesktop.org; Liu, Kun <Kun.Liu2@amd.com>; Liang, Richard qi
>> <Richardqi.Liang@amd.com>
>> Subject: Re: [Resend PATCH v1 2/3] drm/amd/pm: send the SMT-enable
>> message to pmfw
>>
>>
>>
>> On 3/22/2023 2:46 PM, Wenyou Yang wrote:
>>> When the CPU SMT status change in the fly, sent the SMT-enable message
>>> to pmfw to notify it that the SMT status changed.
>>>
>>> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 41
>> +++++++++++++++++++
>>>    drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 +++
>>>    2 files changed, 46 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index b5d64749990e..5cd85a9d149d 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -22,6 +22,7 @@
>>>
>>>    #define SWSMU_CODE_LAYER_L1
>>>
>>> +#include <linux/cpu.h>
>>>    #include <linux/firmware.h>
>>>    #include <linux/pci.h>
>>>
>>> @@ -69,6 +70,14 @@ static int smu_set_fan_speed_rpm(void *handle,
>> uint32_t speed);
>>>    static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>>>    static int smu_set_mp1_state(void *handle, enum pp_mp1_state
>>> mp1_state);
>>>
>>> +static int smt_notifier_callback(struct notifier_block *nb, unsigned
>>> +long action, void *data);
>>> +
>>> +extern struct raw_notifier_head smt_notifier_head;
>>> +
>>> +static struct notifier_block smt_notifier = {
>>> +	.notifier_call = smt_notifier_callback, };
>>> +
>>>    static int smu_sys_get_pp_feature_mask(void *handle,
>>>    				       char *buf)
>>>    {
>>> @@ -625,6 +634,8 @@ static int smu_set_funcs(struct amdgpu_device
>> *adev)
>>>    	return 0;
>>>    }
>>>
>>> +static struct smu_context *current_smu;
>>> +
>>>    static int smu_early_init(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>> @@
>>> -645,6 +656,7 @@ static int smu_early_init(void *handle)
>>>    	mutex_init(&smu->message_lock);
>>>
>>>    	adev->powerplay.pp_handle = smu;
>>> +	current_smu = smu;
>>>    	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
>>>
>>>    	r = smu_set_funcs(adev);
>>> @@ -1105,6 +1117,8 @@ static int smu_sw_init(void *handle)
>>>    	if (!smu->ppt_funcs->get_fan_control_mode)
>>>    		smu->adev->pm.no_fan = true;
>>>
>>> +	raw_notifier_chain_register(&smt_notifier_head, &smt_notifier);
>>> +
>>
>> It is not required for every dGPU smu to register for and process this
>> notification regardless of the system they are in. It is only applicable for
>> vangogh and hence this and below should be moved to some ppt funcs used
>> in sw_init/sw_fini of amdgpu_smu for vangogh alone.
> 
> The fixed issue is common, it is possible to keep this interface for others. So I think it is better to put the common code here.
> 

No, this is not common at all. A Navi10 card sitting on an Intel system 
or a Renoir platform is not bothered about an smt change and doesn't 
need to register any notification callback.

All you have to do is to register for this notifier inside, say 
vangogh_set_ppt_funcs or some other callback which happen during sw_init 
of amdgpu_smu.

For unregister, you may keep it in smu_sw_fini call like below.

if (smu->nb.notifier != NULL)
	unregister

Also, other/future APUs may be able handle the change internally (by 
propagating through HW itself) without driver needing to notify the FW.

Thanks,
Lijo

>>
>> Thanks,
>> Lijo
>>
>>>    	return 0;
>>>    }
>>>
>>> @@ -1122,6 +1136,8 @@ static int smu_sw_fini(void *handle)
>>>
>>>    	smu_fini_microcode(smu);
>>>
>>> +	raw_notifier_chain_unregister(&smt_notifier_head, &smt_notifier);
>>> +
>>>    	return 0;
>>>    }
>>>
>>> @@ -3241,3 +3257,28 @@ int smu_send_hbm_bad_channel_flag(struct
>>> smu_context *smu, uint32_t size)
>>>
>>>    	return ret;
>>>    }
>>> +
>>> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool
>>> +enable) {
>>> +	int ret = -EINVAL;
>>> +
>>> +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
>>> +		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int smt_notifier_callback(struct notifier_block *nb,
>>> +				 unsigned long action, void *data) {
>>> +	struct smu_context *smu = current_smu;
>>> +	int ret = NOTIFY_OK;
>>> +
>>> +	ret = (action == SMT_ENABLED) ?
>>> +				smu_set_cpu_smt_enable(smu, true) :
>>> +				smu_set_cpu_smt_enable(smu, false);
>>> +	if (ret)
>>> +		ret = NOTIFY_BAD;
>>> +
>>> +	return ret;
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> index 09469c750a96..7c6594bba796 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>>> @@ -1354,6 +1354,11 @@ struct pptable_funcs {
>>>    	 * @init_pptable_microcode: Prepare the pptable microcode to
>> upload via PSP
>>>    	 */
>>>    	int (*init_pptable_microcode)(struct smu_context *smu);
>>> +
>>> +	/**
>>> +	 * @set_cpu_smt_enable: Set the CPU SMT status
>>> +	 */
>>> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool enable);
>>>    };
>>>
>>>    typedef enum {
