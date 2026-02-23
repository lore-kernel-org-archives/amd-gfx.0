Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95608EA4FC1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 14:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3520110E418;
	Mon, 23 Feb 2026 14:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rALNIZug";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96ABF10E418
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 14:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViQvuZUTyXNNymsrS1h4+BXtog44CyZ6Gc47btrlb8qCHxRbPGyOMlqAEqZE62pUdDEB17j7ba6ggBOM/VLLjFIEugVhhMiPovgzJOWQqODi/K8nkmj1ad6y/ENq26aN6i1e21qlovADSJf8O0A6iFjvNYn6mk/HZuwFND71KhwILRiKR6i2cOyhrXj2DnRIYW7+e8CTGlXX/wmxuaQ2bvAffcubFHSuhF3W1SUWwiO27ZAwRH9q0J6XeP0GyWMTokgz+I1pQzIqyhV0TYrwsW65PtO3+JjouseIwhuVzRLJJrHN6g1kOAN9RsFqbH29hveAqUZljGYdQ5KP9M9irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpZmOa9LT+5uvB17zwCltvfNMfSmea3ow20mPMe5uGo=;
 b=Ev5CD5fCbfSh0cDcUt/s6aE+W+YBZeu5PgXOgJ1GRvIC3eDeT5wfN5B9gtb6ZgDgUI8mibvt/5HdjoZfWSv52fhb88U593DeQZjJ8SOGMQ+lh3ivS/q12T5FEOw/qr9hKhA0G+XBqsq8nGYlQZrC4VlyQr0u0DdKndemeMY7gjAN/Vwx2YBvhGw45rEg24IWyhtU10Iaw9Kf1LHOt+QQ35Rp4aj1QONZvP3R/1j34g+ayg6YD9AzscB6tBsL1F+DuC7YbMPqjxnxGCBTrU+ARhYd0DswXky2s6IIxmPsm2wkJ4aegT4shQ9XFTk4qsU+GGonSKpnAR15gaigW7/oqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpZmOa9LT+5uvB17zwCltvfNMfSmea3ow20mPMe5uGo=;
 b=rALNIZugUGx8N66/2ioUAbyqb8ZVw95SDMYdLQuHCQoH6KtXjP6yAbS9Y2AC2wXHrQJgj69Z8k/DrsrrIlV4pYE3K0Hc3Kp7tg7LYDH3cHGHeQuiYgSMHSAK/SArl8fVEG02TUqEhoMf3VR69UMNMLfiDMsKNzVvgWCI4esVEF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 14:01:28 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 14:01:28 +0000
Message-ID: <76fc864e-bf24-4e59-9f48-57d445cb6ad3@amd.com>
Date: Mon, 23 Feb 2026 19:31:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: add upper bound check on user inputs
 in signal/wait ioctl
From: "Khatri, Sunil" <sukhatri@amd.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <20260220082840.2192325-2-sunil.khatri@amd.com>
 <3c77adc0-d624-45a9-8ed9-6e137968bdae@amd.com>
 <916c5d95-5826-4242-8a8e-71b786596488@amd.com>
Content-Language: en-US
In-Reply-To: <916c5d95-5826-4242-8a8e-71b786596488@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a0c9a-8a37-4cbe-bc57-08de72e409e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M21ubUtwVmZZVDlLQVFoc2NpQXgvb0VUZnpLTGdFUyt3UEZIQVZRTkxjOUxt?=
 =?utf-8?B?YzNrbHBjZXl3YzkyMVhqUG1yOFNXK081QjM2aWV1cW43QVFWNUdDdkMrUGJs?=
 =?utf-8?B?N08zdmlWUExOdFdaRmxjeG11b2hwUlBQTnRTSi9oOUw1eE11dnVlaGRwVSts?=
 =?utf-8?B?NlhmOU51djI1Nmp6b0xFMEQ5ZHNaMkJoRVVtOER4Rm1iWGR5WEYxSDRqUFl3?=
 =?utf-8?B?R2I0eDZJU3hoSHdtVCttZmFEYUJOaWlNNmhLeklZMVBmelprLzlua2w4YWlS?=
 =?utf-8?B?WjRldlN4UDFzZVp4K2RMV0JoUVNjNE1wd1ZqM0R2OVpDRW5ta1FHSEh5Ym1u?=
 =?utf-8?B?WUpsMWRjN0FHV1ZGcmNGODZTanduREEyTDJiVFk1ZUNtbW1YODc2eFNoRS82?=
 =?utf-8?B?VTFTYWRJa1IySThmL3VmMnd0QVFSWEQydEh4cllGTnU5VDFFRlJTam1tUVNp?=
 =?utf-8?B?blFtY0VOY3A4U0RFWFBYdFNaa2liYmhUdU5nSEFhWDVabzg1Q0owTlpSOC9s?=
 =?utf-8?B?YVNRTmxBN1RPMU5neWx0WXk2SmI2cCtYbWI2YWtMSWxoZEtaY2JHbk9lWnNU?=
 =?utf-8?B?dzRIUUkwZ1l5RzFnTW0xczVNODJRcGJJRjdoL0h5U3hYVXV3VzZLdHQweEUz?=
 =?utf-8?B?cWNKSEZQeUNzU1VLY2daaVhKdHdPOWowUWNYUEdmZEZ0b0puRWxQbzUzcy9X?=
 =?utf-8?B?cUNVM1E3dHZyRmZRekJHUlB2M1NIMkNZSnpaMU50K0hPMHV0TUtvZHRBMmtK?=
 =?utf-8?B?cXRYbTZQNmJ4MGlYb3NkWXo1cHd4UUlzRkVMTnAvN3o5QXpUUWJZSHMxNE4w?=
 =?utf-8?B?VTZLV0x1S0JtbkpiNU9rTmN6SDlHK3hLYTlJa3huL2puay9kMjVCMUxVYmNN?=
 =?utf-8?B?Nmh5ajFNdnZhb3kxUWhPSTZZdGJUcTBMemVnVFBGcmFIK1dsWWo4U1orT0JL?=
 =?utf-8?B?Q0NLWk9aandCaWwwZkdiQUUxU3E1c3RnMHc2SGVYYXk4ZVV2Z0h1eVNYSlEx?=
 =?utf-8?B?N29NNnlPQ0JGa1U1WlpVelkrZno5dVVMUzZ2TVV6blg3Wnc2dnd2WnlHZ3Vo?=
 =?utf-8?B?V1loaDRSZW5MZVU5Qlg4bVUvQVN4c2pDVVZRaTFmd1V0R0ExYnhJRDVINko3?=
 =?utf-8?B?UUo2OUd6MnJHUGNmV2ZDT3dKOVRrNDBxY0JsVEl0OEpkUHNGc0g4Syt1aklr?=
 =?utf-8?B?dFdld3JzdGM0akNRT3hLN1V0WVMrL0laL1JtMFBQOG91WXhzaVBpNmdaenBl?=
 =?utf-8?B?N2xKN04zNk5hUEh5QnF5NHFucEhYaDZ3S2tZY3BzdVNKNU9CdGdSbGpZV0di?=
 =?utf-8?B?SzdqVkZWNE1JQmRodjdCYkh5aWZoQjB5Qi9hMGN5dzZqNEo2Wm84TzJuc1RI?=
 =?utf-8?B?RmhlQUtMWE85OFNyWGpLdnZNcm9CNkFHU1I1NGd6dUxBcExDbzdmWjJ5VWhV?=
 =?utf-8?B?cDRFOHRGNlRwVDRBWWJhQTdzY0J3cGxEZm1IMHBmaU9CeHJRbytlMm13cFd3?=
 =?utf-8?B?Wm9YTmExSGZBb095YTJpN3MyZlpLeGpON3dNVjQrT0J5N1lXSmZWU1kzNXU3?=
 =?utf-8?B?Vlh1eGFLZHlkVVVBUDcxVjJXZXBOb1p0NkdMTFlveFU3Y0IyYnFld2V6QXlj?=
 =?utf-8?B?eFBWU2NmKzl5RVRkUURNSElpaGJjNEZlT3ZJajV5d2VHeTBmbklwT1luK3NQ?=
 =?utf-8?B?T1BaWjd1K3U4cG52Q0oyUmUrRU14WDFSU1RoM1c5UXgwZ3h4ZVF4ZkJhc0oz?=
 =?utf-8?B?d28wb3JacEhuUzdtMm9vUEQ0NHNxb0RBOXo1ZitsUTRRV2pVQ25RKzlDc1RP?=
 =?utf-8?B?UjArRm9zM2FzYmlyK2w2RXpndmJBYTdwOFZrdlQrZE03YVk0VmNEeE5SS3JS?=
 =?utf-8?B?UEROazRYMDdFL25qWHRzUUNLNHJTd2N2UFhNaFZpdENrbVREQlY5Ung5MHlZ?=
 =?utf-8?B?eDBtYitaNjdwdmJiU2tpNEZ5QTJRSlNQUmszV2ZCbEZ3MXcvdjhhVG1qTTNu?=
 =?utf-8?B?a01QOWN1TDBPY2FWb25YbkJkdnZyd3JJV2tmVjRnR213bHNWLzYrT0lvaEdu?=
 =?utf-8?B?cnJHSnpEQURRTW5yMmFZVW96Z0pVOEtrcGVNRXdIR2lLQTl3NWJZSU5sMEh6?=
 =?utf-8?Q?IjLc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWlSWTlhOFpnd3o5WFcxMnlQenBEa1dxNXVVSmtqSUkzaWJBeDNzeDEreG9C?=
 =?utf-8?B?V3o0MWdSc1p5VTE5M25GYzZFeFhYNklXYm9QTzNtUlN1dngzMEgrczVSRmZz?=
 =?utf-8?B?eTdIQk85ekJWYkhKd0h3YUQvR3NuR2l6L0swaU0vTTUweGZMQVRNcE9MS1Jo?=
 =?utf-8?B?Y1ZpRXYzV1NBZ2h1R1dWMmU4aGQySW1GT0l4NHd2S3VjLzNaWkg3T2krRytu?=
 =?utf-8?B?bWdCc3hnaHRJa1hwOUwrdlBUazl3alVaelN3dzYzR0tROVZ5NVhSTDRTUVZI?=
 =?utf-8?B?M2RLK1h1ZHE3VGlNWkZEWCtnUXBsVGZpNFhwU2JtM09CS0dPSk5EYkZzL3ZT?=
 =?utf-8?B?VHBheW4yakN2bmh1T0FhZjBtcVhOdnVMWWlZM0pqdWs1UUNFeDFkUzQ1d3dS?=
 =?utf-8?B?YWtyWHNOMTR1QVR3T2RVWU56dk9TdUpIRnpGbEZhN2VMRDJab2oycXdWK0lN?=
 =?utf-8?B?R3EyUWpHYjZQYnpNM1ZNbmxCTjBtbEFVaktTWTcwZlZhNE5JM0tBWm9QcUdj?=
 =?utf-8?B?ZitGTit6SGNiZktCZElBZG5vOWhJejFFN0x4YWw2QU9vSndUa3RGYlJTdExR?=
 =?utf-8?B?eVVXcUV1bk9WWHZSTjRKMVdTb3pqaHFQV2RPK2tsS1o5QjhKdS8xY0tpK1Rq?=
 =?utf-8?B?WHphclZCQ2h1eFJXa2VLSVo4VTg4aGJ4dTg4RGRUdWc3K1hSMkdyNGtxSytS?=
 =?utf-8?B?dkFoVFJ3aWJKa25hUGZMcEpqQ2NvTGtOb2JiQ3JaSHJYRllzTU14Zmhob2RB?=
 =?utf-8?B?VFkrWDgrK09sc3JPV3ExbDVZdkg5MHF3VEh6ODNWVUc3TEtVS0YvUWFwaExx?=
 =?utf-8?B?cVF3VHR6aUVNb1MzcjBQN1d3b29QUHk3U3lFWmk3YzNZYkJDNE5UeW0rOUlx?=
 =?utf-8?B?aVZnZzlaWmxLSURMZ3RORmhOSlR1aUQrUnJmMXl0SkVDdWtWVlc2R2k4dWcz?=
 =?utf-8?B?eTIxQXZ2Szk2Z2hnNTZ0NDMwbnJVRGxmQkIxaytJVGtqUlpRQmVwNklPWTE4?=
 =?utf-8?B?aGlGVnBSdDd4SjM5bWdJWWduS2V6b1BwMWJQendpYmdpNVkzUXVDSm11U29q?=
 =?utf-8?B?Q1lCM2l2SllEeXl5Z2FGM0I5U2F6TGFGd3o3OExGaGs5Z2k0MzB6OVkyQmJS?=
 =?utf-8?B?N0tBQkZETk1Qd1hZNUpicDZmcDl0SmM3aENxN0xaOXJyYkxCRjBoUEVHRjRq?=
 =?utf-8?B?Z0FHZ3Jzc1JiM1VoS3pacXVwR3pTVzBUcERWZGJSYnlBMGtsVUxYSzZhTldY?=
 =?utf-8?B?OVQxR3RIMWtvRmRCaHpNaGljUkhNK3p5WHF0RnZzWVFRVDgyOFdXdFNNRGp3?=
 =?utf-8?B?c0p4QWZROHJLUWRyNHVwSlV2RDJBSThIaVhxaGk5VEgzeGRzMStxZG1DN2tS?=
 =?utf-8?B?aERsdnNySXQvNk9EdVp1NXJTc2xMZmJHN3FDMExCVjducjFoOTJOcVBoSFBP?=
 =?utf-8?B?d09mWGJsMDRtUmd4cWxvZ1ZFc3drQ0xPODk2d1FhbXUrcVh3NHZjYlhDWVhM?=
 =?utf-8?B?TXdVUGxmNXZmMDhTS1IvSmE1WHJaL0MyNVNhRUt6S2ZRZFpBcngzZzFFbE8z?=
 =?utf-8?B?dmtmTWFsSFRVR1duYy9RTWRRbWY4K0VBTGJyTWs4b21jSURIZHFKdjRVNitT?=
 =?utf-8?B?QVhwc05JS3pwTFNwbTBKN1RJWFN5bkRpQW01b1ZLM2c3NWZPWURTc0xER1JF?=
 =?utf-8?B?Q3phQXRpSW82VTgzYTZoMms1SzkyVkpXSEpKV0FlRzVwSUVKQmlzQ0UvTWxM?=
 =?utf-8?B?cDRrRnNMcHFYeEdsa200OCttNGh2bWVDQW1VVEk1NlZjSVRVUGQyQzdvQysx?=
 =?utf-8?B?UU9XNmhRbE83SFE2Mi9nRzBKTll4Qit3SlYyVU9wQi9zYjIwK29Wb25BcDZh?=
 =?utf-8?B?Ui9GV2JJcUhhR0ptRlNXcUxuaU1FVFgydVJ0S2hSMGdxc1JveUZCbjA0ZXBn?=
 =?utf-8?B?OWtYeHExVUIxQlNrcWVTdmFIaHRMdnpEUFhmeEFJemJweGpJc3kxVHUwdHd2?=
 =?utf-8?B?MERSaC9NeWJ3MFFkYjhBU0FOUCtsR0doTno3N044VlFVcEdpd21vNkFTbEdD?=
 =?utf-8?B?YzU5aUs1dFVpUXIxUFdIMFVDajVnNlk2aVpZWGdvcjc1cTJGMVl3Rml1ZW1p?=
 =?utf-8?B?WHZFNUNZc0diL0tnODZOYmhjMTZVM0ZRRGs0QlphSVVBdzR0NE1HS1BhcEw2?=
 =?utf-8?B?a2k4eFlldU1ISlVqWDk1YVZXZmdDcEc5WU9Dak5wTkFrYjNsWEo1MXl6MEFP?=
 =?utf-8?B?NUxzVjFmSURmazl0QUpzZGRTdFVJWnh3M0Iva2xpamVNaE5BM2ZFWFhNM2gx?=
 =?utf-8?B?UTRsQWdKcVpqWVAwSXJvck9tTGVXdGVUT3NaNm1CeFBwMmJhMTRxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a0c9a-8a37-4cbe-bc57-08de72e409e0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 14:01:28.0261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7XPMlHMFL/17xgdIdv2m4L2Ko9XnJUlFFjKGCQIO+7OCgIyns60I3DZovCmLVuk3E0EoFs9C6nFwKOHZHeKnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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


On 23-02-2026 10:45 am, Khatri, Sunil wrote:
>
> On 20-02-2026 07:21 pm, Christian König wrote:
>> On 2/20/26 09:28, Sunil Khatri wrote:
>>> There are various input arguments set by user in the signal/wait
>>> ioctl which could be a huge value eventually leading to a OOM
>>> condition and system crash and could be exploited.
>>>
>>> So check these input value against AMDGPU_USERQ_MAX_HANDLES
>>> which is big enough value and also to avoid out of memory
>>> condition.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 
>>> +++++++++++++++++++
>>>   1 file changed, 37 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index a6eb703b62c4..b9810313c5ab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -35,6 +35,8 @@
>>>   static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>>   static struct kmem_cache *amdgpu_userq_fence_slab;
>>>   +#define AMDGPU_USERQ_MAX_HANDLES    (1U << 16)
>>> +
>>>   int amdgpu_userq_fence_slab_init(void)
>>>   {
>>>       amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>>> @@ -480,6 +482,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_syncobj_handles = args->num_syncobj_handles;
>>> +    if (num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES)
>>> +        return -EINVAL;
>>> +
>>>       syncobj_handles = 
>>> memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>>                           num_syncobj_handles, sizeof(u32));
>> There is actually the helper function drm_syncobj_array_find() which 
>> should handle all of that.
>>
>> If it doesn't we need to improve that function.
>
> i checked the above function and i dont see them handling the maximum 
> limit on the no of the objects in that
> we are doing the same thing in that function i.e based on the count we 
> allocating memory and copying objects from user.
>
> If we want to limit on no of objects a user can send that we need this 
> change as per my understanding.

We could use the helper function "drm_gem_objects_lookup"  to organize 
the code better but we still want to put in the limits on the user input 
provided count.

Let me pull in the Tvrtko change for the helper function and apply the 
limits above it. Hope thats fine ?

Regards
Sunil Khatri

>
> Regards
> Sunil Khatri
>
>>
>>>       if (IS_ERR(syncobj_handles))
>>> @@ -501,6 +506,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       }
>>>         num_read_bo_handles = args->num_bo_read_handles;
>>> +    if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto free_syncobj;
>>> +    }
>>> +
>> Same here, we already have a helper for that. I started using those 
>> helpers in my patch.
>>
>> Maybe just extract that change and apply it separately.
>>
>> Regards,
>> Christian.
>>
>>>       bo_handles_read = 
>>> memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>>>                           num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read)) {
>>> @@ -524,6 +534,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       }
>>>         num_write_bo_handles = args->num_bo_write_handles;
>>> +    if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto put_gobj_read;
>>> +    }
>>> +
>>>       bo_handles_write = 
>>> memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>>>                            num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>> @@ -666,12 +681,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           return -ENOTSUPP;
>>>         num_read_bo_handles = wait_info->num_bo_read_handles;
>>> +    if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES)
>>> +        return -EINVAL;
>>> +
>>>       bo_handles_read = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>>                           num_read_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_read))
>>>           return PTR_ERR(bo_handles_read);
>>>         num_write_bo_handles = wait_info->num_bo_write_handles;
>>> +    if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto free_bo_handles_read;
>>> +    }
>>> +
>>>       bo_handles_write = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>>                            num_write_bo_handles, sizeof(u32));
>>>       if (IS_ERR(bo_handles_write)) {
>>> @@ -680,6 +703,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       }
>>>         num_syncobj = wait_info->num_syncobj_handles;
>>> +    if (num_syncobj > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto free_bo_handles_write;
>>> +    }
>>> +
>>>       syncobj_handles = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>>                           num_syncobj, sizeof(u32));
>>>       if (IS_ERR(syncobj_handles)) {
>>> @@ -688,6 +716,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>       }
>>>         num_points = wait_info->num_syncobj_timeline_handles;
>>> +    if (num_points > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto free_syncobj_handles;
>>> +    }
>>>       timeline_handles = 
>>> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>>                            num_points, sizeof(u32));
>>>       if (IS_ERR(timeline_handles)) {
>>> @@ -750,6 +782,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>> *dev, void *data,
>>>           }
>>>       }
>>>   +    if (wait_info->num_fences > AMDGPU_USERQ_MAX_HANDLES) {
>>> +        r = -EINVAL;
>>> +        goto exec_fini;
>>> +    }
>>> +
>>>       if (!wait_info->num_fences) {
>>>           if (num_points) {
>>>               struct dma_fence_unwrap iter;
