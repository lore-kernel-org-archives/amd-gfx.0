Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DF5D3ABEF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 09:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D575610E094;
	Mon,  8 Dec 2025 09:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQKmnuyP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE9510E094
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 09:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VU4sOfOTNUd4RBpucMTIUqVZmvFuAn9u8+/C958w/fLKV0KvbeM62WdKA3cOLNuEtCxqdsDl2XUDhylz+YZ5vsf1xp/u59p4cRhJzgeqqJUO8YbX1/gAoSLmifdi9JZWwxfs7MGHCF7W10A8a/5TGNcvfL1RSVyKzbbk9AIzy867Jy8LLCR2jVQXGS/bx2WS4LA0Zq9KTgw+9z1aozbgaeddjUu8f4Y6rivz65fMuZjG730czm0trfblo9om11kdBftt5AQDX4xnW+Rs7gJmsOAvgIVoUlxVGzACof2dyfqYjerfOjsL3ZZCGCYTZc8QIy9XUU9K5ySlRwBdov6stA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PdXdYHMYJ8A/WU0mRwMAdV2wUzoYmas5osdoK96dNA=;
 b=qVUFhrf1mbG5FQ4pXW/o04ETPwRfRcxapGBFvc9plz+ECob+re3S1BMYRbJGZkY9RXE/mDWNrRE6NM5TnC++NU/AMtNqod2lGxFOuQ8zZcjodXGOAnQiVYptio0Jid9feCjLpjRtOtCriGF4RkAeFkFe4xsCn0rtvHsV9b5iaYujBBZYq5Fjw/lYyi9ZQfRxHYPdRtC72a5ix+dOGMlOqlHivGEtGRuzyWz/jVZEwzerUJ7WPLN27puBVdJTsC7VulBmejtWgbMGmsT+MESmxfMgrMhbXg4qnukJ4ZqkuicBg90D2/376YIcJG1RimjrqZHxrgIeOVwosasGJ+xTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PdXdYHMYJ8A/WU0mRwMAdV2wUzoYmas5osdoK96dNA=;
 b=rQKmnuyPjc82smkUyvdpBGglmXzEz++wY/kQwLRiYYsxMmwuNazSPpcWPQmjK5jz03gTdbrDqfNNf6rpK+4CnZRx9ULQediZxo1FxWCF1cJzTJZnkqY1gCGbspTHik9ud3ZYrdekXN7reGvRxnUvZLozSuyutdXgouYCvTlNvTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 09:23:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 09:23:10 +0000
Message-ID: <69005ab2-8eee-472a-a58d-45280954c095@amd.com>
Date: Mon, 8 Dec 2025 14:53:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20251205083521.1337481-1-chongli2@amd.com>
 <8f562315-824e-43eb-a4d5-614f077e39ba@amd.com>
 <LV2SPRMB0010696B4E2D4E772CD683A09BA7A@LV2SPRMB0010.namprd12.prod.outlook.com>
 <be0f0bef-a54f-4606-80d9-09b8c0a961bf@amd.com>
 <DS7PR12MB5768B2DEB3B4B6CCBC817BB99BA2A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DS7PR12MB5768B2DEB3B4B6CCBC817BB99BA2A@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0f4511-1875-460d-b4ab-08de363b678e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGcwNm5pSGt4SDJFQ3E0UmFhcTQxbjZ2UU96MXlybzJiUmdYUUdtM091Rk1h?=
 =?utf-8?B?TmRBaUVUcE5Xd3VIUDNhVGQyTjNHVjE5cUNScEptelh1bVpqdjJ1RVJ4bWIz?=
 =?utf-8?B?SjFISHdzb0YxR1hjWWxsZDlXK0YvakhYOGNTSGRDb3l3Qlp6VWxhTUcvdGxp?=
 =?utf-8?B?ZFluNVp5ajJyMmdvNjg2Rk0vTUVCUnUxQTlhaTdQcXU4ZnN0RE9sOHdwTXl5?=
 =?utf-8?B?azkxM0J1STdERk50UFNyK3B0UWNiTnl4ZGp3dXJRblBlajRoRWVwM0drYmNF?=
 =?utf-8?B?N2V4WGh3ZTQxTnp0aVdmajlZdytENEtncW83c1ZSNXRsRnNRNHQ0TFdSRWlx?=
 =?utf-8?B?K1o3T1p1NWNVbWZna2ZzemQzOXIrVFJSRXNRcndPNTNUZzh2OW8wdnZjVis1?=
 =?utf-8?B?MjQ3SzdWWnl1Tm5XM3Vya0l1VmdObjJDaVlhanFXRkRiTnVLNFJlUklPU1Vx?=
 =?utf-8?B?alhJaFY4RGhibEJZOERJZHBDWSszQkJUOVlibVptWFlRbjRLc3VhcTQrTGsr?=
 =?utf-8?B?b1g4c3MyT2c3WFBqRkZyQ2VaNmdVc3ErWDlqN05LdnFPMkkrT0FjRHVGaHlJ?=
 =?utf-8?B?cTI4a0laaDJwSWJkbkVqekJwQzhvb25tckZoUjNzaks4N1dlVXY2Qy91RGo4?=
 =?utf-8?B?RVo4T29NTmlmODQyRlpmYWRnUzBzTHQyTVZyOHJ6M09GeUpDWmZaTHFYdktr?=
 =?utf-8?B?SGZFeXUvNkY1Kzd6dDQxR2tSakU3RlpjbG01VlF1eVRXKy8rVnlsVVJONlhB?=
 =?utf-8?B?SHhudUwvUTF3dDdhelJlaXdNOStvemx5NU5MVHAwSXBnRkNpNXhReXRHeTF0?=
 =?utf-8?B?UEF1Vm9tNzIvYmY1S1VxSXFoOVJvZ3BvSFJIRDRFbmlEZnMzekh0eVAyeVNh?=
 =?utf-8?B?R2xyV1JIVkJPVS9JN0p0RnZHa0FSRFUxbHVIOXNGVnNxb2ZOc290U296NERr?=
 =?utf-8?B?MmZQbWdxeC9yazVXYkU1U3JHWWNKODdOa2JBdUFoWVpXU0ZYMDc3ZE1KTU5r?=
 =?utf-8?B?TXl1UDU5QkJDZzQ1MTBKdnNIY3RFT1BVLzB1YStkUVB0OU9ReGRHWm9XZS9T?=
 =?utf-8?B?ajdwSXdzUUdseGJUckRnMHRzU1pHTURuOHM0UTc4Wnp6VUo1alBSZzRwaTdO?=
 =?utf-8?B?dnprYitYWGlLR3RKb0NrcFdhaGI2OHFqRnpMVnZSVkNWenF2L0tLcXk2VVNS?=
 =?utf-8?B?N2tvUUx5bVVnQUt6UU9mRElJcE1sUXB2UFU2OGRLaG4zZVZ3L1U3RlJCUDZP?=
 =?utf-8?B?a2hBdHplTHI4ZFFWdTRXZWV5RzRzUFpQTGFKSEovY1d3eTBEaCthOVhYMnBj?=
 =?utf-8?B?cGV3V0dFRkRwdVJSSFVPUFNOT3d3M2VCSEE3dnJtNDlSSktzKzdGaVc3TVBE?=
 =?utf-8?B?MVB0REh6d1hWdDl6VERPMXBIZ0w2WXVsNDczRnZ2Rzg2U3lqZmhZczVXU0Zo?=
 =?utf-8?B?MC9hOXlSbXdBRGt4Q3RNblJzMzJxT2ZoZTRvT2RybEdQbmhOMmttQ254L2JV?=
 =?utf-8?B?RnZVaGlCOW1RWDlEOFA0bnJOdGFqenpGQ1BsemprbmNCNXhjZUtEYU5CZ2ox?=
 =?utf-8?B?alM0UExNTW9MbHp2V2xLenZ6VzdVbFpUTjVkUnROa29aMzdMemZyTERqTUpZ?=
 =?utf-8?B?TzhtM0x2RS9pekhSZEdaR2sxR05qQ3NQbkVLcWNjME5Iblg2SlNxTDB3alJB?=
 =?utf-8?B?QUdWcGk5SkxqNjlzbms0TjFsUmxhOWdwOVhVS1hKQnJEMUtUL012bFBKeGlp?=
 =?utf-8?B?MkNKdUUxaHF4R29VOHNCTkE1WkpKUy9jcEpmaUJma1dlaHdOTG1TN05xMFlw?=
 =?utf-8?B?dHY1cmswZUxqd2tGMUk4NWZPMnZWaDVrN1E5cWxMSkd0eG9WY0ZVRU5HQ1BR?=
 =?utf-8?B?eVR0WG96OWtOU2dpaytHdWFkdDIvUFFEZVU0c0pOT0lKZ2JZdTJVaDY3Y29L?=
 =?utf-8?Q?D/hnYWcKzboIUyNvH/c5jjyv98PsjJY1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9mNWt2blZmRnFTTTVSSitQTFp4SzFMbWg5ZFVib0YwUW5NUzg3RUhZYlh5?=
 =?utf-8?B?dVFralF6SzA3MHRid3V3Y1czOWRkMWoxUXNEb3RoQW43anUxTmh3S2tEeUhG?=
 =?utf-8?B?YWE0RlFTSDNaUHdiRFpRK0M5UUcxSlV4ekZsY05Nb0lvSUV0KzBMN0ZHTXJm?=
 =?utf-8?B?RHdiVG55QldocGw4emViVTVkQXk5SndZWXl4SEZsdEd6SGw4U3JZNENac0RU?=
 =?utf-8?B?Q1RNY1BQOHZ3ZnVxZ1RmU1lKYkNmRE5RQmdJajRhNWp1N241aExRYlpZdGFP?=
 =?utf-8?B?N3lIWmU4UEFOQUE3Z0JNbyttRVJGR0JFQ1UyK0ZsVGJuRkZHcmpNVnBYWERL?=
 =?utf-8?B?eE5aUXZjY2NQZVNuMHZOT3RvNlk5TjZ6WkwxTkxwSG5NVWJnamJGMVJLeUNP?=
 =?utf-8?B?RURPUGtDa1FUdWFFSkNXQzYwRSt5dTF1enJaMUVXVmNRbHZPd0paNjgxdTlF?=
 =?utf-8?B?NXVoQ1JWWlVtUFZJRlhZaDBJT3JqeWZITzVScmVSV0drTkRzMFFLMUVyTHM5?=
 =?utf-8?B?bTU2dGRpOHZxWDRZOHF2OXlGSkxmL1oyRndoK0VwVWJ3ZzRwc05iNXRNd2dw?=
 =?utf-8?B?SnA3WnM2MCtYR3VOS002RDhqdzRqVzlhenp2bkV0M25XYXZqR29JbDR1ZEQr?=
 =?utf-8?B?Vmg5d2doZFM2dC85N0x3ek9ueUVWUnhMcmpKdU1zNDFOdGNoTDFkVzdUeEl4?=
 =?utf-8?B?UUFmTTBxaDZpSW5Nd3lLVWl4MDBBSVpCREFqNDE1SFMwakZyRFpQRndxRW5m?=
 =?utf-8?B?K0o3U2RQbm1peUhYZE0xbU9PTWk2VHJMTWRYNVdEQ3BvdjVSdmRMTzhRVWh2?=
 =?utf-8?B?S1Q4dTBsT1hpMW9PMHpwZGRQLzRuRDR6OWNMWmQ5VlJ4Y2xNNDFneTlSWE9O?=
 =?utf-8?B?SUFXSEphT3IrVEVkWVZ6Q0JkT3lsVTlJdWtEazQ1c0M2MS8zSHRSTXlFOEoy?=
 =?utf-8?B?dmVIZFlhdDZiREhJbWlhMkhvWGh0RzNVV0hkWnJ1QlZ2bmtTY0N0N0J6TEdh?=
 =?utf-8?B?cmkwREZ2aFZVZ0RIOVd1ZFhyS0IrZmZWdWFka0JSanZ4S095VjY4bjlORUpn?=
 =?utf-8?B?cTF5U29nVTBvUW5KSWFkU0x5TUZCMEg5V3cwUU02Q2JDRkdMYldXQng1TFZW?=
 =?utf-8?B?ZE85Y2tUbm9IVVdZeWlzUUp1ZGk3VzBOYm5kN1AxQm5BbkVCajI4Z2pPY1RO?=
 =?utf-8?B?N3VrSml0c1ZCb0V4NzNCK2JLd0hxZnRoTkxPb3hRbmU2QVd2NGxHUDl5Vks5?=
 =?utf-8?B?LzJIZENOTnhKbS96Sm5mMVJPbFQ1alRzRkJxQk5SWk5NSEVwNUtnSHFRMUlm?=
 =?utf-8?B?aW9MUGkrNml5S2oyZCtXL3JWbTZHQ3BINUFzVUZLckdzVDJNOVRLaTdTeHZ4?=
 =?utf-8?B?UGtjWGRVemthSlJrcE0xYzZ2aEJMVjlEN2RwSXZWN3FoQzlLMnlldlJQZnE5?=
 =?utf-8?B?S3ZKTHJVN1F5N0hYcUZ4Q0dQeFl2bHJIbFBuc1dNQVh4L2p0a3JkRi96K2o4?=
 =?utf-8?B?eUczNmNQSGc1RENod2c3dWFhRTJBcElYYmpNbCtvVmxOeVhHb012RVU2NGVD?=
 =?utf-8?B?TTllUEN3THA0eU1UUC9MZFlLRi8rbmtWd3U2YjJWS2l4NVNMTkJjTVNqWHJw?=
 =?utf-8?B?bHE1MWttajlzSmMrek9aK2lYOVZDOFdXdlo5ZXBBekhmSm4yTmV2VFBHNkt3?=
 =?utf-8?B?VklhZ3krUXR6cDl0MzRUKzUrY0JXUndvckFZcFdDK2wxY2xkRmExNVFpdVZM?=
 =?utf-8?B?TFVTdXJtY0ZybU9Oc3VQQnpsWkFOaVhIV2FmUFNialJTcmE2YjBIM1lLaDBs?=
 =?utf-8?B?cVNVQjd6SDQ1RVV4UU9YSW5HOEdTK3E0VDBCQWFxQVd6YlZXVE5tbXRDNXBi?=
 =?utf-8?B?aW5EbjdnVmpBT0IvUCtSRytzdWlvU1hnTUdyRGNhQzFaNktHUWJZYTZwbkM4?=
 =?utf-8?B?TUNmRVJTZzlLcUpsTkhpZDZYQmFhYmZuVnhjbENxbm9lRzFYRklmVDFsaWds?=
 =?utf-8?B?c0lHd2tRa2FHT3Zsbnp2bS9yMXkrOXpOcUVBeHlvcEpiaE5DdGlKdGh3THlj?=
 =?utf-8?B?OFltb2t1d3BLYzN6MUFMWUxRZkQwcUN5anNjMU9yWm5QbDJjNzNNd2pldDVL?=
 =?utf-8?Q?iRN2aLCqen+mgUQ/LQBpii3gR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0f4511-1875-460d-b4ab-08de363b678e
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 09:23:10.3052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wz8GEkGIoX2SeCVQUjKSjpRvhFBQ9SjsU/8HHty1C1Mo+vILwHtfqnqWrawGzZqB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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



On 12/8/2025 2:42 PM, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Lijo.
> 
> The hdp flush entry contain cp entry and sdma entry.
> This patch aims to solve the cp entry conflict (the sdma entry not conflict).
> 
> The function " get_ref_and_mask" already contains the ring type of gfx, compute, mes, kiq.

If it's only centralized for gfx and not mask allocations for full the 
device, I think it shouldn't be a ring function, rather something in 
amdgpu_gfx_funcs.

Thanks,
Lijo

> Current only these rings (gfx, compute, mes) use hdp flush function via cp entry.
> So, I think it's no need to contain all rings. (maybe rename "get_ref_and_mask " to "get_ref_and_mask_cpx"?)
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, December 5, 2025 8:35 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
> 
> 
> 
> On 12/5/2025 5:06 PM, Li, Chong(Alan) wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> Does this really require a function? Why not keep hdp_flush_mask in amdgpu_mes struct and initialize within mes_v*_sw_init()?
>>
>>
>> Hi, Lijo.
>>
>> Thanks for your comment.
>>
>> The original code handled ref_and_mask assignment for GFX and Compute rings directly within emit_hdp_flush.
>> This patch implements a new helper function, get_ref_and_mask, and extends the scope to support MES and KIQ rings.
>>
>> Centralizing the management of CP entries in a single location
>> improves code readability and facilitate future maintenance,
>>
> 
> Here also, it is implemented as a ring function and the assignment is not getting centralized for all rings. Moreover, the ring function remains unimplemented for other types of rings.
> 
> Thanks,
> Lijo
> 
>> Thanks,
>> Chong.
>>
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, December 5, 2025 6:21 PM
>> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: fix mes packet params issue when flush hdp.
>>
>>
>>
>> On 12/5/2025 2:05 PM, chong li wrote:
>>> both gfx ring and mes use cp0 to flush hdp, cause conflict.
>>>
>>> use function get_ref_and_mask to assign the cp entry.
>>> reassign mes to use cp8 instead.
>>>
>>> Signed-off-by: chong li <chongli2@amd.com>
>>> ---
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  | 15 +++++++--
>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 ++
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  3 +-
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 40 +++++++++++++++++++-----
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 40 +++++++++++++++++++-----
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  3 +-
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  3 +-
>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  3 +-
>>>     8 files changed, 87 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> index 895b841b9626..73305f07ddd9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>>> @@ -556,11 +556,22 @@ int amdgpu_mes_reg_write_reg_wait(struct
>>> amdgpu_device *adev,
>>>
>>>     int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>>>     {
>>> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
>>> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
>>> +     struct amdgpu_ring *gfx_ring, *mes_ring;
>>> +     uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>>> +
>>> +     gfx_ring = &adev->gfx.gfx_ring[0];
>>> +     mes_ring = &adev->mes.ring[0];
>>> +
>>> +     if (!gfx_ring->funcs->get_ref_and_mask) {
>>> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support \n");
>>> +             return -EINVAL;
>>> +     }
>>>
>>
>> Does this really require a function? Why not keep hdp_flush_mask in amdgpu_mes struct and initialize within mes_v*_sw_init()?
>>
>> Thanks,
>> Lijo
>>
>>>         hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>>>         hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
>>> -     ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>>> +
>>> +     gfx_ring->funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
>>> +&reg_mem_engine);
>>>
>>>         return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>>>                                              ref_and_mask,
>>> ref_and_mask, 0); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index a1fb0fadb6ea..adca4396658e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -250,6 +250,8 @@ struct amdgpu_ring_funcs {
>>>         void (*emit_vm_flush)(struct amdgpu_ring *ring, unsigned vmid,
>>>                               uint64_t pd_addr);
>>>         void (*emit_hdp_flush)(struct amdgpu_ring *ring);
>>> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
>>> +                             uint32_t *ref_and_mask, uint32_t
>>> + *reg_mem_engine);
>>>         void (*emit_gds_switch)(struct amdgpu_ring *ring, uint32_t vmid,
>>>                                 uint32_t gds_base, uint32_t gds_size,
>>>                                 uint32_t gws_base, uint32_t gws_size,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> index aaed24f7e716..aafd34ddcfcc 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>>> @@ -8616,7 +8616,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>         u32 ref_and_mask, reg_mem_engine;
>>>         const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>>                         ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>> << ring->pipe; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index f4d4dd5dd07b..0ada69d0cc68 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -5829,29 +5829,50 @@ static void gfx_v11_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>         }
>>>     }
>>>
>>> -static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>> +/**
>>> + * gfx_v11_0_ring_get_ref_and_mask - get the reference and mask for
>>> +HDP flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>>> + */
>>> +static void gfx_v11_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask,
>>> +uint32_t *reg_mem_engine)
>>>     {
>>>         struct amdgpu_device *adev = ring->adev;
>>> -     u32 ref_and_mask, reg_mem_engine;
>>>         const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>> + << ring->pipe;
>>>                         break;
>>>                 case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>>> +                     break;
>>> +             case 3:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8
>>> + << ring->pipe;
>>>                         break;
>>>                 default:
>>>                         return;
>>>                 }
>>> -             reg_mem_engine = 0;
>>> +             *reg_mem_engine = 0;
>>>         } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>> -             reg_mem_engine = 1; /* pfp */
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>>> +             *reg_mem_engine = 1; /* pfp */
>>>         }
>>> +}
>>> +
>>> +static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     u32 ref_and_mask, reg_mem_engine;
>>>
>>> +     ring->funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> + &reg_mem_engine);
>>>         gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                                adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>>
>>> adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>>> @@ -7235,6 +7256,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
>>>         .emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>>>         .emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>>>         .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>>         .test_ring = gfx_v11_0_ring_test_ring,
>>>         .test_ib = gfx_v11_0_ring_test_ib,
>>>         .insert_nop = gfx_v11_ring_insert_nop, @@ -7281,6 +7303,7 @@
>>> static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_compute = {
>>>         .emit_vm_flush = gfx_v11_0_ring_emit_vm_flush,
>>>         .emit_gds_switch = gfx_v11_0_ring_emit_gds_switch,
>>>         .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>>         .test_ring = gfx_v11_0_ring_test_ring,
>>>         .test_ib = gfx_v11_0_ring_test_ib,
>>>         .insert_nop = gfx_v11_ring_insert_nop, @@ -7323,6 +7346,7 @@
>>> static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
>>>         .emit_reg_wait = gfx_v11_0_ring_emit_reg_wait,
>>>         .emit_reg_write_reg_wait = gfx_v11_0_ring_emit_reg_write_reg_wait,
>>>         .emit_hdp_flush = gfx_v11_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v11_0_ring_get_ref_and_mask,
>>>     };
>>>
>>>     static void gfx_v11_0_set_ring_funcs(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> index f9cae6666697..0bdb4f292dea 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>>> @@ -4385,29 +4385,50 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
>>>         }
>>>     }
>>>
>>> -static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>> +/**
>>> + * gfx_v12_0_ring_get_ref_and_mask - get the reference and mask for
>>> +HDP flush
>>> + *
>>> + * @ring: amdgpu_ring structure holding ring information
>>> + * @ref_and_mask: pointer to store the reference and mask
>>> + * @reg_mem_engine: pointer to store the register memory engine
>>> + *
>>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>>> + */
>>> +static void gfx_v12_0_ring_get_ref_and_mask(struct amdgpu_ring *ring,
>>> +                                     uint32_t *ref_and_mask,
>>> +uint32_t *reg_mem_engine)
>>>     {
>>>         struct amdgpu_device *adev = ring->adev;
>>> -     u32 ref_and_mask, reg_mem_engine;
>>>         const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>> + << ring->pipe;
>>>                         break;
>>>                 case 2:
>>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>>> +                     break;
>>> +             case 3:
>>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8
>>> + << ring->pipe;
>>>                         break;
>>>                 default:
>>>                         return;
>>>                 }
>>> -             reg_mem_engine = 0;
>>> +             *reg_mem_engine = 0;
>>>         } else {
>>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> -             reg_mem_engine = 1; /* pfp */
>>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>>> +             *reg_mem_engine = 1; /* pfp */
>>>         }
>>> +}
>>> +
>>> +static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring) {
>>> +     struct amdgpu_device *adev = ring->adev;
>>> +     u32 ref_and_mask, reg_mem_engine;
>>>
>>> +     ring->funcs->get_ref_and_mask(ring, &ref_and_mask,
>>> + &reg_mem_engine);
>>>         gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>>                                adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>>
>>> adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>>> @@ -5515,6 +5536,7 @@ static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_gfx = {
>>>         .emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>>>         .emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>>>         .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>>         .test_ring = gfx_v12_0_ring_test_ring,
>>>         .test_ib = gfx_v12_0_ring_test_ib,
>>>         .insert_nop = gfx_v12_ring_insert_nop, @@ -5557,6 +5579,7 @@
>>> static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_compute = {
>>>         .emit_pipeline_sync = gfx_v12_0_ring_emit_pipeline_sync,
>>>         .emit_vm_flush = gfx_v12_0_ring_emit_vm_flush,
>>>         .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>>         .test_ring = gfx_v12_0_ring_test_ring,
>>>         .test_ib = gfx_v12_0_ring_test_ib,
>>>         .insert_nop = gfx_v12_ring_insert_nop, @@ -5599,6 +5622,7 @@
>>> static const struct amdgpu_ring_funcs gfx_v12_0_ring_funcs_kiq = {
>>>         .emit_reg_wait = gfx_v12_0_ring_emit_reg_wait,
>>>         .emit_reg_write_reg_wait = gfx_v12_0_ring_emit_reg_write_reg_wait,
>>>         .emit_hdp_flush = gfx_v12_0_ring_emit_hdp_flush,
>>> +     .get_ref_and_mask = gfx_v12_0_ring_get_ref_and_mask,
>>>     };
>>>
>>>     static void gfx_v12_0_set_ring_funcs(struct amdgpu_device *adev)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> index 66a4e4998106..176658846b81 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>> @@ -2070,7 +2070,8 @@ static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>         u32 ref_and_mask;
>>>         int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0
>>> : 1;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>>                         ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK <<
>>> ring->pipe; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> index e6187be27385..bc1d0870cb2d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>> @@ -5382,7 +5382,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>         u32 ref_and_mask, reg_mem_engine;
>>>         const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>>                         ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>> << ring->pipe; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index 89253df5ffc8..418b8daa7097 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -2820,7 +2820,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>>         u32 ref_and_mask, reg_mem_engine;
>>>         const struct nbio_hdp_flush_reg *nbio_hf_reg =
>>> adev->nbio.hdp_flush_reg;
>>>
>>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>>>                 switch (ring->me) {
>>>                 case 1:
>>>                         ref_and_mask = nbio_hf_reg->ref_and_mask_cp2
>>> << ring->pipe;
>>
> 

