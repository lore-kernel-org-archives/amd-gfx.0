Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F04ECCD183
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 17:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9310010E234;
	Thu,  9 Oct 2025 17:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MbxUst+l";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4BC410E234
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dni/1Jn2y0L01tqeypJ9tCglEqFW799nW7wUMRgB1VA5oWUf+UYSE9mmNi+owAjMu3i833gqXJvE28FQBs+2waND9gUpkUEi4AKqckpDsD9Mapi3+f5riGay1r4Ky+p8pVFB6dx2Gdof4ZNCNZchfZ5IvlyBmBu0E7tUk773hw8Q0zOAo4sCl/e/jFoPtg3DkcdXmpjs82l+Sa21/ddzCtQPMzzzVazoAOc4GwTSM4A0xASovInWVwxTBzv88uYlxIP9TJxcV1LApFTWuCCPbK/ozNxiRIdZFDzW4NPOf8kT/vrkIulytfOdZSjFvj3rSzCZa1ijptzt6C9oZG9mAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdzga/N9SyYq2AS0bo0z0MqUH7p4p1y8m793tZrfk58=;
 b=Frs0LjFSURx31JMup80zlwdDcyAcaPHGV3RKZhPZEDCsw5BEJqMOf3U30NjERMSxiR89KZdADI37nqzKYhbBWULMz0r2XjMdCG7dWaEpjHw7+CyWia4z1/Rem5j/6+PBdDhhOMW3oUXpVNQPSjLGmwoM3ET9xJweiDYZoGN/vvZTXLot1kQsv9H21v+wb0GWOxSUnEz7ya12EAmmHLRWELw/d9o3J/UtCag0FFcj2J9PPloBjC5kBPoYK1CY9iwN/c12ywJBIRN4QiKqrGArcOVT0OXCOQnIkFjORS1UKv1ZpeQUoeCNoecst84hKfoJBm2/7dzB2TgwoWFFVbfspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdzga/N9SyYq2AS0bo0z0MqUH7p4p1y8m793tZrfk58=;
 b=MbxUst+l/a+K+k1mFDZrcr8q9Dee1z8s5y0ZANyT8eTCdc5O0+oHcxIu1FalP4tu5zi72W1YdEzTgmmUMPrjZ9CIIuGo+uNIO7pWr57C8oPVXx0xtldufBaky7Z2xfQLfW+SWTjkw/wj9vdvQKeUxutIPm9OkbCDd1wLJkrCid8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 17:26:42 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::9e93:67dd:49ac:bc14%6]) with mapi id 15.20.9182.017; Thu, 9 Oct 2025
 17:26:42 +0000
Message-ID: <f7bb25e7-0a64-4057-b068-5fb63d5d287e@amd.com>
Date: Thu, 9 Oct 2025 13:26:39 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] Analog connector support in DC (v2)
From: Harry Wentland <harry.wentland@amd.com>
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <Daniel.Wheeler@amd.com>
Cc: alexander.deucher@amd.com, alex.hung@amd.com, siqueira@igalia.com,
 christian.koenig@amd.com
References: <20250926180203.16690-1-timur.kristof@gmail.com>
 <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
Content-Language: en-US
In-Reply-To: <0fb9b183-ba74-4837-86a1-499b3acf04d5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:208:52d::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d68abf-1db5-48ea-3d7a-08de0759033a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGFqclVPeU1aQzFHN3JvaHFZN1k3UVc0OUMxTjE3bkhHMmg2bk9YYUpiMldv?=
 =?utf-8?B?ck50V1dlazlRRXpKUEd5dVJCa2pxQmlGVWtFMUlkN1hIY0lMOUlLamtoTmxZ?=
 =?utf-8?B?MnQ1QUQwK3NwbGFkQ2FsQjZJR2E5MGVsSjlqOXNEbDI1YmpSc0s1WCtpZjAx?=
 =?utf-8?B?dHBrVlc1Wk1FOFFXcnQvNmViNXJ3Q0FzeE1mVlBiRjIvcTBCU3dQeFF4Szlo?=
 =?utf-8?B?SDU0aTB3cnFuSUhUL1B5VFNObnhNMzJzS090eFV3SFNqTDNROFQ4ZW5ZczFz?=
 =?utf-8?B?aE83QnVuUXB1VzY4VUZBa3I1bWNuY05pekR1V2lJVm01WGxlaDJjMzh6bU01?=
 =?utf-8?B?VTdFUVVvYnU2ckp5amx5Sk9JVkZ3alI2L2FtNmhQYXlyaVM0SFpJTVFjSUdq?=
 =?utf-8?B?SmlpWVRKamR6ZWVUdkdRb0xwUG03UGNVak9GNlpYT05IOUVjVG9wMTVDTDNQ?=
 =?utf-8?B?aGQyZGF6VXd0VWxPVXhDSFE5SlZ2MDZYOURKOE51UERDRzhJVmxiZXdSM2to?=
 =?utf-8?B?NE5rVGRtK3ZlSEhOdXBWUDUzVFc3QzN1aEt0THRvVnlaU1UramxhS01Ra2dC?=
 =?utf-8?B?eFA0eWxweTc3NkZkQXRBU3RucGxRQWp2T0J0N1lpcEZ5aHNRdjEzNk96Sk5u?=
 =?utf-8?B?eHI0NW5kN0tKVDdzb2FnZlJyK3JacnFybHdIdkNkajU0bzF2ME5QT1kyMUpo?=
 =?utf-8?B?WkIrQnFPRzNlMkFTYVBCM2FkYTdsQVhTWmZUV1Rlak10QkNiZDU5U3N3ay9B?=
 =?utf-8?B?YlZuREpMR3JHT2VpRHh1aDZLbkJGaktZUHlMelR6dVo2bEs1VEgwYURxeS9G?=
 =?utf-8?B?OEEveTgrcHl3VjhxWVFsV0M2djBkQldTV2gyZll1S0tzUUdDZkdWUW1Td3Bt?=
 =?utf-8?B?ajByOG1QOG84dlJncWMyczgxZ3JBemYwSjUyQ1hHem5QU0hEUkhKR21vU2wx?=
 =?utf-8?B?c04wS1V5Y0VXMjRHL01uemdkVURDakNnUTE5K1J2SFE0YUtTOHB0R2JRbG80?=
 =?utf-8?B?NkNCRHZMZWpuTFZCbWU4eXI3cy8wYllSYlBaQ2x4NEw2YXVaZkJLck5BSlVk?=
 =?utf-8?B?aUhFTTFZYUNFU0xzdlFRdUpncWhxb0E2Uk51cU1zeE9acnY0N2J4K3ZnUE5P?=
 =?utf-8?B?TW0rczNGalMzcE9DNkQrWHI3WHJYTUZSaTg1OHhmTGR2RlRTZTJzNi9pQVNR?=
 =?utf-8?B?WE9rQkVSQkFXbmc0QURPTjN0ZUtkS1JHY0dNc3hpM0xHbWR5OGtXdXdnMTZW?=
 =?utf-8?B?MXBJeWdCNlpBaWRiQm5rY3VSU1dRM3dwSXlFUVRyU1FFcEkwVzZxMmc1Q2xC?=
 =?utf-8?B?dDJQSElmMkxaSVozdzlkT01UMlMreDBJZ2QvWnp1dFBaTDQ5Nm9kNi8wd0g3?=
 =?utf-8?B?dVJIV3JrR2EvOU0zUzgzaHZsVU4vT05xZ2ZpWllyUFgzbDRXU0JxWldpUHhU?=
 =?utf-8?B?RFloUXFkSzdFTVprUGtvYnU5M1hoZGpQVjh5WkdrRFp2L2I2NEtyN252N1pv?=
 =?utf-8?B?K29CU214ODhIY3BZSWlGWEJnd2o3VDZjalh1VW1mbnYySk82aUlBcStJeC94?=
 =?utf-8?B?WG03TUN1M0U0VmhhdjNTNTB6V2VsbG9rcUdMbVVTNUVtQjAzOTl4cW1xb2JD?=
 =?utf-8?B?OWkyb2RNeEk5KzBHcXhOOW4yYk5LTE5DMmdMbmtMVC9NWG5wbEFzcnd6ZnZM?=
 =?utf-8?B?UTdFWnhmVUlsTGhiV0NFUXhiM3YvZUNkenl6Q0Rnanc5RDhFZUV6MzJHL0t6?=
 =?utf-8?B?bHI4SmoxZ0NydFYyeU9OMm04NWpubHJLVkR3MHN1SGtjZkhsTThod29HMlhP?=
 =?utf-8?B?Wi9IRGwxeS9YUndBRDBmYkhWKytvS0cyQVpOWXd3aWtNdFdyenZTM2Frenh6?=
 =?utf-8?B?dk4vQ1o2N2dkcG5NWndFenJlTjU0L3dqZDRheFU2NkN0Q28zbVRmcUJubkJz?=
 =?utf-8?Q?2S0zhNYTONoWthFxlhfTA/enMuATfLdA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGpUbWM2eFNGeE1oaG5xYVFXUkVFSHBqQVIxSTczMU43ZEtqcXp5S285ZUwr?=
 =?utf-8?B?S0JMV2RLZWZRdnZUVzJhdG92V0pnOEZIT0NWWG5TTnZoVDRlckgzL3pCVU1Y?=
 =?utf-8?B?L2hsZU04L1d3M2ZuZFhWRWx6dW9xbGVqVHlSaDFIWXp1MzVxTlhrVnNWQzd5?=
 =?utf-8?B?L3N0L24wQnhGV2ZBS0haSlQvODdpY0NTdWl0T2lheW9qZ2hTaVdCZ0hnQjBu?=
 =?utf-8?B?OHBPcS96WEtVQnp1c29BUmNLSmdCL1Q5d0lRQkkyRmZqUHR6b0JOaHdzalN6?=
 =?utf-8?B?bDV1clpwaGQ1QzNYWUhySHJGaHBmQzdyRDBDRHJoN09rMHdFYzZRWXRHUk9n?=
 =?utf-8?B?cThWQ2VESDZKV21WazJ6NWM0M0FVTnZsNlhIUm5teEppRkt6c0VqOElxMk4z?=
 =?utf-8?B?SlNtWEIwb1lCTVNuMWw3eVlBeW1vNndsWFp2K29HK3ltMkNhd1BIaTNpRThH?=
 =?utf-8?B?eCtrZHExaUJPWHhwSmlXWE1IbUpqVUcreVpkQ0VKVzJJS3JsRitTYUlHS01w?=
 =?utf-8?B?a3ZpWWtFWlBYYjlTRUlxdG1rWlBNU0o5NE9EWmtndUxYU0ZNbi9uMmJwd3U3?=
 =?utf-8?B?eklJZXoyc3hBRlY2cUVCSnc3c2ljTTJNYnpFM1JOYmlPemxKbkpXRGlBNDU2?=
 =?utf-8?B?czh0SWtWZy9rNklrd3ZsZkZDWlJnK3gwOE1pQzlKS3g5Kzh2ZzNFODBiSDE3?=
 =?utf-8?B?SmliNmN1ZUZTNFR4MXNGT0xYa1NtbFhVV05veFpjcGw0V29YSW1LNUppQVBk?=
 =?utf-8?B?RGpNRnYzRUpBK2NQdE1FNHY2KzFmMjFiRW16eDR0bXp1WXZqRThLKzBHOTRp?=
 =?utf-8?B?NXFXRHRTWTJnckRZS2Z3dk4vN2Y0WEdIK0NMVTIwc2lyMC80S1MvQndEdVNS?=
 =?utf-8?B?enZnbnhzR1RneTBWMWR0VlBXZi9acHVPdlFlMHJUYjJna203eHRNa0Q5alhF?=
 =?utf-8?B?YTZBbGcwN0c0bDVsaVhmVDE4RFdqWGwxcEs1Y1BOdmNqVVp5Q1Y3UFZyQmNr?=
 =?utf-8?B?OGcyQjhvOVFDTktFbGpkK0JWd0VmcDE0anRYMnoyc0x0bjZLb245VDV3VnhG?=
 =?utf-8?B?L3N4S2xnTDlYNTJiNDFsQVh3L1haVno5Rm4rMHlSc1NOMTZYdWJmdmVSWG9m?=
 =?utf-8?B?b0cxQ2pnL29HUzMxTlR2QXpBL0RHQ0NzVGE0Z3RHMU9XcnNDbzU2MHhENlpm?=
 =?utf-8?B?TWUrVlorQm5SYUExak9XaUhpS3NqeTFRcUd0OXBSWTErTXRSeXRDUjVSN1lv?=
 =?utf-8?B?Y0gyNmIrYytnQlhEQnBmNjRBUzB2Mk9VQVRudi9uY04rVnJBckVvM3llTkVt?=
 =?utf-8?B?bHBYbUFvZnl1R004Z1kvTVhyRjBLRE9Ta0lQTkh4RlhRd2pvTThuUS8zb1c2?=
 =?utf-8?B?THpMclIrdmJxQXZ4eGczV1RYZTJVMTc4bjBXWFBCUzNBL0NSRTRCaEwyVGFx?=
 =?utf-8?B?SGVrOGdJcmlPWDdsaHpEeHNGOUhNUVhWN2VqM3NIVFJ5ZWJVWDkwSG5VNmxH?=
 =?utf-8?B?UnAwd3o3aVd1YkZvRU1KMWhHZ2d5WVhiRC9XWWx1Z0VoaFpTYnYwVUFLM3VU?=
 =?utf-8?B?MUhoQjg1SHVsTWl0WXU1TVZOSFovV1U4Y1YwbUtPL3UvZkN3RkxPbG1SQ2pm?=
 =?utf-8?B?M3JvRHRxWHM4cCtNV2RCZGJXNU52RDBSYXpZZytYci9XWnY5eGhqQWU1YTBp?=
 =?utf-8?B?OWN4Ym9RcHV4SEE5VGtMb3d6cTFiRlBpcG15dEhtTVp3SFN2Ujh0dm53bytn?=
 =?utf-8?B?a2JRRGN0QTIrdkUzWGRGOFdXbVpVMGozN0VIUGQrQW15YU1qMVZ1OElNWWRQ?=
 =?utf-8?B?cUNlMXRoNmkyeGdiaGE2RjBPOEg1b25aMUUzZS9pVDhoMFMzb0ZWSVdnQ0pp?=
 =?utf-8?B?aU5qa0s4Uk1tWE9XNjdtQVNFRzRjKzdBZHFBeFlRUjQ4TFRWZVhoZERIMjZi?=
 =?utf-8?B?eWFxQVBoNEV2SklUYWJyL1l4Mlg4dEY4S2FIWEoyaWRmYkh5aDAyU1JIblp1?=
 =?utf-8?B?eGRRb0p4R09YeldyTkV4SWZrM3dzSWU3T3ZpZGNpdHZSMVpyeE9YditPQWlQ?=
 =?utf-8?B?ZG5DTlFzdlBscEZ6Ull2OXBZeTFFaEFXU0NBbHppb1pQU1U1Q1V3RUhJeDBX?=
 =?utf-8?Q?a8lXT9QcQTD51/vs3BsERqIHO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d68abf-1db5-48ea-3d7a-08de0759033a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 17:26:42.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RuOTjhs03WG/NZck0+YDl/eUkM3RakpbckGsGIVhJo9wLpM7v5369BiHZsC0nCPI6/8vMUM5S2IbYLhXuMTJSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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



On 2025-10-08 17:11, Harry Wentland wrote:
> On 2025-09-26 14:01, Timur Kristóf wrote:
>> This series adds support for analog connectors to DC for DCE6-10.
>> There are two reasons to add this support:
>>
>> 1. GPUs that already use DC by default and have analog connectors.
>> Some Tonga and Hawaii graphics cards in fact have DVI-I connectors,
>> and their analog part doesn't work with DC. This functionality
>> regressed when switching from the amdgpu legacy display code to DC.
>>
>> 2. GPUs that don't use amdgpu by default yet.
>> Currently, SI (GFX6) and CIK (GFX7) don't use amdgpu by default
>> yet, and missing analog connector support in DC is cited as one
>> of the main reasons why not.
>>
>> Before starting this work, I asked Harry and Alex about how best
>> to do it and we agreed that we'd like to use the VBIOS to set up
>> the DAC. So I used the amdgpu legacy display code as a reference.
>> The first few commits add some minor changes to DC to prepare for
>> supporting analog stream and link encoders, then analog link
>> detection is added along with polling, and finally DAC load
>> detection support, which is useful for old displays and adapters.
>>
>> With this analog support added to DC, we could already fully switch
>> CIK discrete GPUs to use DC and switch them to the amdgpu driver
>> by default. This series switches Bonaire to DC by default, we
>> can do the switch to amdgpu in a later series.
>>
>> For SI dGPUs, there are other pending patches to make DC work
>> well, afterwards we could switch to DC by default, but missing
>> VCE1 support is the blocker from using amdgpu by default.
>>
>> For GFX7 APUs, further work is needed before enabling DC by
>> default, specifically with regards to the TRAVIS and NUTMEG
>> external encoders which are not supported by DC at all.
>>
>> Changes in v2 of the series:
>> Fixed regression on RDNA2 and newer APUs.
>> Fixed flickering caused by polling analog connectors.
>> Fixed crash on Kaveri.
>> Fixed bug when HPD was high without a connected display.
>> Reduced code churn by reusing same link encoder.
>> Addressed other feedback from the review of v1.
> 
> Thanks for the series.
> 
> Patches 1-13 are
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> 
> I'll hope to find time for the rest tomorrow or Friday.
> 

The rest looks good to me as well.

The whole series is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Dan, can we give this a spin in our weekly promotion tests
before I merge it?

Harry

> Harry
> 
>>
>> Timur Kristóf (23):
>>   drm/amd/display: Determine DVI-I connector type (v2)
>>   drm/amd/display: Add analog bit to edid_caps (v2)
>>   drm/amd/display: Introduce MAX_LINK_ENCODERS (v2)
>>   drm/amd/display: Hook up DAC to bios_parser_encoder_control
>>   drm/amd/display: Add SelectCRTC_Source to BIOS parser
>>   drm/amd/display: Get maximum pixel clock from VBIOS
>>   drm/amd/display: Don't use stereo sync and audio on RGB signals (v2)
>>   drm/amd/display: Don't try to enable/disable HPD when unavailable
>>   drm/amd/display: Determine early if a link has supported encoders (v2)
>>   drm/amd/display: Add concept of analog encoders (v2)
>>   drm/amd/display: Implement DCE analog stream encoders
>>   drm/amd/display: Implement DCE analog link encoders (v2)
>>   drm/amd/display: Support DAC in dce110_hwseq
>>   drm/amd/display: Add analog link detection (v2)
>>   drm/amd/display: Refactor amdgpu_dm_connector_detect (v2)
>>   drm/amd/display: Poll analog connectors (v2)
>>   drm/amd/display: Add DCE BIOS_SCRATCH_0 register
>>   drm/amd/display: Make get_support_mask_for_device_id reusable
>>   drm/amd/display: Add DAC_LoadDetection to BIOS parser (v2)
>>   drm/amd/display: Use DAC load detection on analog connectors (v2)
>>   drm/amd/display: Add common modes to analog displays without EDID
>>   drm/amd/display: Don't add freesync modes to analog displays (v2)
>>   drm/amdgpu: Use DC by default for Bonaire
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   1 -
>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 173 ++++++++---
>>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   5 +-
>>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
>>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  20 ++
>>  .../gpu/drm/amd/display/dc/bios/bios_parser.c |  95 +++++-
>>  .../drm/amd/display/dc/bios/command_table.c   | 286 ++++++++++++++++++
>>  .../drm/amd/display/dc/bios/command_table.h   |   6 +
>>  .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   4 +-
>>  .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
>>  .../gpu/drm/amd/display/dc/dc_bios_types.h    |   9 +
>>  drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
>>  .../drm/amd/display/dc/dce/dce_link_encoder.c |  85 ++++++
>>  .../drm/amd/display/dc/dce/dce_link_encoder.h |  16 +-
>>  .../amd/display/dc/dce/dce_stream_encoder.c   |  14 +
>>  .../amd/display/dc/dce/dce_stream_encoder.h   |   5 +
>>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  75 ++++-
>>  .../gpu/drm/amd/display/dc/inc/core_types.h   |   8 +-
>>  .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  24 ++
>>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |   2 +
>>  drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 +
>>  .../amd/display/dc/link/hwss/link_hwss_dio.c  |  19 +-
>>  .../drm/amd/display/dc/link/link_detection.c  | 147 ++++++++-
>>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |   9 +-
>>  .../drm/amd/display/dc/link/link_factory.c    |  60 +++-
>>  .../dc/resource/dce100/dce100_resource.c      |  31 +-
>>  .../dc/resource/dce110/dce110_resource.c      |   2 +
>>  .../dc/resource/dce112/dce112_resource.c      |   2 +
>>  .../dc/resource/dce120/dce120_resource.c      |   1 +
>>  .../dc/resource/dce60/dce60_resource.c        |  29 +-
>>  .../dc/resource/dce80/dce80_resource.c        |  26 +-
>>  .../amd/display/include/bios_parser_types.h   |  11 +-
>>  .../display/include/grph_object_ctrl_defs.h   |   1 +
>>  .../drm/amd/display/include/grph_object_id.h  |   7 +
>>  .../drm/amd/display/include/signal_types.h    |  12 +
>>  35 files changed, 1117 insertions(+), 86 deletions(-)
>>
> 

