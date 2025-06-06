Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2653C5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 11:41:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70B5C10E37A;
	Fri,  6 Jun 2025 11:41:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1V/BevaB";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3FD310E37A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 11:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eWUreouUrKeHZ2SbeoNu6U8/DQ63mX9dbOYNTZzcx5R24OQmjyjSSTGfiwnXUGUBHnuxmfNc6+hLJpcUH8dktEvXSnPBSNO0OyIfwW8N6AaZtOeSauj+qfrAfWWAaRVOxOwvfEzgx76KzfeFv8rrzmvaNIkQresjHNEsyeNB3tGlY4q6fqSYS3+wZtxX1G2oKvxC6/ya76DMUCtqGF9FyU7h+az2IxkpPZ363+9d8hcr5DcIuCC+td1yKtErLUN+1+mZ+sTJieQ5/3IBVl+GlsV8WZ+vAqXqqxMssifbQstvd3xZRv89UsQPfWZ1UOBN2IMMWzZYE84Kp0EjC/3YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4cTedTTaVCptQbwNjLWQPRtFKJOH24ttIqZ++EF9u4=;
 b=E9cJ6UWadCfi6f2W26GBgmwfOfIaSGUspjTVQTAcz+m53TKZ+WMUdNtWUWnQ4lAva4NmUoRnVkFA+fdzKbv+5dWNB2A/LAu9eF8raEPE/rPlwsCUAUdrt+oEuqBMJqM1mdoAgrO/AlgqaOnD0WexYCg8M+Iij9+a5gXiqYTurGYu3s/6SyaRfBys5rdxRgT07C/1bI97aRRG445hoDBa/Y6Pa6Yg470a+stbgYC3vWscljAc9wCFhI4iHfFi/8OswMRbASKSZPY+rKNXsZXaGiPBQ1dDvSCIRqvaQWPKefUGRueg57ZoJpsTLr/uK1YM1G252OQFDsHSWb/XAybVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4cTedTTaVCptQbwNjLWQPRtFKJOH24ttIqZ++EF9u4=;
 b=1V/BevaBt6XS+MG1RjuO+GsA/AqSHMSeUBgZTxrrROQhGEY0ru/5RKR7ZsWrg+DEklylp5aVrVPf2N7huTY79nFOFwOINm3NzQrMgczhto5qmbcTH0SH9RefyunFrxJTbwWsKQZwzThDP2TRD+qw+9b9Zr0fJLvotupKaFXe0ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 11:41:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 6 Jun 2025
 11:41:15 +0000
Message-ID: <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
Date: Fri, 6 Jun 2025 13:41:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250606064354.5858-7-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:208:23a::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: d05264e0-59af-4259-b223-08dda4ef0b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3VTeGUyM2JoMnJLVFBtWFUvRHIxNE56NWhxZHdQVHp3ZGZ3RytQSGZFbm9C?=
 =?utf-8?B?WElhYlhmRmJOZ3hzRFJEQVJEajY1NEJXaXgvMlZoNktwdTdPd1ZnTG9GM0Jo?=
 =?utf-8?B?aHViVEduR1N1LzFqL2t0S2Nzc1IvbHZOTmZMdDhmc3dKeUJ6KzRpMWhHaWp0?=
 =?utf-8?B?dVh3SEEwUW5OSkdlL0hIQXZxRVArZjhHcVEwRXlZR1JPQ09PanNueUpkM1c3?=
 =?utf-8?B?bysvMWY5WVdBVSs3VHNseGlhYVhTNVhjejhtRnpWbDk4ejMyYndvWUwzc29l?=
 =?utf-8?B?M1o5aUFiZHFENjlwbUhyUkczbjVKVWpWcXdDK1U4Y09IQkN6ZXZtNkM2eXR0?=
 =?utf-8?B?THloV0JnMEVoWEFER0ZaV3RlTHJ4V2VqNkpLbWNuWUo1aytNQ1l4THloaXJB?=
 =?utf-8?B?a0FHOTZ3TW5hSXRyRzkvV29NaUZKQm9lV1hDMFNuSGZHQlJUQjhzMjVIUUlr?=
 =?utf-8?B?UjhQMjVUMnJQeTRiZm9uanpLNDJSMkRxWHlJWGtMOExZNmVpMVF3dGd0VjEr?=
 =?utf-8?B?YXY5WC90aklNVDNqWXhLRjZEYnFuT3JrdS9ZNFNlUlBObCttMU4yVzF6QWdk?=
 =?utf-8?B?R014SU9ncS91ckZXSzNDOGdYVG1RcTg3aS9kN3ZkTnN4M2FIMlJuYVRQdUs1?=
 =?utf-8?B?b1ZQMFZVQ3lHTUNWVEU2OFlHcGUraG9JT0U0aW1VWVFLRDVEZlJaUnpORnFm?=
 =?utf-8?B?SStLb21WUlg5eEQwdWhxblhWV3l1YzU2R3JWM2tuaWY1N1psZCtZN2QyWm5G?=
 =?utf-8?B?K1VZdHFBRTE4WEF6Qk5QN1BSdHdJamZ6bVduRVBxQ2lOMXljME1SR1JRbHAw?=
 =?utf-8?B?VVd0WSt1NnVRRCsrczQ2WW55Mk1wb3BTRVlwTThlaWFqYVlacVo5SGNtNDdJ?=
 =?utf-8?B?d0RBQVNRT3MrRmk3VlFRalNwK2NDZEpSS0YvemtERnVYSWRxdmhQaVNXVitR?=
 =?utf-8?B?VzFSczAzK1pXSVVNb0VRL2dXanhZdHlaYjBhVjhDMUMxc2gybGlQeGo0cDZv?=
 =?utf-8?B?K0pIcTVPTkpVSXIzcWxTSkpzbVp3NlhCN1BnOUZqcjZCcjBxdmpaek16NFNO?=
 =?utf-8?B?S1ZwVlArQzFCTkFjZkxQU3Y5d1UrRmZoWDE0VUF6aW4yR0IwV21oUllJUlZo?=
 =?utf-8?B?NnYxN1ExMWZzWEJzaXQ3WVcxdVl1NVp4TGRiaUx3em9qZ0JHWHN4QTJDcklo?=
 =?utf-8?B?Nmo1T1R4NlYrNXc1SHNOWnNhQkVVNWp2ZTBTM3RBRlFtYmpPZFltdE5mVTd6?=
 =?utf-8?B?T0tSVFNSSDVGMytnWXNzdVQ0OUo0M2hzRE9DRXYydE5ZOWNJaG1vZjhsbGt1?=
 =?utf-8?B?amhLVElHRE8ya2Zic0NaQmU3anY4aFdKb0d6N1E1U1BkRXQ0bTh3aEZZbjd1?=
 =?utf-8?B?R0ZEVXNVazRMTkFkbVJOQ29kRUVBeFZiNlJJWElYa0tXQURpVGIzQ3NLa0lH?=
 =?utf-8?B?dVVmRkd1WlcyLzg4d0dxUDFIV05oUU1aRVozd2hDbHpDK3JWUVBCc2x3ckFl?=
 =?utf-8?B?Z2cyaHBKMHA3S000amJibnRnZncxS2NWNDdSaVFEOGtjUDFTUEVBOXpuZmtU?=
 =?utf-8?B?dEVwN3ZTMklKUnJBNVMxeW1iUjhuRnpKRFRheXQxUURMTnBhSnJKME43ZkRZ?=
 =?utf-8?B?WWJFVEJOYW9jdjcvZnFjeEtKMEZvOGY2elIwQlBPZ2l4L0xLMklyd2N4Z2Y3?=
 =?utf-8?B?MGpQcmZubFBYSGdQa21RWFlObHc5QjNuVTlOQTFERVpRV2twcjArWGFKZmpi?=
 =?utf-8?B?N1dLYnl5U2IzVDNrTmc3enRaN3IxcmZMcG0vYnQwRVRGUGNqQmtXWVlwblkx?=
 =?utf-8?B?MXhzU2NBVmpYYktQd2Z1bjQxcWduaWtzUGpBVm1vUWtVaEQ2cWMwMG1mVCtM?=
 =?utf-8?B?cnVOdHVoYmFkVWZDN1N5T2JrQlpHMVUxT0o4Y0FaQlhQcGZSN1pOMnhBbGFU?=
 =?utf-8?Q?bE3rX6OG60c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTBCOFJpcElCTUVReVhJUHptM3Jncmppd3dmN29TVWhqQmlPbHNuVGtXa29X?=
 =?utf-8?B?RXdRYXpvaVVVWlhzd2VLd2ZyWDNTQXI5MlhYMFRkUnRvQjZkNmpYL203VmJQ?=
 =?utf-8?B?TEJ5cnNkQTRUTktZeHdEVlo0aERKcE5mTjRQMDYvODZMN2VhSFRsTEVkS2ZP?=
 =?utf-8?B?UlRTeGdrWERtUXdwdmxWdFRtU1loK3lwb1UzbHNQcS9FRDhNeENxZFJXRGgv?=
 =?utf-8?B?SkQzUk01TDlqVXBrQWJQVHlqZDNRVDdzb0ZRMVgyem9rQm5BZStlSlNLNHFh?=
 =?utf-8?B?WUpQUis3enBqVmxXTkJyRVNsMHg4aGxwT0hVVTl2YmdwQWFoc0ZjdEdzbVdL?=
 =?utf-8?B?eFNsRDdaZGtMdnVSV2J1Y0RISUd4ZFQyTXZnOTlLaDZvUlZRQVFHNjFiaXhu?=
 =?utf-8?B?RWtuZFV6ODZqVVJpdlhsdzJyRlZtWVgrN1VkRUt6TGpOcHNOVHkvd0dhZm1F?=
 =?utf-8?B?S2NpeDJ3NzUwVWJVemREelJ5WjNuOXozZEhUZzZYYVFvWGp3WFhsam5ITXFP?=
 =?utf-8?B?TFZ5Y1ZLNnl0R0dwMC9HS0lwZDlQeEtqVWh5SVFjdktuWXdwOXpyRmRTL0dj?=
 =?utf-8?B?QUNIWDdOQVd0UnVLZUhRYzFoSVV2M1ZzSGt5Sm5qTndsQ0FnRFZDMWUweGhi?=
 =?utf-8?B?RUErZnMwVHRiaFlSdzlNSFlaWGdsbTNPRDVlWUQ4ZFhTRVZkUEhRN29pYnk4?=
 =?utf-8?B?L0NhZmFMOU5VU3ZDKys3Mnd3SHJRaGdBTWhIMytlajdET1dDb3JZM3hDRmZu?=
 =?utf-8?B?dGJwdDZ4a3QrRTM4TW1zanNwU3dsUnFlVjdqemduai9GTWU4YU1ZTllvQzJI?=
 =?utf-8?B?L3FkZXFVem9JUnNQTlBtN1NqU1VsRlpmZGdxWnJ5Um5YRnplSlc4Q1A3VXk1?=
 =?utf-8?B?YnFkaEFUdjUrT1Z0RnJZbFFSKzZDVk1zSkxiTVE5K2ZsSjRCZzQ0S1hVQ3Nq?=
 =?utf-8?B?NXg4MWZoMHdYQTNHSE5waGxwdS9wU0dadXR3bnZ3MEhEajQ5MThpaXo3ZkZo?=
 =?utf-8?B?TzJlUk1DR0FCTnBhdm1KSmFzM1RlZyt2cE9YVW9JVENWVnFvVWtUMmFsWXA5?=
 =?utf-8?B?cjc3MWtjWUNBNUNibGhlYU90TlZscmhtVndWNFNmWFE2Ky9OclZrU0FrZ09k?=
 =?utf-8?B?ejlWRmFud3VDSXlnYVhtZm9hZ3JCYjcwS0gxckNlS1puREtLQjR0eUdKaU9W?=
 =?utf-8?B?U1dYamxUYlJuYWNHZFIrOWxkaUhwM0tzOWRub1l6U0grMnYzbXBzbnVvRW5B?=
 =?utf-8?B?bkRIYWpiSDh2TVhnVzN0V3QzalF1bU1naVk2UG1Tb1g4Wnc3WmV5eGZTZDJa?=
 =?utf-8?B?d0RHNXVPTVhNakwzYWYyMy82MjZ6U1I0SHBvbW1TUWN4c2lLQlRZb2pGWjdB?=
 =?utf-8?B?am16ekZ0SzVnNUVCM0lPYUZuckVVTlB4VHY4Zk96U0w0ejBWRW1QSXZzRmhY?=
 =?utf-8?B?engrMlMzdHA0TGc5RDkzZHpSa1Nocm0zc1EzM05Qd1dKQ1VIMlZzRzBPNkhl?=
 =?utf-8?B?RGYzdlpjaFY3YkErMVQxRFQ0NUVYSUxjdmQ0Z1dndTRPUVVmcUpvUzVabys1?=
 =?utf-8?B?YkNUOFNrbGEvYUVralhsYUl2T0NGZlI2RnU3UHY3Mmt0ekc1WDNTMkQ3TGth?=
 =?utf-8?B?VWk3cjdZZFpDTkw2QnBaeWlVckRCZStub01GSjY1ZW1ZNmN4K012TFhkQlhS?=
 =?utf-8?B?VEtpUk03d3puSUtJNHZxWHhLVHhESmMwYjNienlENDNRTWxsYWJ1SjZ2VGFF?=
 =?utf-8?B?SEg0NmtsNGVUbXMvMkZiYzRNdTVaQmNMdGhDdG9LOUpEamIvK3lTSlIvR3JH?=
 =?utf-8?B?WTRlN01oNTZqNmkvd1g4UjR4RDdTWXFVcDZFdWsrRytYaVpDS0p3bnc4Z29H?=
 =?utf-8?B?MTkrNzRFVXNrTk91MHAzM3d1TGtQSGVaWGpWS1B0TDAxampQUldoeTFIUGJo?=
 =?utf-8?B?Z2RvS1NrN1hFYWFuWkFXYk5UZ3VibFIvandSMjZ1SDFFTmVWb2FJUGI3N0hm?=
 =?utf-8?B?cXN6d1cxNVYvWDNxVVZ6Y1VSMjBlbi8rR3AxR0IyRzZVMlNvR1ZZbUNMOXlJ?=
 =?utf-8?B?VnJocVR5ZjhXWjFQZ0F2ejlLZWdGVXk1M1JBL3VlSExXNlloUzU1M0l2dEM2?=
 =?utf-8?Q?7uLTUwu+4Za9Dnc0k5a7whzOR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05264e0-59af-4259-b223-08dda4ef0b8f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 11:41:15.6126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7dCmmvufkG5lesQyFr5aWI9hSowMIage4UwYJ/3PDNxCIIpIbGPyYnhPL6FQitL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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

On 6/6/25 08:43, Alex Deucher wrote:
> Going forward, we'll need more than just the vmid.  Everything
> we need in currently in the amdgpu job structure, so just
> pass that in.

Please don't the job is just a container for the submission, it should not be part of any reset handling.

What information is actually needed here?

Regards,
Christian.


> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
>  22 files changed, 53 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index ddb9d3269357c..80d4dfebde24f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  		if (is_guilty)
>  			dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>  
> -		r = amdgpu_ring_reset(ring, job->vmid);
> +		r = amdgpu_ring_reset(ring, job);
>  		if (!r) {
>  			if (amdgpu_ring_sched_ready(ring))
>  				drm_sched_stop(&ring->sched, s_job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index e1f25218943a4..ab5402d7ce9c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
>  	void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
>  	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
> -	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> +	int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
>  	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
>  	bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
> @@ -425,7 +425,7 @@ struct amdgpu_ring {
>  #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (o)))
>  #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
>  #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
>  
>  unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
>  int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 75ea071744eb5..c58e7040c732a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>  	amdgpu_ring_insert_nop(ring, num_nop - 1);
>  }
>  
> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  
>  	addr = amdgpu_bo_gpu_offset(ring->mqd_obj) +
>  		offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
> -	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
> +	tmp = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job->vmid);
>  	if (ring->pipe == 0)
>  		tmp = REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES, 1 << ring->queue);
>  	else
> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  }
>  
>  static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> -			       unsigned int vmid)
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index afd6d59164bfa..0ee7bdd509741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
> +	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>  	if (r) {
>  
>  		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r = 0;
> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
> +	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>  	if (r) {
>  		dev_warn(adev->dev, "fail(%d) to reset kcq and try pipe reset\n", r);
>  		r = gfx_v11_0_reset_compute_pipe(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 1234c8d64e20d..a26417d53411b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
> +	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, false);
>  	if (r) {
>  		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
>  		r = gfx_v12_reset_gfx_pipe(ring);
> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct amdgpu_ring *ring)
>  	return 0;
>  }
>  
> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int r;
> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
>  	if (amdgpu_sriov_vf(adev))
>  		return -EINVAL;
>  
> -	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true);
> +	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid, true);
>  	if (r) {
>  		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
>  		r = gfx_v12_0_reset_compute_pipe(ring);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index d50e125fd3e0d..5e650cc5fcb26 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
>  }
>  
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> -			      unsigned int vmid)
> +			      struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index c233edf605694..a7dadff3dca31 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdgpu_ring *ring)
>  }
>  
>  static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> -				unsigned int vmid)
> +				struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_kiq *kiq = &adev->gfx.kiq[ring->xcc_id];
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
> +				struct amdgpu_job *job)
>  {
>  	jpeg_v2_0_stop(ring->adev);
>  	jpeg_v2_0_start(ring->adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 8b39e114f3be1..8ed41868f6c32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
> +				struct amdgpu_job *job)
>  {
>  	jpeg_v2_5_stop_inst(ring->adev, ring->me);
>  	jpeg_v2_5_start_inst(ring->adev, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 2f8510c2986b9..3512fbb543301 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> +				struct amdgpu_job *job)
>  {
>  	jpeg_v3_0_stop(ring->adev);
>  	jpeg_v3_0_start(ring->adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index f17ec5414fd69..c8efeaf0a2a69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
> +				struct amdgpu_job *job)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 79e342d5ab28d..8b07c3651c579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct amdgpu_ring *ring)
>  	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>  }
>  
> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> +				  struct amdgpu_job *job)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index 3b6f65a256464..0a21a13e19360 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
>  	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
>  }
>  
> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
> +				  struct amdgpu_job *job)
>  {
>  	if (amdgpu_sriov_vf(ring->adev))
>  		return -EOPNOTSUPP;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index 9c169112a5e7b..ffd67d51b335f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
>  	return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
>  }
>  
> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> +				   struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 id = GET_INST(SDMA0, ring->me);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 9505ae96fbecc..46affee1c2da0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return 0;
>  }
>  
> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index a6e612b4a8928..581e75b7d01a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgpu_ip_block *ip_block)
>  	return -ETIMEDOUT;
>  }
>  
> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	u32 inst_id = ring->me;
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 5a70ae17be04e..d9866009edbfc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
>  	return r;
>  }
>  
> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int i, r;
> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> +	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> index ad47d0bdf7775..c546e73642296 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
>  	return false;
>  }
>  
> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	int i, r;
> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
>  		return -EINVAL;
>  	}
>  
> -	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> +	r = amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true);
>  	if (r)
>  		return r;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index b5071f77f78d2..47a0deceff433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
>  	return 0;
>  }
>  
> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
> +			       struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 5a33140f57235..d961a824d2098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	int r = 0;
>  	int vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 16ade84facc78..10bd714592278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index f8e3f0b882da5..7e6a7ead9a086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring)
>  	}
>  }
>  
> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
> +				 struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[ring->me];

