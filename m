Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7276FCCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 18:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B0210E1BC;
	Wed, 29 Oct 2025 18:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xzFKCAx0";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E77210E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 18:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANARhvZVIUHIAgb4icyx9/+vVD4kK/jZwBZndf9Nv/xE3p1v1cOxuOhndQ9U83VSNiagkfk0r8ztkhG134k3HmOsLxlhriLUARbJB+DM/0hYyy4wZ4JVRVpJZXiwxSCSAS1S8mBiv+mH+IK2QHPytBBC1bLio87vDxsl4L9fapq/yMJQ9GuBDmG5/pF2lQp2hQn4Renf9jpQ2cobdBNJnh52uYTucgyloLXvsNMGswLV7mOHIPHevtNj5xQG315Ae4TJ4fiTEPifm+IvUpe0HhEnrG+98ACJ1/6gwK9kCQ0Xeoi3Ur9WUmJLYY7BtcvPT+XHhibtQKA1Y577fYNzng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHMhVAuEpqWYu2GRM8u0AGixFs4pWRYfdspAvJvA2tk=;
 b=mWNovOC2haOEu8g0OqYTsc9e0e9PP4FtONL9IF5iVWpXR25iPyZjUIMHnx4OrRIFKv/EhY0LU5UnC2lqzfRuG2m2ifyxGcqsWKqs9piW6GPbWSjIbvVNpaPI8si72UVgXERSbm+SXpRfLquInkorXDKoPyYexygxFTGDN0HHBsHi/9EOpDKzBphn4T+o52SwapTv6ZR1YadCUykvgYiIt4mTfdjT9Bc0BFPOIt9NBd565+jAyF1qgD3zYU4sFIsECvEthY4L03j3cCXYJtPjIT/qDhABEAMH1hW5+keJlkSN0ME4qeUGhVJKnK0qwOl0B9j1RTGtAJd+OdDA5FvRzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHMhVAuEpqWYu2GRM8u0AGixFs4pWRYfdspAvJvA2tk=;
 b=xzFKCAx0HRr+1WlpRjuOfByStWVe+iuE+qkPVPVp5mh2UMrwGEVR7im0tTf7oz43E6g9yAgYeceQFW6UmLo3K5V4t33HinqePIxyNMuNvcWz7rA6LRPeKtd0c8slMVK21q/iNmvFeLz85Zez/T0iZ/p3grvkqYG/jHx8bNpOIm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 29 Oct
 2025 18:30:31 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 18:30:31 +0000
Message-ID: <e8d1205d-ed53-4fef-9075-2209a5718d8e@amd.com>
Date: Wed, 29 Oct 2025 14:29:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix null pointer on analog detection
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20251029161607.401452-1-harry.wentland@amd.com>
 <4b4aabe98541494474296d6f2062482dcfd9c193.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <4b4aabe98541494474296d6f2062482dcfd9c193.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:408:f6::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6bdbe5-a645-4298-9da0-08de17193d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzlZRmZVR2t2bk9OR0dSc1hEbnB6YVd3OWRHYnFwbW4raWdLeGtPZEdGSmJ3?=
 =?utf-8?B?blpUeEFwMWx2RHlDUkxRRmNDZzhTbnoyVEVVYXdibCtnM3F2eDZsbjZhUXlQ?=
 =?utf-8?B?UFZtU1ZsQk9jbnBWdm5EbG5lUEhaaERmMnlQYVpxK3N6VGVnTERhZjl6V25q?=
 =?utf-8?B?Nm9ycUJmZVk3UnNLeDZtN2pCSDR6cS9LdXF5eWdQbHhXYmhyek0wYjRBTFlV?=
 =?utf-8?B?TWFmeFgxZkViQWF3NXdiOUJYYlJLS3VjVkFiY0paMjZqZlAzbk9GM0ZRK3NM?=
 =?utf-8?B?eE9CNVRYMDlkU1RldXZxRUVKc1VpYkJxVUlieFZTQVRKTHlDa28wenExejVO?=
 =?utf-8?B?dUxKZmh3eXhKRVk2R1djTGlsbk5ob2NYUkJPdmhqbjZBNURuZ1AvUndZU3dN?=
 =?utf-8?B?N05MWisxNm9ldzZ4TnJxTTIvWkRPVzJpTFJ2RCtWdHRHZTZzR1Y4RlJWRWdF?=
 =?utf-8?B?ajJ5SW10NW5EbUZKbkZ2U2dCMVQ3S3RhUFBJSzZ0L1JsRHhablpTeFRCNkdD?=
 =?utf-8?B?Wko2NmlVRFg3VXVNOHl3TGhOeUtEcVNQN2ZCcHg0Y2NCbEd6SXh2Z2tibCtN?=
 =?utf-8?B?U3lCQ3NPdmhveWZlMWhEQ0xOa3MybzQ4bGRpSjF6d254L3BJcUJ2UnF2SXBB?=
 =?utf-8?B?Z2hzQnBRNkJuSHAySVY1bUlkZkxpZVNDU1Y0K0lPdjhtandzSGpobjJLY0g5?=
 =?utf-8?B?MmNic09hVDVwWjFyeGsxcVF6OHQrbC85MkpnZkxqNE9jMjk4bWh1Vm84Z05P?=
 =?utf-8?B?TjAydy8vckM5ejRZaGpPSEs4S0NrYW1lMHJPZmhtYndLVFpsS3Iva01tZ0NJ?=
 =?utf-8?B?K1VpdkdFZ08vZXFxMGlUdzlCZ2h3S1dkSkl5ak1QbnNaNWEvYU15RW9OOGpo?=
 =?utf-8?B?akF2bTdwNEJYSDk3UHV4TU9PRmIweUJnMENjSm95eHAyWTJId2szTFZIandO?=
 =?utf-8?B?bXRaeGxtcS9DYkVvd2YzTDd4WmRWd0dkWFl2emxjTkgrMkJ2aUJ0SHg1Wi9q?=
 =?utf-8?B?aDhqZU5ETVp3UWJkVnBzeDFuUmpnQVBrelFRenhlTXJ3cHhxNEFVK0pneE5Y?=
 =?utf-8?B?OWZtVTgxb2VrMDhaenBtcm1qT3MvRFd2QWtHbUoyNGdmVksxNEMyZU5rUnl5?=
 =?utf-8?B?aGlzTzhqdDNHSXlVcWV1MHRnbHpQdXJCem5BMlJPdERyMXo2TmloWHpkRUwy?=
 =?utf-8?B?bHNlTFgvS1NmdTJ5cFZNQjdIUHFqdTBxeWZlZytGZGlpMklSMm9rTENUQm9Y?=
 =?utf-8?B?bE9waVVESzVtUUJId1ZCeG1nUHU3TWtNU2trRXlIUVRPck9TTno1bEJSZlNZ?=
 =?utf-8?B?VVFmWkt4c0xQNkp6R2E1SFUrK25mNzlCcjZGbWxMbHJiM1NLYnM4Y1h4RHE0?=
 =?utf-8?B?K29rb21YUU93ZUVrcmZXL2V5Yy9ndE84L0NCTEgrOVMweDdrNG1yWW5LUWd4?=
 =?utf-8?B?aUxxRnR4ZVpTV1NHcGIxUFZOKzNOSERQZzkzRnBUUEM2NEVZckVaMit0ZVIw?=
 =?utf-8?B?WC80aks1ZVNUT2V0TWF6clBVU2tIczV3dTFRd3Jxb2EzWHNXL0VjRUlaT1ln?=
 =?utf-8?B?OWVPNnhCQm42cERFRXMxTXBDcHlaMXRMRWlrNjNvc0ZLWUpFRGlMUkYvVE9q?=
 =?utf-8?B?K3g1QnVJb2pFeUZsR3BncUQ1QjZDdk01eXpZTnZaa2RhL210ZjkyUEhSYml1?=
 =?utf-8?B?RUtGbkN0K1RPU0NzUFpIVlgyS3VOVVU0eWxiOHYwRlB2a3NZN3lKWFpORmIz?=
 =?utf-8?B?dXR2RWJSZFpZdEFIV1EvSEdQVmdCLzZnUHRnTnhJaWhqTTkzdzVxOEwzeFVT?=
 =?utf-8?B?WEx3b1lEOTFVR2NOdTVzaHQwSStGY29URUJLaUtSWmVvTkwxR3VPbndrZUJU?=
 =?utf-8?B?SEdHOWFLRGV3WjZ4RWxVa2pMWkhpYnhTN3R4c0N1VzA1RnE4S3ltajBYWHdI?=
 =?utf-8?Q?Ko2ezWIGGPpmJVKOKCG6s2OkVhySgiER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlFPSzViY0JvTEU5Z3JUQ1VNMzZSNTlaNWdaVUltblJVWFVmK1NsWXp3UFFh?=
 =?utf-8?B?UWxFTGFURXBhRGNaN0ZqQ0puR0dUN2loSmtNQThEU3FHZU8vS3pCNVB3Z3Zu?=
 =?utf-8?B?M3hyWGlnMWEvanVnTzBSaFl1OWgwL1RFRnovbUZXSjJ3eFI3OVBrMWhiZnZT?=
 =?utf-8?B?K2hHWnZYbFY5NlYwcEVCTEdONG1QVENiSlNDSTJJUXUrc0o0V3dUeGdDV1d6?=
 =?utf-8?B?YVVXcVRzU0EwNkNiRlBjcXlmeDRjRW1YN1dESXhOS21XM3U1L05RUDZGY3ZX?=
 =?utf-8?B?Wmx6d0I5Y2FoVlpiMlBnV1BTTzVTNDI0ME0zNlh1cmsxWmtXK1RqeENabDVW?=
 =?utf-8?B?V0ZhdkNhZVhuNUZwZjIySGdYVUdJNVJFeHJPY3hkcTNqbjhISTErNVN0dlhV?=
 =?utf-8?B?WUZBWEo3MWxjdVltcW8xbktwRUZCMzh4RngybzZMMzVHaVhaRFBvVk5TR0Y0?=
 =?utf-8?B?dFVaRkphaVlrZ0V2QlRiSTB4ZUJtK1lVa0JLai8vdEZRSksrdXVXWFhOQVRx?=
 =?utf-8?B?UGtZQXBBaU1QK09YNTBkMjgwd2FVL0hsSkJlM0JSczBPWEtzYlQvbkU3S2dz?=
 =?utf-8?B?SFdHVDBLVFJMdUxjQUtud01IQkxPYmpmUGh3UElNaGJvN0d0STk0dUgyakRs?=
 =?utf-8?B?Vi9ldTJaMW9Tdys5MjZySFlSZ0NEUERkb3hZdU0yYWpaTXpiQVZyYVVROXQx?=
 =?utf-8?B?WHJFbDdWZGp2TDhpRGd0bkcvVmJLaHgyVUFzV3hTdytwUFcyNXFKYWpXRWpP?=
 =?utf-8?B?RnlFY3l6RFg4SXo3MlJ0ay9MQmdMNEwrZ2o4MWgvbUxXSXNvNzFiT3NLMmoy?=
 =?utf-8?B?eDJpSU5maE1lcFRnSjRDdjZwZW9yalQ4QkdLcEdJT3dYT1BJeTh4L2ZkWmRK?=
 =?utf-8?B?YXkxRlV2cThPdWhYUmN2OWFjVkUvRWZXQnVGZUZnQU5ENnkrclR1azZkQ0Q2?=
 =?utf-8?B?NnhNY2dBcWpoOHo2SktPTVlPcUllWU80b1ZySG9hdk1vT1lNMTVydmNNcTJ6?=
 =?utf-8?B?Q2J1Q3RtUVJxZ05hU1RCWk11eXJka1pEdWJPclgvcEhaRnZ2WjlqMVcxK2dq?=
 =?utf-8?B?YjhNd3djSVJmVGFudE5HdGZMUGM4YmZkREs1a2xLYXUvNzlkQ1FsdWV4U2Ry?=
 =?utf-8?B?K0dwZlpXZXY3RHlJWVBTRmNZbUpMaFZOU3hubWZlWGdMbGd6WUtaVzRBdzgr?=
 =?utf-8?B?QXlKUUpHYUJiL0tNNjJ1QUdla3JDbXFIM2dTVkJ6eTNWb0ZvaVROdFVIWnhD?=
 =?utf-8?B?RGcvZnlIMnpBNVpWanJDQzFqeWl0ZWdOcmtwRGdWMEgwcUtZTGkzMVN3VWly?=
 =?utf-8?B?M28vdVpURlhTMXpJMVZXUWs2QXV6SGVjN3M1YXZBU3RvaXU3WTZ2UFRrbTNS?=
 =?utf-8?B?TUszVS9xbEpnSFY1TzlVVk9hZmhKZms2TTd2R0pzQmN0bUZ2Y20zd1dlSFd2?=
 =?utf-8?B?Q2V5T0UwYlh0OGJibmQxSEMzZXRFTE9lRXZveHhwRlZxWm94RWVwaVd3U2ow?=
 =?utf-8?B?Q2pFbzgxb3hEZ2JVRHZlS204eVVIaVlhZ25taEJQak8vQm9rdk43dTZhSEhl?=
 =?utf-8?B?Q1Q4b2l4VzZjd2NIUUZ2UUJsRFRIZFA1RjZnSVJPQ2VEVitKUTZjOUdscW5q?=
 =?utf-8?B?T09BZGc3bnRrMWZwdk1Fd3VQenFnYTJ0eTBDdWVQWTN5WWloWm01UHZxRDJl?=
 =?utf-8?B?RGFHYkw0YVNjaTI5dSs2a2w2bHp5SFR4Z3ROb3NmZDVFNGJoQjVYVm9jYWg3?=
 =?utf-8?B?VVVGRWJQOFExekZEVVZ3RDRkelExSmI3bnlaZFNmdWlIbmEvNWx1OUF1UlFn?=
 =?utf-8?B?YWYrM0xzeEwzLzZPWXVKOUM3ZmFwS25Kd3F0VHM5NExWUDJkWHR5VGg3ZitN?=
 =?utf-8?B?RWNSODFQZmIzK2F2bUFCZkdVU0xkVHRSZkhrSDlpWE0yOTZzeDY4SmZvcWNw?=
 =?utf-8?B?QmFrelVUaHJtamtaelN4eHEweG9EVlZFaGd5OFY0Z2tWcG5xVmpiR3VJMVA4?=
 =?utf-8?B?ellIcElvSE85UWFhZlZVV1l5ZEx5dGJaQ0ViZ1lKNk95MTFQbHdXRkEyTWtx?=
 =?utf-8?B?UkZ3NjVjaVd0THZuQit2Y0lBRUdCWmpKWnIxb3FocnlNYjZBSm5ETEFYWUhk?=
 =?utf-8?Q?nzt7dULD3I6P+oWxou2QCqQKv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6bdbe5-a645-4298-9da0-08de17193d90
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 18:30:30.9388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGc5NOXpgz+NnlMjAaNGdNV03CgCGeQoKl5S+BlCvGcRf7ELbXJ/kxW4Ty6k90Q/vPxKKvPx9Q6uGrK8UO7NoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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



On 2025-10-29 12:54, Timur Kristóf wrote:
> On Wed, 2025-10-29 at 12:16 -0400, Harry Wentland wrote:
>> Check if we have an amdgpu_dm_connector->dc_sink first before
>> adding common modes for analog outputs. If we don't have a
>> sink yet we can safely skip this.
> 
> Hi Harry, nice catch!
> 
> Out of curiosity, how is it possible to reach this code when the
> dc_sink is NULL?
> 

Huh, that was a bit of a goose chase.

amdgpu_dm_init
> amdgpu_dm_initialize_drm_device
> amdgpu_set_panel_orientation
> amdgpu_dm_connector_get_modes

This will run even on disconnected (i.e., without dc_sink)
connectors.

Maybe amdgpu_set_panel_orientation had better move into
this hunk after the amdgpu_dm_update_connector_after_detect:

	ret = dc_link_detect(link, DETECT_REASON_BOOT);
	mutex_unlock(&dm->dc_lock);
	printk("hwhw: %s %d\n", __func__, __LINE__);

	if (ret) {
		amdgpu_dm_update_connector_after_detect(aconnector);
		printk("hwhw: %s %d\n", __func__, __LINE__);

Either way, the NULL check is still prudent.

Harry

> The patch is:
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> 
>>
>> Fixes: 0c9f9ca99238 ("drm/amd/display: Add common modes to analog
>> displays without EDID")
>> Cc: Timur Kristóf <timur.kristof@gmail.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index c621e50f636a..bc5a8b8442a2 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -8669,7 +8669,7 @@ static int amdgpu_dm_connector_get_modes(struct
>> drm_connector *connector)
>>  			amdgpu_dm_connector->num_modes +=
>>  				drm_add_modes_noedid(connector,
>> 1920, 1080);
>>  
>> -		if (amdgpu_dm_connector->dc_sink->edid_caps.analog)
>> {
>> +		if (amdgpu_dm_connector->dc_sink &&
>> amdgpu_dm_connector->dc_sink->edid_caps.analog) {
>>  			/* Analog monitor connected by DAC load
>> detection.
>>  			 * Add common modes. It will be up to the
>> user to select one that works.
>>  			 */

