Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50554CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:34:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1D8710E66E;
	Tue,  2 Sep 2025 11:34:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iqr/NsgF";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A45A10E66E
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAMcBMWu+z/2IOps8HUWK5LtdEaFFz85smTpjJJruhQGlhPzPtYmjR5w8OizMJCHT6xH3gFLLHeH+m879RCzhC+3dVktJ3vq0TR+Jq7++UpBPPep4wodw2gXC7yYHpuUb/O4nXPvimbhwGGB6gatc5M0mbVYaMZcd2vu0DZRJhYDTfJf7Z8Q24rHT2+Dez695uZvw3vgWZ0tnamEUlaEcYwjK2Q1qQ2U+G/GnFSxRzcW/nRi0O/N34bD+yTE9G9j4lRPv61KbHvuo/sWLXx81/s0JzyxhLkQDHC0i/A5GnPNZNhnX6dw8tlOpO0P+2j4+h0BPKVomZnZU+Zkd+dhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUrKsvAfEfjFV49ShxE5/AsXvp5AKukM+yI+t+PUU/w=;
 b=k0VrH/qZik8ntqtENSGvIDXIj5tlQm+Ee7wlVjw+4MdlAop/InGvWk3fhfgTNYZ2CVMu1KerT04q/LWzVqBAuhEV+za0Ekwgy6zdb59UrxVddUeLwpi9rmg0w3Idagl5a5kxsXLKmub9TNw1b8k9xg3Q+p3UI//d4sJW/GnTMp/RvK105vT1g4WEt82aHePlaRUrIxjIGwPkdfv7DpyT8BxpDHDF4cTyOP+zzIXw2x7sVLoJHS39jHO9EAeq783QtgdMg255rBhEz8B/EDXRUzgIJ00PhE/qm0HSuf5bNMoHGeRWtaFB5IbeHbpXF/foxD9BVLzpPVgTayqqYi0uWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUrKsvAfEfjFV49ShxE5/AsXvp5AKukM+yI+t+PUU/w=;
 b=iqr/NsgFi97mJu5AMCjBK22di1JzCt8zwcYUqTyey7Ym1SeF9qjDFb9vWWmCrn4Og+WImaG6heruQw9w7Fzv/O7QAYDXgconKBaOvhsIwo/9mcRA3yy4WBK4QiP+uhXGZ7anE0hCNx+QVDmNFnDArHdTjFkQyxboYVJw7KUlSX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:34:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 11:34:07 +0000
Message-ID: <35ab007f-ff54-4402-aebe-915a1b3bf958@amd.com>
Date: Tue, 2 Sep 2025 13:34:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fill extra dwords with NOPs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <20250901100012.439155-3-timur.kristof@gmail.com>
 <9d3566f4-9ede-4d4c-8849-2ccac3fa65a6@ursulin.net>
 <1aef6170994c05c98f215690665f837529da5950.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <1aef6170994c05c98f215690665f837529da5950.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4473:EE_
X-MS-Office365-Filtering-Correlation-Id: d38f478b-46ac-4674-50f3-08ddea14a0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2gwZ3ArVmpZdXJBL2p1cEtaRFdjZlRQc3ZDTkQyVlZpUlp6eEtiemExc3cy?=
 =?utf-8?B?MjZ0QjNHc3B4K3lwTW9QN2ZmZFBGKzFlekRhRGl1NUZFRGJaUTVCWS9PL3Nh?=
 =?utf-8?B?aDNDdHpjQUszNDhDcWZ2WEhSdUJnYXA0T2V2UEY5NnV5SURuRENmR3FMRzMx?=
 =?utf-8?B?ejJPUEJ3NGkzZ1MyaWRtc2xXTlRabkRFOE92SHVXMHBJWng2QzluRDAwcmli?=
 =?utf-8?B?MDdHL2RqTmg5ek1TaHlYdWNQcmE1bTNRcGpUQ1crZVduZWNuMkgvYnBUUkNI?=
 =?utf-8?B?TEI2TGNNQzZnYzB5ZzEwZFNaNFhYQzFDakRtbGtSLzZqQ0RjSWhHTkRqV0Mw?=
 =?utf-8?B?Q3VjU1N4cU9ZTm16TUQ1RzZMeDN4ZVZ5RDBORTIwNTdQd1dTaXh0TDBFRDBC?=
 =?utf-8?B?TjIxNkFsTjFZUUpyUDZuSnpaUUlVRDRNMGg3ZUJWL1FIRnRaNVA2clhCWW9y?=
 =?utf-8?B?YWk5VTZoUlRSaHpCa2JvY210Qjh1QmRhZ3hPK2JSeFNaSEVJWTlMaGpzQjM2?=
 =?utf-8?B?WnBjNCs3d3NzZmJHY0JQU05ZeWc1VmxhZUd2RkpPeW9ySUM2NmlJTGpsc292?=
 =?utf-8?B?L1Z0aHQ4WHY1alhSckoyblJTdnBXQ0VLaXNHSmU5OFZudjNYRGlDbmtYK2VK?=
 =?utf-8?B?MTBzcHhXV2xaMEJQOVBGbHc2aGxKa3NCL2NqcnExaS96elNNRkk3b2pRdXA0?=
 =?utf-8?B?M1UybnFhVWJsMG1kR0pudm5OMUN5ek1yQWtSUm5rR0FNOEtCNnNuaWtwc1Mz?=
 =?utf-8?B?dksvRkVZVStRc1BoU3JXT2xxL0ZBdWRNUHV0NW9udnhJTTE0RnhaNlpjdTdx?=
 =?utf-8?B?VzQ0M2RsVGMyenlXTGxQZWNMRUZOWW9VdWhmcGUzUU5jVXh6b3VReWhuZGtu?=
 =?utf-8?B?M2pNS0dnekxaMjA1RGRSM0JNNEY0OVBQNGlhcGt2VnJYdUI2cDdRYkNyN241?=
 =?utf-8?B?ektpOC9iYmMxbjZJWWxEc0lCRlhkU3hvNmNiV25MaXJoU0w4SzZyK09mMXBS?=
 =?utf-8?B?VUhod2h1YWptNU9tRGdOamVPRWNWMHZEN292U25MSE9UaDUzZTlTd2k5c29H?=
 =?utf-8?B?aWlUZXN4a2NkQ25HMW5mcVBSNUVmdUdNMjQrcmJCcDhmbmVMbTZ6Zk5WbEk4?=
 =?utf-8?B?R3lPYWwxdzVlTWVJYTVYOFFRakdVejJqeXpiOXIxa3JueEFUTWMzYzJBTDg4?=
 =?utf-8?B?TXg2YVBleUFqYVpRQjZtdXJHYk9reTRKQlFQbzVDSm5tUDRUbkc3eXdLeG92?=
 =?utf-8?B?dWdicjk1S01xS3lnL1Y4b1c0dzhVeVpFRmNva3ZxMENaRm9aNTZ0YUgvWnFn?=
 =?utf-8?B?akpuNVJTWnBncDNGOVdpU0VIa0U2Y2hIMnhJbGtONU1WREtxSm4vUWlxaFFv?=
 =?utf-8?B?Q0RWZm5acDFUUFNSWU9nMGdtY3dIeldLT1dkZlJpUzd4c0F4TEJtVEM0K3hO?=
 =?utf-8?B?ekxxVUQwU0NpZ2VNQVVwUkJpUEhualhaNm1Pdi9iSU9QRThYVm1YYUdEVHlM?=
 =?utf-8?B?YmlHRUs5WjY5SFRXQnlrekVxWUNSMC9DOVVLQVJlNlJCaDROZG5uak41YjZk?=
 =?utf-8?B?OFBJaUU4bEdXMjJxN1dBTWRFdEVUazZaWXJEbEd3UUdXc1pXc1hCNFVGUnV3?=
 =?utf-8?B?THg4Y0FpaGt5QTczL3Y1UXV3VHBoSkNRMWdtOWdid2xTS2hIaDFibFNmZXdm?=
 =?utf-8?B?SUtRMGh1TldoVUdqb2VMdmlXOTkxUXRTQXB5TSthelAxczRFMVRyTWppbVYr?=
 =?utf-8?B?RmV6YzIxMzVxWmNCY3h5bXo5cWM2T2ZueERmaFdUK0tuUzRFMHJ3a1VBTm01?=
 =?utf-8?B?QjZqUXJ6MVp2MVY2dDFtMGgxa3MvckhkZHNJSmhKMWJ2K2VCb20yUzBLYWlo?=
 =?utf-8?B?TzkxbDJXNVJ6WGdOZlI5b2QydjMramNxelJsYWFMZzFiRG1EZFJvS3g1S2xN?=
 =?utf-8?Q?dVbUo3Slg1I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0twYytpM0lRVHdDMVNYWHFDL0czNTFLWDRMMlFSTnE0WWwzK0g5TU5oWmQw?=
 =?utf-8?B?K3FnNXBITUJSbjBpS3Y1bHJhejkyNjdWd2pyb3d3TytKWEFzaDVtZmdQNWFC?=
 =?utf-8?B?YTBMd1JJNlNuRnpnMlFrdWlDVStLdUpjUjRWWERwSFo4WUxtWDNKZ3pxTHNF?=
 =?utf-8?B?c2x3cWNrSkRFWEhBQ3FhWURnOTFIc3A3c1dyTFluL3dGVlZJUmwrT25scGxT?=
 =?utf-8?B?MXFuZ3N4VTZvZThnY1BFckVnN0NaOFBqNTRST2NOSGd1ZFpzMDZGOWcvbUVj?=
 =?utf-8?B?NGhab0hMT3dFY2VxV2MvaUo0QjJQM3lEbFRRY2xZSEhYK3FvTk9OTmJFR3hC?=
 =?utf-8?B?VHJtM1hnUFB4clhNS1JBRG1zSDVkUGZReE85RGpiZXB3aUtGazJQMUhoMEZ3?=
 =?utf-8?B?V1kvRjFvWk9IOFVUODJtbjZnZUZxaGFEVDZZKzhTcDRSLzFON0JiUjR2b1NS?=
 =?utf-8?B?eHhBb1VFNVpCc3I5QkRmYzlvUDAzcUQwVlNORlRZYWk3dmNNcW1oZ281eWhu?=
 =?utf-8?B?eC83VWRJY083RDBwUnhiMGo1aVI5OG1vcXRsT1hESFNFMmZvTERoRFJndmxC?=
 =?utf-8?B?dmNvSFZiajl6UTBEdWxGUW5GQmZJLzU2WHUxQ0U4UEF4aGxDTW1BbjZ5ZW9Y?=
 =?utf-8?B?VzZvb2dMdG92ZWVVYkd6MVppaDJFQnZLb2dUeEE4SW1PT2lDOW9Db2lFc3FD?=
 =?utf-8?B?RXRQVGsrcFVaS01iUEM5QTlRcXBPMklHdk15OWw3a2NvWWlYd3hoYTFBUWIw?=
 =?utf-8?B?ZHFoaHl4aWRjNVNQYjlGaGF3cWdLeElzc1hvekVETDFEV3Bja0RiaWxaYlJP?=
 =?utf-8?B?K3BGRG9qTXo1eFA5UGFYNmF3VjRxRTV3WE1ValFobzkzU2tHNWxpWndCaERm?=
 =?utf-8?B?S25vSkhBdlNpYisrdVNjZWZ0VUxJTERtTjFTOUNxWlRNaHB3ZTRhd1huUEgr?=
 =?utf-8?B?aXRVbHZIZEVMZlhQdHdxcEJCcjRSazhSMmlVSlo2d0I3cXdXd1owTnV1M0Fl?=
 =?utf-8?B?Q0NZQythRG1ZSXluRDhCb3VKSlhmZmwyNGJEdW1OekFRSWxhVU50Y0ZiNXpl?=
 =?utf-8?B?LzRmaXpJdm80VVQxT2VtMmpXZXFKcllVNElpenc3US9aVXFxZkRNRnNpbFJT?=
 =?utf-8?B?SGs5cnBvNnh2YThQc3dMYmd2Ym9ncWhuRkpmZmhFRVY5SnFKUW9FVHVDYThq?=
 =?utf-8?B?QWwwWGsxSWF6VVdCTlVQaThYWVdCMEJnQWdqVmJpTGVFTkg3dWNuMDhUTlVM?=
 =?utf-8?B?QUZVenprbytWblEwK1RsSzM0VlEvOHJiMWdOZkpRc2ovRkZmRG52ZmgwdHpJ?=
 =?utf-8?B?aTNJdjVkR2lueHI2dVZXU2phRnVoWURWV1JlYW9RRU5BbUxDd24reUk4SWJl?=
 =?utf-8?B?d0txeTMzMDFzSU9lRGc4djljZFNXY1RkWFViWFRjd3RvWWtsV2NSZVp6bHoz?=
 =?utf-8?B?eWh2KzQrcXVKd0lEemtsL2ZhbGlUKzFtUCtjdW80azJ2RE1JU1VMQW0yL3pn?=
 =?utf-8?B?TU1pWXRPQUI0RlR0NVE2S3ZtMi9paDUreW1la0wvYkg5czZOMXRCVHZJNkFs?=
 =?utf-8?B?ci9EWUlORXFZOVRWVUJCYjdobHplcDlBR094dEpPMDN4R2xZdE1lVmpvTEZR?=
 =?utf-8?B?Q1E3S2twM3gySjJEdGoxSmw5M1RJekVWZTRxZzRrdE9xV0RYK2d6L0pCZHEw?=
 =?utf-8?B?TTQySlZyN0YyWW16OXpSL3Bucm9rTUNENG5CRHR4bWhqWnQ2SFhFL1Vuczh3?=
 =?utf-8?B?M0hhRU1Mc1BaVjJmMUN4WThuL2NPd2tIS0VqUlM1a0hxaW8rc3IrQ3pURkEv?=
 =?utf-8?B?OGdJYUxHWFA4WVRHOFFWMFNXQTMvTlpGekVXaFRwdGZRQkxHYTFmUHFsU09w?=
 =?utf-8?B?eGt2a1R1ZkhSSGczbHROTy9vOGhDeFRSTm5kcHNiYjJVc1cyeWFtTEFVZEpq?=
 =?utf-8?B?cU84VlhESCtKa21aL3JOTnZnckJIUk8yY0Q3RWwyNmlkbER5eklzc1pjVzNq?=
 =?utf-8?B?MkVLT1dWQkZkWVNDd09tNmkxSXZXYTJHMEZLcXdxeEs2YzFCcEV2OFN2Q2pP?=
 =?utf-8?B?VTQ0ME15NTl1N0g0bjducGJtV1FYd2dqTmRjbHdvS052ODJRbTNjRUc5NGRO?=
 =?utf-8?Q?q2l13k6IL1z6ngCv/vNA6TBdD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38f478b-46ac-4674-50f3-08ddea14a0d5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:34:07.7961 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Rk7pWlLTdWf4i6Ggpw9OqULYToqe4wz/+f1GU/lw1f7fJVMVzhAUZeqJaw/cRBA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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

On 02.09.25 13:30, Timur Kristóf wrote:
> On Mon, 2025-09-01 at 11:13 +0100, Tvrtko Ursulin wrote:
>>
>> Hi,
>>
>> On 01/09/2025 11:00, Timur Kristóf wrote:
>>> Technically not necessary, but clear the extra dwords too,
>>> so that the command processors don't read uninitialized memory.
>>>
>>> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
>>> jpeg ring")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 7670f5d82b9e..6a55a85744a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -474,6 +474,11 @@ static inline void
>>> amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>>   	while (i <= ring->buf_mask)
>>>   		ring->ring[i++] = ring->funcs->nop;
>>>   
>>> +	/* Technically not necessary, but clear the extra dwords
>>> too,
>>> +	 * so that the command processors don't read uninitialized
>>> memory.
>>> +	 */
>>> +	for (i = 0; i < ring->funcs->extra_dw; i++)
>>> +		ring->ring[ring->ring_size / 4 + i] = ring->funcs-
>>>> nop;
>>
>> Should I resend this maybe?
> 
> 
> Hi Tvrtko,
> 
> The patch you commented on is going to be dropped.
> 
> However, your patch makes good sense, so I can include it in the next
> version of this series if that's OK.
> 
> @Christian - does that sound alright to you?

Works for me.

Regards,
Christian.

> 
> 
>>
>> commit 11b0b5d942fe46bfb01f021cdb0616c8385d5ea8
>> Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>> Date:   Thu Dec 26 16:12:37 2024 +0000
>>
>>      drm/amdgpu: Use memset32 for ring clearing
>>
>>      Use memset32 instead of open coding it, just because it is
>>      a tiny bit nicer.
>>
>>      Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>      Cc: Christian König <christian.koenig@amd.com>
>>      Cc: Sunil Khatri <sunil.khatri@amd.com>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index dee5a1b4e572..96bfc0c23413 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -369,10 +369,7 @@ static inline void 
>> amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
>>
>>   static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>>   {
>> -       int i = 0;
>> -       while (i <= ring->buf_mask)
>> -               ring->ring[i++] = ring->funcs->nop;
>> -
>> +       memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
>>   }
>>
>>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
>> uint32_t v)
>>
>> Looks like with two loops it would made even more sense to
>> consolidate.
>>
>> Regards,
>>
>> Tvrtko
>>
>>>   }
>>>   
>>>   static inline void amdgpu_ring_write(struct amdgpu_ring *ring,
>>> uint32_t v)
>>

