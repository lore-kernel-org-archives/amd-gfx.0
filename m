Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD683CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B4D10E385;
	Tue, 26 Aug 2025 17:18:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="btnxJ9WF";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0C910E385
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 17:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXPinq6XqwzjGWkvB3qCTdkiDh6ODbbYeP+hEJawKpUV76DHhK2BYgxa+njUw2sM7JM/9Td8Ftwb4q1/jlU+k1q3ixU/o1FT1zl3aViiehrAq+M/A2QOzqcmFJzg48hszJWg8feBqQ5rkiNe9+gqX6m8woS4t2sWcQdz3K+E2Txg5Efi74Al1+QvydSsCgwB48pZ9yyMNAwmCA1UC4qQhsP/rEoY61Br7xBXLTaIup1FSLW9Igx4pIBoYAhU0ox73qyW8fIQqT5Li0qpjOerbu6gG3Byo8E8gEUAq56Sb5eqHBeoInOKwmhI9aZI7XoCuSD/VKDr3NlCIb1HLFhQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLuRQrznpkL/WHHWoEwiVEGEYKm3vN/FnPMd38WidiY=;
 b=zUqeNdiBA06bGfz2iMUhvQ8VSeVHv4YxUG/IdSHK+aA+D8E1oDTLfTv56GjC1BPGsUGBxgIe+pbC/83loTQX1ehxa+skZ70BnOzocQ6T7o+/ou3gAzY+2q4JidpT6NK6rdTsJ+SbNwMmKZM6ArFFHwk2aUdfr2nHIWPPrUsfFofAxgcEdCLHNM8FV1l9ElRRKFx9gxb04k/fNnIpsY3iLzoNQfOSUNo+vymI9OI85IIIWGeQ3hPe0HGaj8gjbx6nx3LTS0e8F2Ilz74DY20pA63eVNmm0Ws5TxJjjiOx1WH3n34zZ24kp9d/8HUopeaAC5+LfAezkoes+iWeHhcrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLuRQrznpkL/WHHWoEwiVEGEYKm3vN/FnPMd38WidiY=;
 b=btnxJ9WFEFIsAhVFfhxs6zdvqvWjdzfkCrKoH29B2u22qYCssouHHxGDH1WtpaA/CEsliaNZyizBUpRgoY2ktam/8Dv2E7ocY1Nl7RrKZ3UBZccg29MKlGTe09liGmTkdDuPxwQmKzmTm5afqVst5bghpdAAlYPB85HabHNKNns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by BL3PR12MB6475.namprd12.prod.outlook.com (2603:10b6:208:3bb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 17:18:50 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 17:18:50 +0000
Message-ID: <83d7887d-1204-428e-b569-4612cced05aa@amd.com>
Date: Tue, 26 Aug 2025 13:18:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix error handling of invalid doorbell
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250822161515.1089247-1-alexander.deucher@amd.com>
 <CADnq5_OXrEs8uJVobzufB8E4tZjTDnx-vT6Crr_+4_=PX3Sq0Q@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_OXrEs8uJVobzufB8E4tZjTDnx-vT6Crr_+4_=PX3Sq0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0008.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::18) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|BL3PR12MB6475:EE_
X-MS-Office365-Filtering-Correlation-Id: f667ec7f-08f0-47a4-3bc5-08dde4c49fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tk15L2NlaGRQL25Pelh3MEl1czZiSXhvWjlCV2dDTVBVdi9RdVY3RjBaTlRv?=
 =?utf-8?B?S0wzOWh2dGtrclVxSDFhbUlwZXhON1d5a2h3RUw0TUo4RzRyQmMyRUxSL2NE?=
 =?utf-8?B?UGxveUNBRzVjS2tXQnJ6ZGpzSVZNalhDMmZDdGs2M295clROWnRSQnkvNXpv?=
 =?utf-8?B?MFpHQWpDdTJHSlMyTEdXZU41TmVMWmNDN1NxVkprWjV6cDh3Ky95d2w4UU9Y?=
 =?utf-8?B?Q1FKN29hd3FRS1ZEdGQ4SEhETnlKL1VuSTdFeHYzc0MyMHZzVys5OFZSbWxP?=
 =?utf-8?B?VENvb0E2M1J2RlhEanV2WS94QVpKQlVFMDFkd0ZlTW9PK3hvLzNhUTMycVla?=
 =?utf-8?B?R3JScGJFeDVrNjlaNXdoTnl5SUFKRmZOMDFEOUJkQWJrUTFKYWQxRHNLNHZi?=
 =?utf-8?B?VWF6b2QxSC9XSU5neHNSS1BkdGUzVFFrQ2lsdVgxMkF6ZG9VVGNDWjhyK1NT?=
 =?utf-8?B?aWFpVGF2ZW9oSHBUa1pxVUJqdU4yeC9NRFo3bEJhaHhqM1phN3FrTGg5Yjlp?=
 =?utf-8?B?dlFjRlFteno5SW1LTjNVTXZmeFF2ZFFnM3EzZ3dJV29FeUU4eG1yS0R2bnVL?=
 =?utf-8?B?THArckFCVGt5UzdVNTRlL2dQcWFBdGdVMXV1eGRGQS85SzAzMXBhbk9kMHpx?=
 =?utf-8?B?SzdNVzhLa1p4UStoQ2lESUx4RWJCZmpoODN2UytETGtPN1J3dEdobEtHd2Rw?=
 =?utf-8?B?c0o4SFFmZFQ0YkFsSjJiZ2txeFNiLzlYZnpDeTNnYzZFZHZGYjZMVGlIZzdF?=
 =?utf-8?B?VUxQQzhkN3NBZFN0M3QybStZMEszQ1gvTmdzdVhmYVlDWDM1U1huNk5VOHJQ?=
 =?utf-8?B?UGdmWURWeEZkQTJndVFLN1NiZ3hLWW5FWldYbEtCLzNiQ2JJZGlBaUU1MHBC?=
 =?utf-8?B?V3l4RnZ3UlMvM3I3MnZRL1BURWdaanpiS1ZNaDYxZjlOWmh5UFh4RlIwZTdw?=
 =?utf-8?B?MEFnU1FLOEc2L1pwcmxjWUZmd1pZQytmVGkvSEJTMzh6aDRMMElpZnZGOFha?=
 =?utf-8?B?UUZyc3kvQ3RUa1g3UXp6RU9xWkU1aTRjUjhqNTNsU2FlWHhMcU53T2lYNW5Z?=
 =?utf-8?B?VGpOL2FDSnl0dVVBcTZRL0pQZnJ4QVJKNFpkcURKaUJ2UlZTajNQMC9SMTFO?=
 =?utf-8?B?WnF2ejNMeU5acWNxNm9zdTVtbG96S1Vnbk1LZ3BhWGZCeUhRRmlISGJkajZN?=
 =?utf-8?B?STdscFkxZW5FS0sxdHZ5c1dhNHRsTUJGVWZ0RHVIUS8zRlJCZXRLSUpUTE1M?=
 =?utf-8?B?d1NlQ3JXNXg3WEVoazFIOTJwWmVGUkxERHBONmh2Y3lod1BJVmZIZzN3UWNt?=
 =?utf-8?B?SjM3RzR6aUVHL0oyWWNVWmdHYTNWb3NSOFE0ak1NYWd6VE04c0VHdGlyb09X?=
 =?utf-8?B?MHJ3ZXA2UldwV3h1ME9yUWFEOUdRSkRIMzZTMlRsN0hGNTNuYUNMVEtONW9H?=
 =?utf-8?B?WFgzdURQV0dXUkpOdUpvU1pvbUt3MWI0T1ZWZC8yajhvczZXVnJ5eVlZOGRB?=
 =?utf-8?B?NFVPbnQwaEFCYVN1b0ltYU53dTFYcGtiMVU4NnJTRG9GSU9qQ3RUWlIwSHVK?=
 =?utf-8?B?RlhSRHQzNnU3eWVUYUxhdmp6dTh6eGdoR3pHdVFZQ0xFOW41NFBYNS9WNDFG?=
 =?utf-8?B?WnRlN3l1b09oMFBUc0pXcHRPcnJvR3pBR0xYVS94ckVKakREa0NhNWRWREl0?=
 =?utf-8?B?Q0xrREpBMFY4ZXVkOWxmU1hGQUFmVnovM0JxcWJMZUxyemZKK3kyYkJmTFpG?=
 =?utf-8?B?MlpGa0wyRHhEeEd0c0Y5eG10NTN4M2JJNzltT2IyRWRabnBDVHVSQTBZT1J0?=
 =?utf-8?B?anpiRnBYc016bHBVc1EzTkpGRWx4TE0ydkFuS3l1UVNTaTM1ek9mMUY3TDg3?=
 =?utf-8?B?cWJRNDV2MEhUNFpyOWhjM09OVWlvL09FSHQvQ2Z0VjY0Y3NCVjNoUFVMamZQ?=
 =?utf-8?Q?6yQUCru9VdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHZoV0xnaHRrTlB1VDdvUTJadktHNmdyNHNLb2Y3Rk9uMnpGenNFTjh1MFcw?=
 =?utf-8?B?M2p3ckNBRndMa24vUklvOUlrUnRHQzFVM3pBNlFNM3ZPY0Mya1FmNXFtaWVh?=
 =?utf-8?B?RncxbGhGWmoyMkl5WG5obG9vUGJXUUliY0xobTlhVXBta29CdGo1ZG5CejJk?=
 =?utf-8?B?aWJ3c1RuSENTeEhhSHBFZy9EenFwR1JWQ3A3Vlo1cTVPWXJVQWdsKzdIU0Zq?=
 =?utf-8?B?SVhaWG9pZElkeGVIMk0vL2MrbFg2a1hOS1p1TkFFYVBEdkpmQUR6ZlNZZFdz?=
 =?utf-8?B?eUR0Y3BwYVU4Um5IcERwZTJXS1ZBbERhZE1NM29tNzBoOGFVVDBYQ2ZtSVR6?=
 =?utf-8?B?REd1Q2NEOHZkUHE0TTZwcHVjTS9ZQm04RlIwTHhUU1JrRmYwZ1BDc001aHox?=
 =?utf-8?B?bnVZbEhwZXB1KzA4YVpISTN0Z2R5RzZKMm9zekNkbEdjYzcyNnpmVzcxQktX?=
 =?utf-8?B?dDFMTnNYT1JXaDdORjRnRUFtbmQvYW5xMEwvY3drNGlaRUhqS3Nla1BQeXpu?=
 =?utf-8?B?TEhRVlY0YXZ1d2EvRkNCQ0NXeEVkeHRoRDgwN2hGUFoyYjBUcFdwQWo5VVV6?=
 =?utf-8?B?UDBVVzNzc1grQXN0NDhwVDdvZ2ZIYWtVY1E4bkhxWE4zVVBuK2hsV2ZRQjJ2?=
 =?utf-8?B?bmdaM0YyWG5yMmFOQ3FkczU3cTZodnNiQk1ReWlCS3VaZlBtTmFDRjg0ZlNl?=
 =?utf-8?B?N0VqYXVsUEhlaDgzSjZYNWNnRXhvYy9HOVRxRHNXVnBaV1cyNm5ncEZrbjdV?=
 =?utf-8?B?MEk2MFFvUnRqZXQ0OTFaempNNDRwVmh2eG9JdmRvWWc5R3FnQnJ2VEYvd0Z0?=
 =?utf-8?B?QlVJV0ZQaTNqUy9GajJvbFBKeGwvWHpDQ2tDdmxjaXBqYkRka3ZxaUpLZFJp?=
 =?utf-8?B?SFd3RnpnanZMdXV5V1BkY21sK3ZKRkg2c1o0MW5OTnpmOEo4d2IzaVNVZUVL?=
 =?utf-8?B?ZHlZRDcwZTAvbG1RS2d4UzQyNEpRL2VVVTA3amFLbGRadDlhQzdRbnFpcTMy?=
 =?utf-8?B?TnlWV3hPWHBBNFNNbU5qZEJrS2kwYVBIVkRwUG9jbVlwVjJiMUJ2UWd3b3dp?=
 =?utf-8?B?K3l1bERtM3QzNmlhcmZJT3RMZjhXTkVFOGpzc3NLendEbHhVYWFWTUF1Q1Zw?=
 =?utf-8?B?alk2bGlTbGFtMU8xTlBmd1RTMS9VQjNXNUtDMHQ4bjBwbjkreURTNXBWUWZ2?=
 =?utf-8?B?L0ozWGRJYlNFZUhaKzQ0NHdnckpJYmZTajhOSFdaeU9acm10VFRBYXNGUW5q?=
 =?utf-8?B?dGJCMmZBQUxUaXpyNU1pUHlzTFFHZTJ1WEZ2T3MzblR0b2szZHFCc05OYm0w?=
 =?utf-8?B?ZktJN1ZpTXZVOC9rU0U2RXNiU0lYRXVBT0hEa21XNEVwV3FvMXdRWEZ2d1pi?=
 =?utf-8?B?d254YnFEdVhTMHFSblpmQ2p6YzdUL3Flc2ZzVW5MM1cxZWZQekhvdGViV0FH?=
 =?utf-8?B?QjVaS3NoWGJ5bUViUXFPbHo1bVhUR1dHRjRYU282dURQNjVrektaWmNpYnkr?=
 =?utf-8?B?Y0Y0cFExMkJPakVNMW5DWFAzVlM5dkRtc1ZrekVuYWNkb2ZjSTRrTzFGYkUy?=
 =?utf-8?B?S1NBTTZ5Y3orRTJZRTBCanNXdUM0N3lVenR4OHJDeEZyNEhLd0hzZnVrZjZv?=
 =?utf-8?B?ZjREamthOUdpaU15UUl1dWVSNTFBcDBlYS8rRVFpV2p0d21QK1dJSUJtV2F3?=
 =?utf-8?B?Ymt0MStSSDUvc0RiSG5EM2tBYWlUZHVmbGpHQTFUQWFTR0RhZ0kyVmdUTWdy?=
 =?utf-8?B?elBHSk9NOEtyelFzVHlMTVFWK3VJVk91UWpSOW42Um0zT0FJdm9vZG91OEwz?=
 =?utf-8?B?TSt3dG41ZXNZVkJ3OElEejhCRFZTeDJLODVUTjFtM1Y4UTFWUFRmeHQ5eGxh?=
 =?utf-8?B?YythdTBwY0J2RkV4V3FTbTlwd256akRaZ255aFVwd0I4T3BTZnVtekU5L3VD?=
 =?utf-8?B?c2l4UFU1eUdSdmcydGdaaXkxU2N1Qk8ranNlVWh4SDJGSWFGRGlPU0NnZGcr?=
 =?utf-8?B?ZFlxQmdqOE01Rm5vT2tUL1R1TU92bnNzeWpyKzdRZ2oxUXVNNGdlNGlRdUtD?=
 =?utf-8?B?TFozbDB3UFUvNzRXUzh0YUgwbHZLbXgrbnZqeEh5eWNmMXFDdGFVS1U0Qjky?=
 =?utf-8?Q?hj2CdYGHrtLbVFd4OEqYMVGB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f667ec7f-08f0-47a4-3bc5-08dde4c49fc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 17:18:50.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBj+X1Cn/BbrtQu80LSqtt8gsbmoSJ+5Cy6u6dCoU2JOs562t9ZHEOyBTA++anQD3m+N/HaNt0Y07pgplEqjDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6475
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

Agreed with the change. Thanks!

Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

On 2025-08-26 12:29, Alex Deucher wrote:
> Ping?
>
> On Fri, Aug 22, 2025 at 12:33 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>> If the doorbell is invalid, be sure to set the r to an error
>> state so the function returns an error.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 424831997cb1a..28242ec2215da 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -426,6 +426,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>          if (index == (uint64_t)-EINVAL) {
>>                  drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
>>                  kfree(queue);
>> +               r = -EINVAL;
>>                  goto unlock;
>>          }
>>
>> --
>> 2.50.1
>>
