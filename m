Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C63D0D7BA
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Oct 2024 15:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ECB110EB0E;
	Fri, 11 Oct 2024 15:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEsWgqaZ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D1C10EB0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Oct 2024 15:13:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqV1OiVLZzsTVs4q/jPUmiWpQqjPCahpmxjXfbfTly595pQQOAQ+2JmWnk2KOhCVECf/o/zlL7UR/Te7wAy/eycBM/Zu12+JoRkx83MDP5vWxIPvs1TiOMcc4u8IGMa+JeGYK+5TcsCUKbkImTRlVJt5sP0ExYd6OohtW0g0RNpWhk7ldCrqOmmUOaf4v0ZVaDKSmpIJ9/nrW3i90c+J7kf6HF/sYUuv4x7u36NKq7fS4sVCitQpdvH5cRMSHQPHAeHetOHDLKNJdDG8+1wUmMwTsfas6DiskjmomghEIix41p9ugB0lTSzevFWZXCzjzV5jpXAmKFXWKFeRWo/5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jexkxezibDKoNdqeyD9vIq1CGVB5vkRHrjMjXTscm8=;
 b=TlmVpPTfqOvgbTTme9pO/36/jzQhtPygGofwGUEdLNS1rYeNYyLHJlbDzPb2AugszH5zlalBc5ZDSPgP1W38M+qrbv07zL3d/43jqii5+tBIus4exuGtb0oVflm/toYZw0HFazs7TnBllRXtXuP+pSINA80QGq7FjKwxMAmCPJpKEokzxxnfz3qTt8VB6p6MCDkco9Is1B8wEVSVaziVnhxpNbI4Z87uMChOzrvdCj/PXRKy+dTMyQoy6U9I8oOqAB5DPBj3qg5KzpTDGLK/ndam2gmvCxSashZSmuS706P97GMnYp12XOA5WQVvtSNDK0re80vk2EwV4XBEnbbftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jexkxezibDKoNdqeyD9vIq1CGVB5vkRHrjMjXTscm8=;
 b=kEsWgqaZJhYFlB6N6FZXyHDYmymXS5rNKDM568dPsjnX9A/vvwrjV+XL7QErKujSFHWgqxpdM7gHWiEvlZ+iT0E2LJYN0jG0diIpIn5SCg/SNMl/1utzTk2xLY0UVnl6lJBjsFReeXt6KXE7q8MEWZhti0iuWMP+JrtYawL18Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 15:13:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 15:13:12 +0000
Message-ID: <b6ccb611-672d-4e24-832e-35b60462be05@amd.com>
Date: Fri, 11 Oct 2024 11:13:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: change kfd process kref count at creation
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: philip.yang@amd.com
References: <20241009180855.14859-1-xiaogang.chen@amd.com>
 <56b95963-f617-4578-a660-37eb471edd68@amd.com>
 <98dfd8f4-3c24-466c-8ede-d3fcb341912b@amd.com>
 <3005a471-e835-4d0e-a0e1-e40c5d761cbd@amd.com>
 <92839ce8-4fe0-4099-8592-f461bd9d119b@amd.com>
 <0e685c63-ca07-4147-9051-bac211f52661@amd.com>
 <381a4701-1b3d-4bf9-a361-329fd090ba44@amd.com>
 <9445ae2f-9bd2-4bbf-9fbd-789a75a4e9e5@amd.com>
 <f3c4b83d-0fd0-48cd-956a-2e766953fa03@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <f3c4b83d-0fd0-48cd-956a-2e766953fa03@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0228.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de596f7-cdc0-45a6-26f9-08dcea073910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzUxR0Z2dm0vd2U5WUszQjlIZlpoRTJRWEtBUFJseWorQXFJZlpaL1VsaGJy?=
 =?utf-8?B?eGpJelo3VWpTUzZsZ29WZ1VVRXA4bm9VOFRBNTUya1J4cW5jYjgwSFdsNGs3?=
 =?utf-8?B?WjNHaXFMekdRY2NlSktubks4bU5ib0lHdDBsdFZzdE43NVo1cEIxVExpMTV5?=
 =?utf-8?B?NEFvbnZpUk9SMlBMT2VhRzRCemF6K21hcmpRelQ5dVVzZmt5M1NqUW9GQndm?=
 =?utf-8?B?ZzZzTkxqWlM3ZytpenZZL3pwYXVhWFJCOGk4aGZ5Q1U5bklGRTdqQVFQSXlF?=
 =?utf-8?B?cnNQT1RIZkpGUHgzQy9nTE8zREtVdEVUR3ZOK3E0bm9EcjY4Zy9IQ1A5a05X?=
 =?utf-8?B?bFRBeUxWNGFUY25SQXlKc3ZhV0dlMVowQ2d0S1d5Q1U1Njk2bng3SGNJYXVo?=
 =?utf-8?B?QldKTlNQUHhXMWtRMTBPalB4ZjNBcWlqVkR4ZVpMMnRDWUloZXEvV1E0WFVO?=
 =?utf-8?B?UjRrNUF4emtYU05YeTA0NVJrZ2gxQzhNUTJqbHpBUkg5b2w3OUFQT21MRk1z?=
 =?utf-8?B?bjVza1BMMXA3VEJVNUZQbG1QSWM1K01hOHFhL2VVaXZNamU2L3o1b1M2dytT?=
 =?utf-8?B?eElzZnVoVmQ1MSthME5MNXdEZTJpdU94Zk1XK3F6RnJoN1pxOVN1OEErTG56?=
 =?utf-8?B?aW5Lb1ZpQ3J5VHdkdXlrS0FpbTcwcXo0NndtTDJacHpmcm5qaVFhWjFUNmVo?=
 =?utf-8?B?bzExQmlnbmxVVUdVMkJGdC83NTFYcUpJV0hwQjR1YWx6TkxQV1RPTjlEYit2?=
 =?utf-8?B?dmF5VEdDRkpQQWxyUW1lSVdYbUNEbFVvdWRINUVPdFRKMnl5Qkp5cFFrY1ZB?=
 =?utf-8?B?MTBDNUxCK0pnenBSZWg5eXZLR0MrOGg0c2NhbzI1Nm5YZU5oVFphQ1ZhaWNm?=
 =?utf-8?B?c3ZRZk8rVkpYQmpuUkRxT255TGI5S3BUN0dBQitJMDZ1NnBHaE1mSkVtQ3JH?=
 =?utf-8?B?VnpLdy94QXRLOUhiWHFOWlIxUjExSmlEOVRUd1BqSEtVcUdxUzdZMWJ2Smoy?=
 =?utf-8?B?ekV2eWtTUEYyWTFyTGRMdHYyWXNEUXBPb1diWnV4QmNZM0p4QkwrVUhGcW1k?=
 =?utf-8?B?ekN6QUVzSXBUWnlDMlExQUFZUVZHdEpqelJZRmkrOG5MUjkzMEdEOXdlZUVx?=
 =?utf-8?B?NzZuS2JIRnVMRUdUWHA5NzErWmhYRVF0bDdaeGtjRDZXM1BVamIrWVRFODZm?=
 =?utf-8?B?VlVTTldleWR6RHJGZHFBNWl0MVU5anFwV3lUT2IwRENwTXIzSG5VR2tEa1ph?=
 =?utf-8?B?VG8rNUs0OVRyTzhPU3dpdHlrWjB5WHA3aEVaVG9GR2pOUzJKL0ZBdWZzUmFh?=
 =?utf-8?B?T0EwQ3pTUnZxdC9zUmlldEJpOU5SV1gxU2w2Vi9XUUpBZkdlV2xMempwV0Fu?=
 =?utf-8?B?bS9vRzhRTHJwYjFXb0MxSkZtaVFIbE9HV1ZHaEpxdDcvc09qZWhDbnhKV2c4?=
 =?utf-8?B?Y0cycmZucDJFTTRYdXZXWUNmU0xvNFpHaG9ZTXl3R2F6THNoUzhWWHlMQWZv?=
 =?utf-8?B?YXc0bGUvQytUZll6Wi9GWXRiSlJyUmNQeGNNdnFjS2llY082UUFVWVVMMHdw?=
 =?utf-8?B?TEo1OTJLM0hEWnlvYU1zUHFSNVQ3RkpUTjFRMUFUbkRBclpZeno4T0NaYkxo?=
 =?utf-8?B?elRSZjdaLzZ1STI4c0pDanc0UVMvRkhBR3E4TEd5YTk2Vit1MTg2TjFQRmRt?=
 =?utf-8?B?Vk94WnZzSmE1ckZYQUw2clBuVy84cENuSUF2bEx0eVVBbDVMQ3BpVWJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRGQnpYWlJ4dDR2OUllVlJrenBFVjBFaWo4aDQ5ODM5K2JNU1AzZE44WXB6?=
 =?utf-8?B?b1JpYm5MMHZrdzJlc0NZaExDcXY2eDZFN1E4WXcvZE52YkYydUU3MmdZRy9S?=
 =?utf-8?B?Z0xzalZZT2ovakx1S1E4dmdHRUQzMnVNNE1ReTdBTjVWcTZPajd2c1NIaEdx?=
 =?utf-8?B?ZGVNb2FmZk5BWGhZN1cvVW5sL2o2SmhHTXFYREl2WE9yd3A3cm1vd20xeDFu?=
 =?utf-8?B?a2ZjNEtDSXg2TldZVzB1c2o1cGJEdllsSHArQmNiclc5UURzMVhCd0h6Q2hK?=
 =?utf-8?B?MjV3Mnc4bXc2MlZaYkdncGpHMzRrU2JBL2NmbGNkNlEvTlk1dUZUYmRoQW9m?=
 =?utf-8?B?Mlh0VHdoc2V3cVRUK1YwOFg4dE96L0hPdzJkUGQzcGxkL1FTNGxSL2JWcWVW?=
 =?utf-8?B?ekd0VTNiWGVWaGNqZEVtbDZ2MjZFWjYyREUvWlQyMkE3QzhTU3ZBazVsQkpn?=
 =?utf-8?B?bFpKQTFZZHR1Z3VpSkFlOFkzeE1Cemhwbml1WjdpRXlvMGVGNHNmZDRHbWtR?=
 =?utf-8?B?cWRNNUU3OVExU3BmS1pod0tETGI5dlRJWXdtazA0Y2hqSk5RR2VvdlNNTjhD?=
 =?utf-8?B?QlNudldCREtWczhBbTNXTzBveFJXTnZ2VnRPZ0VLT0xETURGYm9vMWs4OXdn?=
 =?utf-8?B?RWQyc1dDWk1la0xXeW1WQ2xEZXJ4K2c2c2k3MjRjSERoK01HTVBKS3ZHN1Mr?=
 =?utf-8?B?d3hkcUhpb2NUajVzZk1ESDVONVhBZWsrVzQrV3gxK0x6Q3JERGt1VjhzZFdQ?=
 =?utf-8?B?ZU5xTWhJQzBrQnhKYkRwN3E1eDdzd1QySzJlYVZMS1ppenNoVmNSMkVPaVd1?=
 =?utf-8?B?YS9DTkNSQkEzRHpLbWNWZUNibGo2OVR6dDU0dGJLL2dUZW92ZDZSbHgxWmRp?=
 =?utf-8?B?VXlzaFR2cnlYYUZqWGZ2N0ZRUHh4M01RMThsM1hpNDJ5c3NFNmtWNlNLSDlP?=
 =?utf-8?B?MzN4d0llby9id2hzVHFvendMM2JIbDlsUXZPVkZPeGlnZ3QvZkgzUjVEYjJQ?=
 =?utf-8?B?K09BS2YxbDMzQ21kWXovMkVXVlI5ZnBmSzVXUjB6WlZtNXhzREtqWTA1Q1Vy?=
 =?utf-8?B?bWgyclJLcUptUDM3ZXpQcTJ3SUhBRm1xd0dzNVh4VnVzQTVwY001eXNrWDM5?=
 =?utf-8?B?c3J3UmhEaG1rMUlpWU1PSit4Z2F3VUdnMjhDRytDVjM1cGIwYW1vdnFmWTNL?=
 =?utf-8?B?TFZlazdIMERYZTZHT1dBcVlFR2lZd0MrNWs4Y3Vta3YzMkhGbnhIQkFBZGNj?=
 =?utf-8?B?bEF3bkJabXdVby9PK2ZtWWoyTzhYWXk0WGl3TVRJUjBMcVExeGg2RENZOXIy?=
 =?utf-8?B?U3dWRmpRemp2akVsYyt1QjJtOWxhT1gzK29iY3NEdHBHR3BBeWhmNkdhVmtI?=
 =?utf-8?B?bHB5bDljZzFsTHNxSnNuMU1SRk9Tam5naCtuUHZKVlo3VDkzdmdKek9aVHBn?=
 =?utf-8?B?T2Z6V2FtQ1k5QkpXbVZadXVGYmoyNEE5UGhzV01FdGd6UVpPSlUzV2pOUmpl?=
 =?utf-8?B?c1dhWFpvajkxU2tDR0o2RDRHS0s4a2E0UjY2TjFXWWludXo0SVlHVmFTcXBI?=
 =?utf-8?B?dWx3T0ZZbCt4R0FYWSsrTGpvLzZLZGJYV1VOQ0JKbE9DcmJqOEJPbnU2d3JK?=
 =?utf-8?B?czNETHg1bm1IVlpPRTRoKzlxdHY2SUJqY3FXRGtCLzRKR1RKbWFZTzFYa01m?=
 =?utf-8?B?cmsvM2lRbDhWVGV1R2IyR1lHWWxiQVZuRWUxTjlmeTRlbStDV3I4cmVkWVEz?=
 =?utf-8?B?YzBvSks0MUsxTFluQUxNcFhXSlpITmE5UENrZVZKNWgxditOSXY4am9oZUtU?=
 =?utf-8?B?Z3hsM0ZCM1duMXVMaUVUOEtvWWFrQ2EvMVVYdWg2K1R6akJMeFVueDRLTnpu?=
 =?utf-8?B?L0VrTlB0QzN2ZUdXTTZoOWE4WUx5QW1NdXJYV3ZUeDlmRGZFN0RIVVI1aFJy?=
 =?utf-8?B?a0tkOFdnUGtWSE1ObHpjVzdEZ2d4VjZ6L1Y4c3RDUFQwUkRvR21VdHc5dlZ2?=
 =?utf-8?B?OEgyaUJQNWJEUEdoZGk2c0lhR0FQbFpVcEl6cENsZ0VWUFpoM3l4Z3NxWW8r?=
 =?utf-8?B?WWJrKzFuUUU3K1JWWjFQN1lsalNDTE0vSThXZTQ4c1ZhOHp5LzVRQ2REWVlT?=
 =?utf-8?Q?VjFnDlNVP3S+qyHz9NHj8BIIx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de596f7-cdc0-45a6-26f9-08dcea073910
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 15:13:12.3925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4jnqbxmR12P1nWPdGKBEnFRnH2n91kblokCfqON8g9YeEEV2FhLKz7PAWkiF9i/Sg+5mWKsGMxtDbdgb7bfyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
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

On 2024-10-11 10:53, Chen, Xiaogang wrote:
> 
> On 10/10/2024 3:37 PM, Felix Kuehling wrote:
>> On 2024-10-10 16:19, Chen, Xiaogang wrote:
>>>
>>> On 10/10/2024 2:01 PM, Felix Kuehling wrote:
>>>>
>>>> On 2024-10-09 18:16, Chen, Xiaogang wrote:
>>>>>
>>>>> On 10/9/2024 4:45 PM, Felix Kuehling wrote:
>>>>>>
>>>>>> On 2024-10-09 17:02, Chen, Xiaogang wrote:
>>>>>>>
>>>>>>> On 10/9/2024 3:38 PM, Felix Kuehling wrote:
>>>>>>>> On 2024-10-09 14:08, Xiaogang.Chen wrote:
>>>>>>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>>>>>>
>>>>>>>>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>>>>>>>>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>>>>>>>>> process mmu notifier allocation since we decrease the ref at free_notifier of
>>>>>>>>> mmu_notifier_ops, so pair them.
>>>>>>>>
>>>>>>>> That's not correct. kfd_create_process returns a struct kfd_process * reference. That gets stored by the caller in filep->private_data. That requires incrementing the reference count. You can have multiple references to the same struct kfd_process if user mode opens /dev/kfd multiple times. The reference is released in kfd_release. Your change breaks that use case.
>>>>>>>>
>>>>>>> ok, if user mode open and close /dev/kfd multiple times(current Thunk only allows user process open the kfd node once)  the change will break this use case.
>>>>>>>> The reference released in kfd_process_free_notifier is only one per process and it's the reference created by kref_init.
>>>>>>>
>>>>>>> I think we can increase kref if find_process return true(the user process already created kfd process). If find_process return false do not increase kref since kref_init has been set to 1.
>>>>>>>
>>>>>>> Or change find_process(thread, false) to find_process(thread, true) that will increase kref if it finds kfd process has been created.
>>>>>>>
>>>>>>> The idea is to pair kref update between alloc_notifier and free_notifier of mmu_notifier_ops for same process(mm). That would seem natural.
>>>>>>
>>>>>> What's the problem you're trying to solve? Is it just a cosmetic issue? The MMU notifier is registered in create_process (not kfd_create_process). If you add a kref_get in kfd_process_alloc_notifier you need to kfd_unref_process somewhere in create_process. I don't think it's worth the trouble and only risks introducing more reference counting bugs.
>>>>>
>>>>> It is for making code cleaner or natural to read. mmu_notifier_get is the last call at create_process. If mmu_notifier_get fail the process is freed: kfree(process). If create_process success kfd_create_process return that process anyway(after create_process kfd_create_process creates sys entries that not affect return created kfd process). The finally result is same that kref is 2: one for kfd process creation, one for mmu notifier allocation.
>>>>
>>>> Currently, when you call kfd_create_process for the first time, it returns with kref=2. One reference for the MMU notifier, and one for file->private_data.
>>>>
>>>> Subsequent invocations of kfd_create_process when the process already exists should increment the kref by one to track the additional reference put into the new file->private_data.
>>> one ways is changing find_process(thread, false) to find_process(thread, true) at kfd_create_process. When kfd process already exist find_process will call kref_get(&p->ref);
>>>>
>>>>
>>>> If you can come up with a patch that preserves this logic _and makes the code simpler and more readable_, I will consider approving it. Also keep in mind that your patch would need to be ported to the DKMS branch, where there are two different code paths to support older kernels that don't have mmu_notifier_get/put.
>>>>
>>> At DKMS branch alloc_notifier and free_notifer either exist together or both not exist. So when HAVE_MMU_NOTIFIER_PUT is defined(new kernel) it is ok.
>>>
>>> #ifdef HAVE_MMU_NOTIFIER_PUT
>>>         .alloc_notifier = kfd_process_alloc_notifier,
>>>         .free_notifier = kfd_process_free_notifier,
>>> #endif
>>>
>>> but when HAVE_MMU_NOTIFIER_PUT is not defined we need change kfd_process_destroy_delayed since since it call kfd_unref_process(p);
>>>
>>> static void kfd_process_destroy_delayed(struct rcu_head *rcu)
>>> {
>>>         struct kfd_process *p = container_of(rcu, struc mmu_notifier_registert kfd_process, rcu);
>>>
>>>         kfd_unref_process(p);
>>> }
>>>
>>> That means if port this patch to dkms branch when HAVE_MMU_NOTIFIER_PUT is not defined(old kernel) we do not need call kfd_process_destroy_delayed or remove mmu_notifier_call_srcu(&p->rcu, &kfd_process_destroy_delayed)  at kfd_process_notifier_release_internal. I think that make thing simpler for old kernel.
>>
>> No, we still need to destroy the kref that belongs to the process when the mm_struct is destroyed. We can't do that in kfd_process_notifier_release_internal because it leads to LOCKDEP issues. So we still need kfd_process_destroy_delayed.
> 
> For old kernel we use mmu_notifier_register that does not update kfd process kref. It register process->mmu_notifier to mmu. The release function of process->mmu_notifier got called when mm structure got destroyed.

We register the MMU notifier to handle cleanup when the process is destroyed. There must be a reference that gets decremented when that MMU notifier runs so that the kfd_process structure doesn't get destroyed too early.

> 
> The new kernel uses get/put flow. At kfd process creation we use mmu_notifier_get that calls alloc_notifier. So this patch increases kfd process kref at alloc_notifier since mmu refers kfd process and we already decrease the kref at free_notifier.

The notifier has the exact same purpose, no matter how it gets registered or allocated.

Currently the reference that is decremented by the MMU notifier is the reference that got initialized by kref_init. I propose to leave it that way for old and new kernels for simplicity.

If you decide to change it, you must ensure that you don't break the process reference counting. If you leak a process reference, we won't cleanup process resources and eventually run out of memory. If you decrement the last process reference too early, you may get use-after-free problems in the MMU notifier or change the semantics for processes that open and close KFD multiple times (e.g. KFDTest).

Regards,
  Felix

> 
> For old kernel, when port this patch to dkms branch we either do not decrease kfd process kref during mm destruction since we did not increase kfd process kref during creation, or  manually increase this kref after  mmu_notifier_register, then keep kfd_process_destroy_delayed.
> 
> Regards
> 
> Xiaogang
> 
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> So it needs additional handling for old kernel on dkms branch. I do not know who port patch to dkms branch, or I should change that on dkms branch.
>>>
>>> Regards
>>>
>>> Xiaogang
>>>
>>>
>>>> Regards,
>>>>   Felix
>>>>
>>>>
>>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>> Regards,
>>>>>>   Felix
>>>>>>
>>>>>>
>>>>>>>
>>>>>>> Regards
>>>>>>>
>>>>>>> Xiaogang
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>>   Felix
>>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++---
>>>>>>>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> index d07acf1b2f93..7c5471d7d743 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>>>> @@ -899,8 +899,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>>>>>> init_waitqueue_head(&process->wait_irq_drain);
>>>>>>>>>       }
>>>>>>>>>   out:
>>>>>>>>> -    if (!IS_ERR(process))
>>>>>>>>> -        kref_get(&process->ref);
>>>>>>>>>       mutex_unlock(&kfd_processes_mutex);
>>>>>>>>>       mmput(thread->mm);
>>>>>>>>>   @@ -1191,7 +1189,11 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>>>>>>         srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>>>>   -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>>>>>>> +    if (p) {
>>>>>>>>> +        kref_get(&p->ref);
>>>>>>>>> +        return &p->mmu_notifier;
>>>>>>>>> +    }
>>>>>>>>> +    return ERR_PTR(-ESRCH);
>>>>>>>>>   }
>>>>>>>>>     static void kfd_process_free_notifier(struct mmu_notifier *mn)
