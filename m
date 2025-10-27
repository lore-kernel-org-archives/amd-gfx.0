Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826EECCF9E0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 07:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268A410E35D;
	Mon, 27 Oct 2025 07:45:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bbw/8xjE";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9245210E361
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 07:45:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQuXRysp248nq0Z8SgQv1il7rCqCXaWrASFyBDqq3T9RgUkOXFRfOoXoZ5oVsuAPFUrwlwGHLf+IyQkeOCdPMWJbNyYKDO7vrBtTbZrvcGUVT4dQInG3q+poi/AFBbNorWHjDQOGjj/kjjgQGfwz13ktGARmIDN3r7v0depwLSKcQbGbOPuHyhOi8PoPiU8dEydbwA70tyhTbq/WIm9YIgzjIPmCFNXHGCI72TqfsYV9/F6JjOHBDyF13OEhianL/Esa8GcYbFwM1SVFNw3E/iyS3P7iaNchVNxFt8dAHq/kHCnMFM9zMOi6/gevZhH9MOg8k0dGmU130g+gv5eLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iOYcx/8Hzp2RJH9n8OU1MYuAXhXDyMqnIpVLgx67EU=;
 b=YoUB5B6cUN7AefXIlIqCvMxjDcfS6kCYNVgENNmfy2HSAlNOIGBIQxbGqjDxTODoJQUX+OnajwoypAIdRc/BT/sMDYYjmW7skY9dbwIBYJJqACRlol+eAJa4AhN7o4yzswefsOW0GDJ5LKTTXHR+9ZsEpGYJ9UxuIzNt0Dsd576u/MnqJ7pzUFaeK16XiY7LB+RqzqpRyGrn4Ci/9PdLRIhZ+3sKGc3y3ySAlrryZHhu9ejXO/TGTsQwbGXGE02j3zuR4CB/usj2Zin6dhD5ivZO/G9I7vfloctu60ZZvEXv4CIb+bqE/BWG5M9lW8a14YYsR9Nwd4IQc9kKrk/NJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iOYcx/8Hzp2RJH9n8OU1MYuAXhXDyMqnIpVLgx67EU=;
 b=bbw/8xjE2M2H/VoYYYyd1xyTS3zzIUHHOnoQ5g9aHmIvxS8vXubdoLa8ATPwwOt2avA1xhi5KqaSb49CTTEqyndAyNR4yH6oOom6IOOPiLPYR6EamPNf+moKHgwlHVcFavsK0w0OIRnPzaisN4pFJjjvFk50H4FBcOt20UKuagI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 07:45:28 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 07:45:28 +0000
Message-ID: <69468cac-8333-413e-a99e-41b55dda0569@amd.com>
Date: Mon, 27 Oct 2025 08:45:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix VM entities killed before KFD process wq
 release.
To: Gang Ba <Gang.Ba@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com
References: <20251017140412.2173002-1-Gang.Ba@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251017140412.2173002-1-Gang.Ba@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:408:eb::34) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 71eec433-aad7-41d0-95c6-08de152ccc6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkZLM2l5T1o5VmtiZDMycXdiY0NYWVk1Z3pKMjNyczF6WlIvNVJaZms2Tkp0?=
 =?utf-8?B?TGVjZVNtRE9vZlZHUXJnaDFicEJYWTkrdXFsVVVhaTFxVnh0Qzg3WHNiUitn?=
 =?utf-8?B?ZGgrMy9lK2F4eE5RRzk5a3NUU3ZmQzFzbG40RFJYeURqMmt6RDZPRmNKSGw4?=
 =?utf-8?B?ckc1YUoxZHJMT3VWZ0F5dEhLSHRyUG4wYXZZNGNzRWRvSWZiNEhKSEEySzAz?=
 =?utf-8?B?MFN3a0RSZVNPU09KRlJwbWt4QVhKTU9kTC9xWnUwNGliRTlFNGRuWmxXaTBK?=
 =?utf-8?B?VHBmNUsyT0dYbmNyUkI2WnBXaGxUYWdPVENiNm1ZK3RULzIvcTd2ZkVSQVUv?=
 =?utf-8?B?VDVKNVp6STRialJRZWl0UXo3dzVVNXJyQzBHVGwxSUllZGNaVGtwWGtXRlJM?=
 =?utf-8?B?NlEyd3h1anlDQXU1dkFVd3JjaEROcWJoTXBpbXl3S2tOZDZkTURKSHVWSzJT?=
 =?utf-8?B?R0dZWExPMGRtSUtOejRBdHVaZEFIQW1xNGJGTUdRa3pzNTVIRmVlSW5JK1hI?=
 =?utf-8?B?RXZTVVRGdVB3QmNOUk1pSXc4L1BsRkt2ZlZpSFRub0hpWjlGMlhqeEc4WGJq?=
 =?utf-8?B?cG1EcG43YUk1TWRIVDFyYVJvSUpIKy9yRXN1OEtsVk5DVjA2OFNoRkdkMERv?=
 =?utf-8?B?K2ZISzdtUW4ySmRRVkhyckpwNUk5S0s2YjNFNFlZcjQzSkZtWE9WTzVRZWJk?=
 =?utf-8?B?d2JuYmFMTURsTGdSeE5SZ1lvWFhSTHZnUFMxTE5uUTcxdFNGaCtDTmIrVnFL?=
 =?utf-8?B?NDErcXBiRng1Mk53U0RmUUF0c1lzek8xQ2ZBZFZjNmJlZGIrVndOMUNUN1Jx?=
 =?utf-8?B?dFJQTEQ2RnIvNkVIcVNZeUN1V1JtSGJrRzMrc3RZeGZPS3J1UEd2czhsRkQ4?=
 =?utf-8?B?WG1aYVJEeFNpZnc0S3BMRnhsK0hYQ1VZaks3Z3JkdGNiQkFUS1g0UHVaTnlM?=
 =?utf-8?B?SU9jUWwxNm1ZdEJkTGxFaGtYQkp4b1BSeUprTWVHQzdxZ2FidGw5U2ZNdk9V?=
 =?utf-8?B?MXJmZ3hKNkU2YW5RL0doL2wzMVlWMVNZaTB1K2wzQnJMRy9HZENaL0tUdVlk?=
 =?utf-8?B?L2gwNUJHSEVraHdOa1lOWWZiZTZDaExrTjRVUy9kUHZ1OEp3U3k3ZGFzL2Q3?=
 =?utf-8?B?YzdFZ2xuOCtPK2RYTXVpSVVZcXl4bHFCanhrV1N2Umhhc1JEOVN1bDNQRzFn?=
 =?utf-8?B?WHRKK1VCRnVWSHZiS05IdWxOQnJGZ2F3Y0l0eHhCRGtSZ3ZsWUdtQnpZVU5H?=
 =?utf-8?B?NTM2WEEwYnRrblJEZXNUV2l2UndlOXRaaWRhNkhXUnBEblJSRHluUGpWWUx2?=
 =?utf-8?B?ZzNkL2UyMW1QOS9hZE9Ndnk3UU9jbHBrZUxpTE02Qkx5aVZtejY0amVaQnRP?=
 =?utf-8?B?b2tFZHNsK0ZJQXVmSjlBYm93Y2IxVHRsQUVjZGt1UkVCcnBXa3NyektUcUVP?=
 =?utf-8?B?Tjlvd0laYXFkSWFXU2NwUWFMeXB3UDJXK2x1U0VIK090dHdyMEZvZEtMcDFT?=
 =?utf-8?B?WUtxN0R1dTVxTE8yVjg5bTVhM0FBY09kMG83d1V3ZkUwcDFackV0STVMaUxs?=
 =?utf-8?B?aHl2Ti83b1V1WmZHRTBiWEt0YURDb0hvanB2TzRmRGw0REVHMlROdjdhbWg3?=
 =?utf-8?B?ZDBMVzl3KzgrNUVQSTJENTl4U1VpWG5uZGFJU1IrN1I1ZVhxdmxRSFM2aEJw?=
 =?utf-8?B?WGphZEVOZThJUS9qajlYcUcxdEV6UFgxaGRDbDNnYTBnVnpuZFlDb3VQL25F?=
 =?utf-8?B?eGNSeWw1K3oxT3pnQ254TEZxV3k2QUdqdUNkTFZWa2ZGMDRLWHpmMlRBTmF6?=
 =?utf-8?B?cGFkTDBkUzFMYU1nZ28xRVNlblRrWDA4RUdPR1NpV1JVVnN2NnVQM0ZmbjZH?=
 =?utf-8?B?ZmgraTBJdXhTbmx1STVGRmRGL2Nmb0hRZ2ZPS2lVWjlWMDBGaDhsck1vcWcx?=
 =?utf-8?Q?3lnBuV+4Gijbzi4jkUCWDfMrn14GEeN+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDkreEI1MHgrUUJKZmtlcVVqM2o0czZqOTdYcUpsMkhkUEJUR2NYRjhpNzEv?=
 =?utf-8?B?bFJybzJSSmNqYlo0ZCtwR2J6MEFuNmk2Ym1KeVJUOEp2MDJhdDhya0dQV1Bm?=
 =?utf-8?B?Uytwa2NLenlRUUIxQUtwWWpCVUR0SnRjRmd1UTB3UlhOWjFnVkhLTEQvWkg4?=
 =?utf-8?B?YzBmblJOOFpmT0xmUUMwN2R1bGJsUG5VL3lMTHFTMkdSalhnSUhXOTJBVWta?=
 =?utf-8?B?eC8xN2FYWTdUUGdCTWYxbURrK0FRSFBSbGVUSnVqem9SV2tOQVBQM0o2T29u?=
 =?utf-8?B?UStCMFNUVzVsa3M3TDFIVlRzQi9HL1o2cmVFQWd2Uy9uZ3ExWUhaaTk4NE1o?=
 =?utf-8?B?dEozQlJDOG0vVnVwSDNUSExrZWdyN0MyYmdpcmxZYUFaMVZhbmJxVGZkZ2lZ?=
 =?utf-8?B?SkdDQkNBYjdrc1FZZlI5RHpMRGxzcHdWaW5WQVkzSlV5ajNvelFaUlNsMitl?=
 =?utf-8?B?RTFyUnF0bDE2UjMzdjdUdG1HU3ZaR1RtVnNkeDJOMDB5T09XVVJ2NmQwOHFp?=
 =?utf-8?B?V2JOM1FpUldVdTZrNWdIQmd2d0tyYjVlL0ZhTkRDMjI1UmIxMGhmWndrSGZN?=
 =?utf-8?B?VUxGSjh3NFM2V3lUZWU5a2tXTmhvREhiZk9NNjBlZS9YQ2JVdFZYNzNIVSt0?=
 =?utf-8?B?MHprRHVIRk8wY2FBdFRlK1JMYWtVVjU4SythZUZWR0VSWnk4MXpZckJFR2xR?=
 =?utf-8?B?MDYvcGZxRnhZVFBaMXpaMjJMbGVaOXhxc1J1RlhPYzIxd2JWUjlrQ2FsVlJo?=
 =?utf-8?B?SXB4ZXdyRzlubnJEb255VkVMbmQ5RmQyaklmTm5xUlVCMmxsWFAwUlhndXdL?=
 =?utf-8?B?TEY2cThhU2tKV1BuMk9vVXVkaXMxa3hpdlE1K3hmb2xqWGVLWlF6aTVFWjBq?=
 =?utf-8?B?cTZET1FPdCs3NzdsN2FUSW5ISDZXWHhNbWpUazBhOXA0WUx6MEh3WGZWeENQ?=
 =?utf-8?B?R2R3aDB4ZXNCeHhRRXVFVEE3QWUvWjhIT3ZrcHpRNGR6VXlMOWw3dDExMU5w?=
 =?utf-8?B?ZVFkeHpFY1JyanVaNGNPN2QyQlcybHg4NUVwMzZlRmUwZ3VZb2w2WlQ3UHN1?=
 =?utf-8?B?NVFYdk5pYUhKWHFvVVMydXNKNkc0Q0s4TDRrRUpsVGp4WE9KenBBS2VaZWVq?=
 =?utf-8?B?VUJ1OEFENUFNMXpTajhhVU54MVUzRjl5b2lCOGg2d1YvSS82akJhUG16RmdM?=
 =?utf-8?B?L3VCODZYVEQ2N3N0V29ROUtoTE1mREFpU050QkNkU2RJcmxYUWdBaHo2Wm95?=
 =?utf-8?B?QW92aUNqS050eSt5NE56bVNUSFNZaGZYYWh1alRncXh1aWNxNXkxaS9mcnVQ?=
 =?utf-8?B?RG5QRllXcFVlTmRLZlJrdWxtY2VWSUtCTVhBbE91VVdNTFcza0wzTGlSeHRi?=
 =?utf-8?B?VkJvT2NURGZmT21aUTJqd1JxK2I0dU1QSENPV0xWUnBJTGhjMk9PSXJBMVg0?=
 =?utf-8?B?Mmt0ZFJLaDZqNE5uN3l5ZjEySnhrRXlrQ3NZNERkNktPTTdoUjhSL0xDZjNY?=
 =?utf-8?B?c1pzOFVmK2p0WXBzSXE0ak9tMTlMM1FKcVUvVW0zUEk2YTA5bExwL3BKalh2?=
 =?utf-8?B?YmtuS1RwL3d4NHh6RWlrV1ZuaElwZjZPVy8zVEpsVEZ0SkVwSXpGUHAvLy95?=
 =?utf-8?B?VlVIRXVSYXhrTzM5MUs0U3orNXV1dTFxVmk2N1lMMVByTThjdklkRDNuaFVI?=
 =?utf-8?B?OWYwWFlPV2R4V0duSlI4MFpIZXJVeVZpMDU3Q0F1QTZFMFhPb3g2VkhiOGM1?=
 =?utf-8?B?dnNpVFhObVlzTUVSYXpDZXdsM2J1OU1HY3hweEhZd2EySmVRaDFNekEvbmtv?=
 =?utf-8?B?L3RhcmRvdXpncFF2empLOVlIdjNYRlBQdzhRbEF0djYvaGtMUFQ1clByUFFn?=
 =?utf-8?B?Y0I4T2NVK0JYaitJQUwyTHlDY251a3M4amg3L1o3VE9XcjRNektiZG1aNFpu?=
 =?utf-8?B?MWNrL29CVXZIWXhISlN0cFMrbWVudDhYb3pkTW1YRFB1OWpnMU1FS3ZTT1hv?=
 =?utf-8?B?eGs3a3I2Q1FvN3ZtbGlwdXFkYU9lNVpEYWJqZWdQa0ZsMTBNcCs0MnQ3OG94?=
 =?utf-8?B?bkRPcmJnMG1vaXJMYzFUaGtDeEtkTVdpemZ3djNMQVdhQ3lnTkJHMzNHYkcy?=
 =?utf-8?Q?ysJHvP+m9pW/W1W/KIoIgf0MR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71eec433-aad7-41d0-95c6-08de152ccc6e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 07:45:28.7996 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXKwyX0mK2FGoRhnZMKzY5xK6y8iK3bXw8mEfloEudahdkGab41ODOH0ObhMn5uE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474
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

On 10/17/25 16:04, Gang Ba wrote:
> drm_sched_entity_flush() may kill the VM entities under certain condition.
> then KFD need to issue kfd_process_wq_release to release associated
> resources, it cam cause following job submissions of process failed.
> 
> [ 3976.788183] [drm:amddrm_sched_entity_push_job [amd_sched]] *ERROR* Trying to push to a killed entity
> Or
> [  129.600916] [drm:amdgpu_job_submit [amdgpu]] *ERROR* Trying to push to a killed entity

Clear NAK. When the process is killed the KFD should not try to submit any VM updates any more.

Regards,
Christian.

> 
> Signed-off-by: Gang Ba <Gang.Ba@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index bebf2ebc4f34..2361c09ddc77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2997,6 +2997,9 @@ static int amdgpu_flush(struct file *f, fl_owner_t id)
>  	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>  	long timeout = MAX_WAIT_SCHED_ENTITY_Q_EMPTY;
>  
> +	if (fpriv->vm.is_compute_context)
> +		return 0;
> +
>  	timeout = amdgpu_ctx_mgr_entity_flush(&fpriv->ctx_mgr, timeout);
>  	timeout = amdgpu_vm_wait_idle(&fpriv->vm, timeout);
>  

