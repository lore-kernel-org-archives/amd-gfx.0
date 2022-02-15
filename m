Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D73C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 14:33:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA94010E516;
	Tue, 15 Feb 2022 14:33:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C340710E521
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 14:33:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enG2Mg4hm0F4/gzZt8UfKti2XGoRrUj06p1YNKAau8O0KrgU6xs9gYlwtBB7EShIlGfcHXIGyonq4t6kgrPQe8UVArMq5/jdWJjETg1+mEmzqA0X62f3Fw3pNFu4gsAjEUSJxC7Y2wJ5BKcBvzRVsDlcHWK8tOo83IA7QDxW9mYElCbMyUl79przeBABi/YazK+ueH3DP9uWoG+Dy5WHBkYb7jwr+gZ6+xUomD+LTTdEwATsAJI2prDbDC3dZ5gmvsGu5Wk2oCEYGWHQ4dn33yJOQG3rnyWP1pnmrrVzApBQ6UreF9JfTwM8DKpLQIWJx3zzoeutsUumrJprqB6Wvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQLS0aSqCStcobE2OIVEC4TiaUNg05k6Fu1eDslODLw=;
 b=b3EixBAogDIOrL21bEbbSWMJ0vrOuTTl44lMtoIDq7ydfoqyTBIZEVm94eDWOqGMqyRqnzt4SF0QqaY2ZaGu9sCX3rZmF3WzssqsKKn+XQ1uMRrLDvMPWq5DB7pEyTWOzSuG/19KGXYlss92uz5ibmFd87IHgMF/ZTBPbukfwQrHwvsy3KP535qnTc1r4dI8BICiPaIgJ0W0T2a8szk3WQyWdR1RhvTBR7JCDoamN6+jSzdcDTLojLjVbaOvEWD1HoSHtssxVjtgh6BDvKeF0ygmaamVq3MpbCr37bkhc6Us2R4DzhOyAunbB3zqznmtyENcFrO0JhBSHSnBi0f6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQLS0aSqCStcobE2OIVEC4TiaUNg05k6Fu1eDslODLw=;
 b=2jKEWA9ebm7sWg+ZjQa8HbJ+mgPPJ3ya+EMbeGBdDvz8npYdhDQOo0Wok/JvR42s9d6skW/3OZG0ZjQv9g8b2xP06zwT4JyBh7NGMmKNEDrC30+IZ56BzE6kqhzJNnBtvSPDGq7+5Yc8a6CpkFYNvex6TecKWy0n6clme4kYV9c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB3341.namprd12.prod.outlook.com (2603:10b6:208:cb::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Tue, 15 Feb 2022 14:33:36 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::7587:626e:3703:9db8%6]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 14:33:36 +0000
Message-ID: <62f50472-fdf3-86d0-edc0-69c56e9de24b@amd.com>
Date: Tue, 15 Feb 2022 09:33:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
From: Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add "harvest" to IP discovery sysfs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214231857.5129-1-luben.tuikov@amd.com>
 <20220214232154.6421-1-luben.tuikov@amd.com>
 <a0bd54e0-142c-a8e9-964f-25560e35177c@gmail.com>
Content-Language: en-CA
In-Reply-To: <a0bd54e0-142c-a8e9-964f-25560e35177c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::31) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3fa57d-2bfc-4440-4117-08d9f0902698
X-MS-TrafficTypeDiagnostic: MN2PR12MB3341:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB33412D90D6190F67CE244FC799349@MN2PR12MB3341.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hba5HPs6HmjDJF6/I5Xktxx6go4mZ/genMcdR6g7RyE4qgcMfMvsw/m86jafHhkPEoueGkzsTbMge5DdAIW6S7UsJhZ1yyrdIABl5mXCokTBwiW1nggIFkmbLXieWX5+nR//Y0jYyC1h17EKlmDRHwsdyK5aT6/IWimivZnIxhDWY04h7jPX3fWrZE5AXtuM3bnDs4PHYxH1TFpogPrYK5njE0/G5ol+K11lUK4UAdKwwLsw4Xnuhhrv2yHIT5F975RdWYQwMpAs6k+fR+i4FvuRGL84cqhlanmZwGNK9kVBfb/W9CqqD0bDsNUgRryfdXKmgjJKkI4jMHrHMEE45Oi42XvJUGVVtHkoMLl1x15jaY8HKKOwX7NrIwNi+aRDkRNjU2s54v8VKKsjlb1UDtwLzRioye5JJJfepHIGcPd8mLouHcsYbeq6sgA6ccau1r0rpLw64rTAMzWgrwfMinPqxcx6b81eiTpYm1cNjAgxh+u41fQR6hQ3tiUfxAv6jrqHGZMmfrpJY4XgH+5NpKf4lPPUTU191nhMK2PJk2RGnkVKJ0MKO4nSrQ2xCqXLU1MRs26CAvBbAEutr30sIVjpY9eRWtiQUjtk7pfQpMXNbjVdvwvESqlzjRlZOjCrsr4VTMaT5k4PZnUFhZlPbZuuM92gKkJ3TtIxOPel312rIvNX/Mhi1ctQY9dvl1jZC+e59NLmHfFdcOAftpSuXAAV8YlBDoJpbC7nlwBN1/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(2616005)(31696002)(2906002)(44832011)(186003)(5660300002)(26005)(66946007)(38100700002)(8936002)(53546011)(66556008)(8676002)(4326008)(66476007)(316002)(508600001)(86362001)(31686004)(6666004)(6512007)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdpRkwzMDJTWWJ2ODlHaGRweWsyYXNPakZEc05Fa1NnMzAwQkJaT3NvWnR1?=
 =?utf-8?B?a2VDMkVEdVRWVjBSU2EyeTZReGplaDFVUGkxdGR0MzRabnMwNWNDZGI5R1Np?=
 =?utf-8?B?Q1RPRjNjeS9lTGZ3a0FiN0s3SThHUHlORDJHMHZBT0ZsSFdNcTVRelNMQVpr?=
 =?utf-8?B?ZXZnZzljdCtMbDlwOU1malc3cXpXdG5KZmtBRGcwNmJBY3UvQkEwNlp3Qy9T?=
 =?utf-8?B?YVA0akhiVWdqZHEvbUIrd21OTEZZTWduZENhSkFjSDdYNUJLUG9yLzJzUXpP?=
 =?utf-8?B?UnVWUFlUODdMWERqS2VFY3NvSVpuc3MrcS9TQmFRR2o4L3drZWtQWk4xV0wz?=
 =?utf-8?B?TnZsMzNMdTFNQzAvYlJkVFE4VkJEc1ZVUGdjUlROU0ZQUDhNSmN4Tlp5ZjhY?=
 =?utf-8?B?VjFtc2pVRUJSSG94Mm85Y3FjdTdnUkl1UTAwU294QlBJcG42S1VmVGUzQzZT?=
 =?utf-8?B?b2twdHNhQUliS0V6dDF5L0taMnRlcWZFOGVWTVVnWWNYalVxZ2NxOHF0V2hU?=
 =?utf-8?B?ZzlzdGg3THczeDY0elhSb3N5cmFNVmxOQ3I5ZW4zSHFqN2N2S1YveGZvOTVn?=
 =?utf-8?B?VWZmNEs3WjVxK0o1L1V4WHRIVjN0MU5sQyt6UURHS0paanpSckx3ZHFscld3?=
 =?utf-8?B?bWFWZk9rbmh5a0gybGRoSW1BeC9qSzhkYjdxMEttMnV0V05CZWNyNnNORnVr?=
 =?utf-8?B?UVo2dEJFZ0RWZEpKOVFvLzhnOEpzRW83WGduU3Y2ejRRMVhXN1NISzl3aFVR?=
 =?utf-8?B?RS9UN2xIN1IxQ2hobTZJTjVMRDY1aGZpL0hOdXhod3AwcHZRMmpDSTZ3Q3FH?=
 =?utf-8?B?cDZqYkJNMzMzb0xUWkMzMkJvVHdNZXhUTmhiYXFBYlZyYVN1clZaZzdGdDgx?=
 =?utf-8?B?TWNVK1l1S3ZBRUhYcVF6S1ErL3pweUcvTEs2YzR6U0FHdTkvcEI2VG1Ld2JP?=
 =?utf-8?B?bm1LS1lhUzQrMU8yYzFKV1QzeE13ZDZucjVrZGtqK0dSZGo2WEREU2xQeTNY?=
 =?utf-8?B?aVY3Ukp6K2VIZTVSOWJxNFBncEk1SkZNSEtndExUczNsUm8veEZNbEhoWllC?=
 =?utf-8?B?R0wxSkhKdmFQMmZaSVdxc1krRzh1UVZYMkhjalZSWnJ4cFcvUDFpSSs5RlRB?=
 =?utf-8?B?NVdLaG93c0FERzFhcHlPSWRHZ2Rvekx5ZFpPaG1WV2NHVkUzZndoRGhzSTZ2?=
 =?utf-8?B?Q0U1MEFlbUlqbHlDU00wYm0xNmwwc2NQc0JocUx3Qzg0QVZGVVhpVDZqMkFG?=
 =?utf-8?B?SDFaTit2NlJ2UXZLNGdhSjVwNUpUVTczbGFJZExOdmpmRFYxKzBqUmphdE9m?=
 =?utf-8?B?eUJUbE9KNWJ1L1ZNL05PQWZTNC9FTWhRd0JqVitnM2M3NkxwWlJBSElyMklV?=
 =?utf-8?B?ZE4wQlcvQllrRzFRVzlJWFhkMUUrWFJVOCthNVA0QUk0bXZ4U3N4dWZhTHoy?=
 =?utf-8?B?eUhzdlk5aWgxR1RvcWJEWk1rcXA3YXB5OVpEN3EzTnJ0MFZudis4d3BUc083?=
 =?utf-8?B?a3ZSMlNSUmRFbnZmUDJhbEdDT2ErWlVIV05ZdVMyQW1Cano0RjRrVGZONVVD?=
 =?utf-8?B?YUhUcE5wVi9MMG5lUWk1UnBic211MXI3Z3l0OHhjTjNxb2wzTmRpaktOc3o4?=
 =?utf-8?B?a21idVZYSVlOMW9hUTRncmsxSUVVZldZeGZ4cVBRQ3lLMUdYdlJXaXBDWkJB?=
 =?utf-8?B?VTRHWVJaSmlxbDk1SWJMMWczdk1QczNSaFJ6ZVEwMUNhSmRSWWFBdU45MzJH?=
 =?utf-8?B?Wm5NZzMzcENuYXV2cGp3Yzk3cHRyNTh6L1dIT0xHZERCdlBZcDg0SllnOFAx?=
 =?utf-8?B?bGhERlNud0JNYkxDaVJXNlFJbUZNWGR3UUl5T1ZOZ1d3bDRpc0lDcXZkeFgz?=
 =?utf-8?B?dzg4RVNRK01JTDhCR3hqWFBRWFZBYXFjeEFzbzRuRE05NHpVbExVS3g5NTAw?=
 =?utf-8?B?amNCTmpiamdrdjg0aVIzK2ZZdUNndThRUVZEZlIvVERxSDhkT3diRkhDVnQv?=
 =?utf-8?B?L2ZvWVU1enlXc2JRWTF2K2VIcGh0bmlDUWZ4YW9idWxOVEtMWS9BOHpRK1Ro?=
 =?utf-8?B?cnN3WFVPSlF1dWJFVW4rRUpwYmJ3YXFpQ2ljcmdhM0FnMHk2ZWx0OG9FSitZ?=
 =?utf-8?Q?jBSA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3fa57d-2bfc-4440-4117-08d9f0902698
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 14:33:36.4667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc77HMwl7Qa9Co+p++9jbxobiMiExRdWz3L2n67kXkT46fDpMfvQvSkB6VBeXgnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3341
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-15 09:25, Christian König wrote:
> Am 15.02.22 um 00:21 schrieb Luben Tuikov:
>> Add the "harvest" field to the IP attributes in
>> the IP discovery sysfs visualization, as this
>> field is present in the binary data.
>>
>> Cc: Alex Deucher <Alexander.Deucher@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index c8dbdb78988ce0..0496d369504641 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -393,6 +393,7 @@ struct ip_hw_instance {
>>   	int hw_id;
>>   	u8  num_instance;
>>   	u8  major, minor, revision;
>> +	u8  harvest;
> 
> Should we maybe use bool here instead?
> 
> Apart from that looks good to me.

Thanks Christian.

I don't mind using bool here.

I saw the field in the binary data is 4 bits and represented that.

Is the field actually bool in the IP binary data?
I can change the patch and resubmit.

Regards,
Luben

> 
> Regards,
> Christian.
> 
>>   
>>   	int num_base_addresses;
>>   	u32 base_addr[];
>> @@ -440,6 +441,11 @@ static ssize_t revision_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>   	return sysfs_emit(buf, "%d\n", ip_hw_instance->revision);
>>   }
>>   
>> +static ssize_t harvest_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>> +{
>> +	return sysfs_emit(buf, "0x%01X\n", ip_hw_instance->harvest);
>> +}
>> +
>>   static ssize_t num_base_addresses_show(struct ip_hw_instance *ip_hw_instance, char *buf)
>>   {
>>   	return sysfs_emit(buf, "%d\n", ip_hw_instance->num_base_addresses);
>> @@ -471,6 +477,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] = {
>>   	__ATTR_RO(major),
>>   	__ATTR_RO(minor),
>>   	__ATTR_RO(revision),
>> +	__ATTR_RO(harvest),
>>   	__ATTR_RO(num_base_addresses),
>>   	__ATTR_RO(base_addr),
>>   };
>> @@ -708,6 +715,7 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
>>   			ip_hw_instance->major = ip->major;
>>   			ip_hw_instance->minor = ip->minor;
>>   			ip_hw_instance->revision = ip->revision;
>> +			ip_hw_instance->harvest = ip->harvest;
>>   			ip_hw_instance->num_base_addresses = ip->num_base_address;
>>   
>>   			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
>>
>> base-commit: d8604f1d237a145db48bae4ea60b85a5875df307
> 

Regards,
-- 
Luben
