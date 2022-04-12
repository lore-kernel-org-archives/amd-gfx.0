Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC46C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Apr 2022 01:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB8910E100;
	Tue, 12 Apr 2022 01:21:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C072F10E100
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Apr 2022 01:21:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=erQNUC3wS8HXGYCECxjTi0mMKb7jsQSJ4CDs17kX93g79WmG83IkCbHkvh4HfVpE9Kvela6WOELTIzOndtnTQ41qegE98PXss8uiMYBBTfx8psBy2mWqejSaEb0Z3+IBuZY4D2WmuZ1I48jtkO7RJKjjLmznXAH6/JUhblErFs3XtueJz1pvV1uiwgTqYyxlhRkZIiEzNWSrqQzf7IpMvSo92Mce9o1AQkN2ylzdL6fqnURV+7q6/7CwmllFIRoKKyfULzeH7t6Umm4XgVsTQUJHcgy9z6t2fhwkGMkH5unlUowg5Pulq28NFJrL85jNiFbAVxAx05aXtCC7EkniJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR6/Dxlt+WkzupBYlofLpdRr3Upa3dqdU1Ii0k+vi/w=;
 b=MLgrpFxfcZlGYgDKl2GMagvjaIyOSyIza0ZqkrcrO+eLIEm6+WeTEcFh8+91c57sjcLHVwEZ+vYQEL1b+Jb1iP1mK9kbRV9CjR5VSY2/VLhved+oSscfLTNpY/EMwbTxyPzPaWbzVbBMSaVB7W2pVFkeBb/MVZ/7mQsEjwqxcgGVOxjXuG2PCQ6ZHE6S9vOjjcbLk+cVQCgFf7vvIs8n5pf9aaYp2dwpNbYfef5Jf+yn/K+rFC2JYaci0QHGAqv4dON233LtLBQlgMzyBh5WL9KiJ1xCrcH1tlnVbiIhX3t3DET23AcmghjZXSvI0cOCmsbyMS+N+M39OVzWHM1FLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR6/Dxlt+WkzupBYlofLpdRr3Upa3dqdU1Ii0k+vi/w=;
 b=0ed+Rz/fJWpf1s7jPdcGc+y6PhWUvFg4RqhpFNrx+GJU5BNR4NF6d9EVQxqJkUBaIHEZuwPD5TiS4Uach20qVgIC7GE1IHP5BhT51bEO3A1LUsWkecJ3bmkBeD1walto9g2U3EcN3BE2kom+lMEZ0meLGD/qiJyPMIrchKco7h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 01:21:18 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::bd:3131:ffc9:5718]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::bd:3131:ffc9:5718%8]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 01:21:18 +0000
Message-ID: <0129336a-3911-2342-d687-95253eceaa2a@amd.com>
Date: Mon, 11 Apr 2022 21:21:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdkfd: Cleanup IO links during KFD device removal
Content-Language: en-US
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220407161555.545725-1-mukul.joshi@amd.com>
 <ed96d92d-9797-4a84-e119-f8cb2cb2d6b4@amd.com>
 <DM5PR12MB1786D106B05282121795AFC7EEED9@DM5PR12MB1786.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM5PR12MB1786D106B05282121795AFC7EEED9@DM5PR12MB1786.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::24) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 998deddc-a492-4506-1233-08da1c22bef9
X-MS-TrafficTypeDiagnostic: SN6PR12MB2845:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB2845CCD81E5AAD9A825D327292ED9@SN6PR12MB2845.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ta6vA43vwIR8z+/ZwkBH0ZUnS8Kb205ttVpyyULSog4/4teuQESQtu7ATVSq4EoEBrdnHoR2Uf8Jr31ORIVaoKc/H4go4K1qELQRf3p2IPwbxS/tyZ5lpb3fHo4oNuh4ysd5A/I6G1X17v88Z1Mej5JYjzCx44UjUwaU1LcFIAHKntbjVZh9FPbJtN6r8BeAtCmLtpgp+iMyGp4qZw6FmYdL+2hF64KhBbGbCDlRJqhqEWbdhfdHSSV5uADyuwypR61jBY+ILZYKF50TTdOMtCp1zZNwzrHpLJwhTcOZlkccUb2v7CMQjp5duULz9fa60DOz0XDiakgYp/3dqwM79dewAsblOAtLhw1ooa5nbYE6E7C5mAz73zp/LVTzoTxH6vlXzSI8LyzWN3XJFz/oJDL6N83yLBYpsxCqGv1eGoYCxSElylpqxoYGCz9jfnjbYP3mrM5/cUwHUqXHZ8cjaNZO/6EB8XQrjfBX0wdDN4UwQNtIeLTm7hxOEy0SwgbmfvOxcvWPlNdP+Pyo7IgaR1Win2t6LwscUxYak3GYTYIRgAqpNrVrTu0izHX4dzb05j6BnSG56o1+Dne5xfoD0RJjM7VsqPuGhI9MRWmV+NCac9iSdhaIBaootL6zbfxKt3fwYHzm09lEh8g0HHk/bBQFSVpKMmvmspSfqmWCIwZHTKuyP0OS/AeYn9oNVBdPwJ0eIfzwctV8mtHwhQmHeCuLsPDiO3lBz29sdKwy3/5LC9MXedMrmJ1AubpQQwEY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(45080400002)(316002)(83380400001)(6486002)(6506007)(508600001)(86362001)(31686004)(31696002)(36756003)(38100700002)(2616005)(53546011)(6512007)(44832011)(2906002)(30864003)(5660300002)(186003)(66476007)(26005)(66946007)(66556008)(8676002)(8936002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q01aK3JWWTFzdWlLa0JZRnM0blgrSXg0WW5QMDhESVUwVHBMMVV0VWZCSWE4?=
 =?utf-8?B?Y2NnTlNMd1VCUE9MdHRWWnBqTm9qbzdFRlA5VUI2Qzg2Snc5Z2xUTy9ZRjY5?=
 =?utf-8?B?U3dpR01VVDRYVHRNWVJxRWI4bElyNUJsVFBzRGNWdGJjS1Q5aE12MEk4NnFH?=
 =?utf-8?B?bG1neFp6VTZraXFLZmFrTFNuY1U2KzAvaDJhSGl4Qzl2OGZjdDdhQlRJanNk?=
 =?utf-8?B?dHZaMkVSdUE1QUZrOVgvRUlyK0x3MThZSmp0cDFJODc5UnRTNE1BZFhUYTZw?=
 =?utf-8?B?aW1BVGlMSEt4cUNHNWZpdFJ2TkUrT1dIMTVjT2NkQUxMb0ZVSEpHVm90azlh?=
 =?utf-8?B?aHFuTXBQcWZGTDh4cTNEMDJ0VjlqVnIxUmVZMTlHcUNGcHdLbm5ISmI0UndO?=
 =?utf-8?B?bHY1VURGZ3k4TjQra3FqaFA2eWgvOW12ZmZDYlllTlo3VFlhL1Y2YisrRVIr?=
 =?utf-8?B?VVpJZ2s4TXNXc1pqTmtvblZNY0ZDZ0dnc216UktQMWxqOVZ6dWIycWhzUkVo?=
 =?utf-8?B?am4xV3F3Q1pPYWp2WHF1Y1FEMHFwQkZwQ2F6RUNERjliVWVHVnVveTJBaExr?=
 =?utf-8?B?a2Z5dGRjTnJzQVc2OXM1NExsc2krRE96OTArb3lyVHVvYW5YN2E0dm9uK0tp?=
 =?utf-8?B?ZjY3Zi9pZnZCVktIREtYSFJLMnk0NjJyTXRaQVJRUVNCNSsyRU1tSW9sK2Fq?=
 =?utf-8?B?QTJ3SUttMjZlQk9EWlg3Z1hjVjNPRkxJYnlFbEEwaTgyZ01IQ3hyZVJuNExU?=
 =?utf-8?B?aVV3cGI1TEtVT3pRTEdxV25PR2EyR3phMWlVbjc5bFlWNWRlaHhmdkY3amJ1?=
 =?utf-8?B?UzhWRWUwbU51bkZzc2VTQ05jc29kVDFKdWkrL1Z6K21YWWszSW01amxKMDFr?=
 =?utf-8?B?dU51eUdLdmphMFFqODlCRkF0MXk3V0NWV2JVTFJYcXlIYTEyMHJLVlFPeHFH?=
 =?utf-8?B?YndEOFN4dWErTTI1TGxvUWQyYVhsdENOQnFPZWg4ZlBCQVNwSXgxRFMzZmdQ?=
 =?utf-8?B?RDlqOUlla0ZKUUdNU0dhRVd4SkVnWHA3Z2RpV3JSa3JvaUNydTltUlhIQ3dr?=
 =?utf-8?B?bG8vdnpITGd2NTl2YW1nMjRJUG05anM1Y1FlTnI1b2Yva0lVREpWL1VtU3hL?=
 =?utf-8?B?d2w2bjVvQ05VaG1ZeXQvRG9ic1d5Y0ZJRlVlM2padGgrNXNTVW8wSTlBMnRY?=
 =?utf-8?B?TWkyQzUzcVpZOGl1cy8wQnBNeVZrbU9DY0FjcW9sOHNWZTVvcVd0S0dVeTM1?=
 =?utf-8?B?cklleHQ3dGFXM0N1OHMwMGRwOEliUVc5a2FXaHRBRDZYN2V5OTU3OWlSYTRt?=
 =?utf-8?B?L1g2amhsMWkxRVRpZVhXQjk0Tk1MZGMxWGw2LzlVK3Vrbmh1UUxUdVBPbCsz?=
 =?utf-8?B?ZkVzWTRINW12TnlkQ2ppUWN0TlQ0VmpPOFBzcCsxbmN0Mm1UWFdpRUZvZjdy?=
 =?utf-8?B?cDdMNW1Vd0JrS2JpTWo4UXp4NmZGYVd1UE5GdEhmak1vRFRHcHdNbnh0ZFFy?=
 =?utf-8?B?SjJUWDZyYVdzMlM4NUFOS0YyMlh5ZFhTemFtUjEwYzk1cGZHb014ME9aQ05p?=
 =?utf-8?B?Wmg3V1czVHNWcWd0RFlWN2RadlpJVHFtSjA1dnJOQkEwdi93K054aDJWT1hh?=
 =?utf-8?B?aWxVM0d5S0pkK2FpNnBGNTQ1cVcwbHU2WVlUYmg3SHpBRVVvL3YxTUJZNm0r?=
 =?utf-8?B?Mjk3d21GK2ZOT1JIaVVGU2pPeWw5M1ArWGFDdmFtdHdjbXNhODlSWEVhWFFv?=
 =?utf-8?B?RUlhQ3VEYVdDTVZERFh0TGxaZWwwM0lmdGhSSjNyYXBSM0o2SHdkeEo2ZlNu?=
 =?utf-8?B?aXk2ck5hc1dRMEF4UEhpSFhHdEdrWnE1cmNKVG9GOFJtWThLbVN5NGVPak1V?=
 =?utf-8?B?U0xZUzJ4djluSjliTXZjdXFOMEhNbmh0cHhCT2daemNmS1dBSm5pU0dPdHVT?=
 =?utf-8?B?dWI2eWh3MW9jeG1DRlhxVTlQOXRnUVNHTkNEaWdlQUdyVDQ1Z2kwTXU4cEJZ?=
 =?utf-8?B?VENKb0R3c3ZOTDZwY1RMYXR5YlFQTytZWmJOdEVlTkZyNDg4b1JBa1BJelYr?=
 =?utf-8?B?WExtaTZjbjYwTGc5UTg0NGJLM25TWDF2c20xcTBubURVMmp0ZE5lVUlJSlVx?=
 =?utf-8?B?cHhyalJUSmdpelBaanQzWGxOeVpic0xLeVRqeXloU08xTCtvQ3BDMmlqQS9E?=
 =?utf-8?B?dCtTVkZjZ2V3TzJQMkV3SVlsVEFXZ1VLWGFHMmhYTEFOY1lWQjRxUzIvd0F0?=
 =?utf-8?B?MWR4ZkNxbUFEdERqbUVPVG92bUdvbWU3T3lmTXhFUDZzT2RzdHM3UFpybjgr?=
 =?utf-8?B?YjIzMmo1THcrR3hwcDlqS2g5Uk1Fd3hVS3hWejJZeG5IZnIyRFdSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 998deddc-a492-4506-1233-08da1c22bef9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 01:21:18.5899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QD34aeFWSapFteli5FkGFi9QjRLI0HgrdrF3JLEpS5JuUHHxBqzd1PK57qq8HT3Xdi+MIsXaSp7ATGqtBTC6HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2845
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
Cc: Shuotao Xu <shuotaoxu@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-04-11 um 21:14 schrieb Joshi, Mukul:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Monday, April 11, 2022 8:16 PM
>> To: Joshi, Mukul <Mukul.Joshi@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Shuotao Xu <shuotaoxu@microsoft.com>
>> Subject: Re: [PATCH] drm/amdkfd: Cleanup IO links during KFD device
>> removal
>>
>> Am 2022-04-07 um 12:15 schrieb Mukul Joshi:
>>> Currently, the IO-links to the device being removed from topology, are
>>> not cleared. As a result, there would be dangling links left in the
>>> KFD topology. This patch aims to fix the following:
>>> 1. Cleanup all IO links to the device being removed.
>>> 2. Ensure that node numbering in sysfs and nodes proximity domain
>>>      values are consistent after the device is removed:
>>>      a. Adding a device and removing a GPU device are made mutually
>>>         exclusive.
>>>      b. The global proximity domain counter is no longer required to be
>>>         an atomic counter. A normal 32-bit counter can be used instead.
>>> 3. Update generation_count to let user-mode know that topology has
>>>      changed due to device removal.
>>>
>>> CC: Shuotao Xu <shuotaoxu@microsoft.com>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> Looks good to me. I have two nit-picks inline.
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_crat.c     |  4 +-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  2 +
>>>    drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 79
>> ++++++++++++++++++++---
>>>    3 files changed, 74 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> index 1eaabd2cb41b..afc8a7fcdad8 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>>> @@ -1056,7 +1056,7 @@ static int kfd_parse_subtype_iolink(struct
>> crat_subtype_iolink *iolink,
>>>    	 * table, add corresponded reversed direction link now.
>>>    	 */
>>>    	if (props && (iolink->flags & CRAT_IOLINK_FLAGS_BI_DIRECTIONAL))
>> {
>>> -		to_dev =
>> kfd_topology_device_by_proximity_domain(id_to);
>>> +		to_dev =
>> kfd_topology_device_by_proximity_domain_no_lock(id_to);
>>>    		if (!to_dev)
>>>    			return -ENODEV;
>>>    		/* same everything but the other direction */ @@ -2225,7
>> +2225,7
>>> @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
>>>    	 */
>>>    	if (kdev->hive_id) {
>>>    		for (nid = 0; nid < proximity_domain; ++nid) {
>>> -			peer_dev =
>> kfd_topology_device_by_proximity_domain(nid);
>>> +			peer_dev =
>> kfd_topology_device_by_proximity_domain_no_lock(nid);
>>>    			if (!peer_dev->gpu)
>>>    				continue;
>>>    			if (peer_dev->gpu->hive_id != kdev->hive_id) diff --
>> git
>>> a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> index e1b7e6afa920..8a43def1f638 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>> @@ -1016,6 +1016,8 @@ int kfd_topology_add_device(struct kfd_dev
>> *gpu);
>>>    int kfd_topology_remove_device(struct kfd_dev *gpu);
>>>    struct kfd_topology_device
>> *kfd_topology_device_by_proximity_domain(
>>>    						uint32_t proximity_domain);
>>> +struct kfd_topology_device
>> *kfd_topology_device_by_proximity_domain_no_lock(
>>> +						uint32_t proximity_domain);
>>>    struct kfd_topology_device *kfd_topology_device_by_id(uint32_t
>> gpu_id);
>>>    struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
>>>    struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index 3bdcae239bc0..874a273b81f7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -46,27 +46,38 @@ static struct list_head topology_device_list;
>>>    static struct kfd_system_properties sys_props;
>>>
>>>    static DECLARE_RWSEM(topology_lock); -static atomic_t
>>> topology_crat_proximity_domain;
>>> +static uint32_t topology_crat_proximity_domain;
>>>
>>> -struct kfd_topology_device
>> *kfd_topology_device_by_proximity_domain(
>>> +struct kfd_topology_device
>>> +*kfd_topology_device_by_proximity_domain_no_lock(
>>>    						uint32_t proximity_domain)
>> I remember we discussed this and I suggested splitting a no_lock version out
>> of this function. But now I don't see it being used anywhere. Was that lost
>> somewhere in refactoring or porting to the upstream branch?
>> Maybe the no_lock version isn't needed any more.
>>
> Its used in the changes in kfd_crat.c (in kfd_create_vcrat_image_gpu() and
> kfd_parse_subtype_iolink ()) and  below in kfd_topology_device_by_proximity_domain().

You're right, I missed the changes in kfd_crat.c. And they are needed 
because the whole CRAT table parsing is now under the topology lock. 
Thanks for the reminder.

Regards,
   Felix


>
>>>    {
>>>    	struct kfd_topology_device *top_dev;
>>>    	struct kfd_topology_device *device = NULL;
>>>
>>> -	down_read(&topology_lock);
>>> -
>>>    	list_for_each_entry(top_dev, &topology_device_list, list)
>>>    		if (top_dev->proximity_domain == proximity_domain) {
>>>    			device = top_dev;
>>>    			break;
>>>    		}
>>>
>>> +	return device;
>>> +}
>>> +
>>> +struct kfd_topology_device
>> *kfd_topology_device_by_proximity_domain(
>>> +						uint32_t proximity_domain)
>>> +{
>>> +	struct kfd_topology_device *device = NULL;
>>> +
>>> +	down_read(&topology_lock);
>>> +
>>> +	device = kfd_topology_device_by_proximity_domain_no_lock(
>>> +							proximity_domain);
>>>    	up_read(&topology_lock);
>>>
>>>    	return device;
>>>    }
>>>
>>> +
>>>    struct kfd_topology_device *kfd_topology_device_by_id(uint32_t
>> gpu_id)
>>>    {
>>>    	struct kfd_topology_device *top_dev = NULL; @@ -1060,7 +1071,7
>> @@
>>> int kfd_topology_init(void)
>>>    	down_write(&topology_lock);
>>>    	kfd_topology_update_device_list(&temp_topology_device_list,
>>>    					&topology_device_list);
>>> -	atomic_set(&topology_crat_proximity_domain,
>> sys_props.num_devices-1);
>>> +	topology_crat_proximity_domain = sys_props.num_devices-1;
>>>    	ret = kfd_topology_update_sysfs();
>>>    	up_write(&topology_lock);
>>>
>>> @@ -1295,8 +1306,6 @@ int kfd_topology_add_device(struct kfd_dev
>> *gpu)
>>>    	pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>>>
>>> -	proximity_domain =
>> atomic_inc_return(&topology_crat_proximity_domain);
>>> -
>>>    	/* Include the CPU in xGMI hive if xGMI connected by assigning it the
>> hive ID. */
>>>    	if (gpu->hive_id && gpu->adev->gmc.xgmi.connected_to_cpu) {
>>>    		struct kfd_topology_device *top_dev; @@ -1321,12
>> +1330,16 @@ int
>>> kfd_topology_add_device(struct kfd_dev *gpu)
>>>    	 */
>>>    	dev = kfd_assign_gpu(gpu);
>>>    	if (!dev) {
>>> +		down_write(&topology_lock);
>>> +		proximity_domain = ++topology_crat_proximity_domain;
>>> +
>>>    		res = kfd_create_crat_image_virtual(&crat_image,
>> &image_size,
>>>    						    COMPUTE_UNIT_GPU,
>> gpu,
>>>    						    proximity_domain);
>>>    		if (res) {
>>>    			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>>>    			       gpu_id);
>>> +			topology_crat_proximity_domain--;
>>>    			return res;
>>>    		}
>>>    		res = kfd_parse_crat_table(crat_image, @@ -1335,10
>> +1348,10 @@ int
>>> kfd_topology_add_device(struct kfd_dev *gpu)
>>>    		if (res) {
>>>    			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>>>    			       gpu_id);
>>> +			topology_crat_proximity_domain--;
>>>    			goto err;
>>>    		}
>>>
>>> -		down_write(&topology_lock);
>>>
>> 	kfd_topology_update_device_list(&temp_topology_device_list,
>>>    			&topology_device_list);
>>>
>>> @@ -1485,25 +1498,73 @@ int kfd_topology_add_device(struct kfd_dev
>> *gpu)
>>>    	return res;
>>>    }
>>>
>>> +static void kfd_topology_update_io_links(int proximity_domain) {
>>> +	struct kfd_topology_device *dev;
>>> +	struct kfd_iolink_properties *iolink, *p2plink, *tmp;
>>> +	/*
>>> +	 * The topology list currently is arranged in increasing
>>> +	 * order of proximity domain.
>>> +	 *
>>> +	 * Two things need to be done when a device is removed:
>>> +	 * 1. All the IO links to this device need to be
>>> +	 *    removed.
>>> +	 * 2. All nodes after the current device node need to move
>>> +	 *    up once this device node is removed from the topology
>>> +	 *    list. As a result, the proximity domain values for
>>> +	 *    all nodes after the node being deleted reduce by 1.
>>> +	 *    This would also cause the proximity domain values for
>>> +	 *    io links to be updated based on new proximity
>>> +	 *    domain values.
>>> +	 */
>> I'd put this comment in front of the function, not in the middle of it.
>> You can make it a proper kernel-doc comment, especially since the function
>> name is a bit generic (and I can't think of a better one that isn't excessively
>> long).
>>
> Sure will do that and send a v2.
>
> Regards,
> Mukul
>
>> Regards,
>>     Felix
>>
>>
>>> +	list_for_each_entry(dev, &topology_device_list, list) {
>>> +		if (dev->proximity_domain > proximity_domain)
>>> +			dev->proximity_domain--;
>>> +
>>> +		list_for_each_entry_safe(iolink, tmp, &dev->io_link_props,
>> list) {
>>> +			/*
>>> +			 * If there is an io link to the dev being deleted
>>> +			 * then remove that IO link also.
>>> +			 */
>>> +			if (iolink->node_to == proximity_domain) {
>>> +				list_del(&iolink->list);
>>> +				dev->io_link_count--;
>>> +				dev->node_props.io_links_count--;
>>> +			} else if (iolink->node_from > proximity_domain) {
>>> +				iolink->node_from--;
>>> +			} else if (iolink->node_to > proximity_domain) {
>>> +				iolink->node_to--;
>>> +			}
>>> +		}
>>> +
>>> +	}
>>> +}
>>> +
>>>    int kfd_topology_remove_device(struct kfd_dev *gpu)
>>>    {
>>>    	struct kfd_topology_device *dev, *tmp;
>>>    	uint32_t gpu_id;
>>>    	int res = -ENODEV;
>>> +	int i = 0;
>>>
>>>    	down_write(&topology_lock);
>>>
>>> -	list_for_each_entry_safe(dev, tmp, &topology_device_list, list)
>>> +	list_for_each_entry_safe(dev, tmp, &topology_device_list, list) {
>>>    		if (dev->gpu == gpu) {
>>>    			gpu_id = dev->gpu_id;
>>>    			kfd_remove_sysfs_node_entry(dev);
>>>    			kfd_release_topology_device(dev);
>>>    			sys_props.num_devices--;
>>> +			kfd_topology_update_io_links(i);
>>> +			topology_crat_proximity_domain =
>> sys_props.num_devices-1;
>>> +			sys_props.generation_count++;
>>>    			res = 0;
>>>    			if (kfd_topology_update_sysfs() < 0)
>>>    				kfd_topology_release_sysfs();
>>>    			break;
>>>    		}
>>> +		i++;
>>> +	}
>>>
>>>    	up_write(&topology_lock);
>>>
