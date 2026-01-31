Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E65D79741
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Jan 2026 06:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAE510E142;
	Sat, 31 Jan 2026 06:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="in3/8EVL";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88A1D10E050
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Jan 2026 06:05:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8l1RcN6+97bMU3KoqoK57+4Fo+mZpbzYg1uC0LOTjABJiHTW1V+W38aD/pt5QkNQaVl83Wbn7goAM2iq0IyZxHJ0YtlMoFpsFo99vB2kmt0ypQ/L+XGR125hns243QiGaFrOImR/KI6FumcpjCvBGM0fcHxJMW+VSyPbBhWS89fEv7DDlV5sxbC/KBhsS9G2l3O7nJQW/0H+auLf4bW/Cozb6KJqmLNkT3SK6dS1bgqs9so0Bcb+VbUoHoOIrWXzVNxtekS5EV3pqqNvg/ZBl7zZbUg+0cNxyQ6H9d8bfEwHnCcHoekhedaY5lE4s7kG2XNa3kJZ/0eQyn75RmffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVvl4H0vrPGL2G8Hvco7vHdQGQQTVPOuLKrl1DFu508=;
 b=jW6JY/UULDg7iM7a6qK/ByLaa4SZOwCwpQMAwcEMXvjeOieKb5v5fxbvCwuroV48ojFBTLTfuNkKtC4BhQXzzpztvLJIIW6I/HCIbZ+Cf01grnPE6AT/ZzdIrxw1GqG9SjiB8P3Bdji9NMk/i6EIGFeLlPLzbyVgOAisuDb8eQkOR/ualyueJv0hI/IUY3DNvMiJx6ZLuWzgeWmSXTeNv+D/NlEoFUeIMtB6MxagXpkReki4KzakIUjeSSmv/aUsWsSMQwRTixsMvT/+QMw+H4002fkVSBALspUWIIz5+SvP2G0fOOPcqSz5ttWzTzJpu3s12bAJN5JkB2deR4F98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVvl4H0vrPGL2G8Hvco7vHdQGQQTVPOuLKrl1DFu508=;
 b=in3/8EVL6G4Gx7qlEg8xFJdSOQTAOJL2V3CPGlUp9yhoU8qMY0josbYAZYrzj8ffaJRko2+hS5+7fAcTkxuL/FBChTSW1zAvHm89yWasqoGJBDl0IAXV14fpcLBkGvRD7ijp0NS7p/ti+fnIlSm6tGlrthVobdpZjXHSKsOTG24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA5PPFE91247D15.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Sat, 31 Jan
 2026 06:05:01 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Sat, 31 Jan 2026
 06:05:01 +0000
Message-ID: <cc77cc03-b9b8-46a7-bdf1-237a9c239ba8@amd.com>
Date: Sat, 31 Jan 2026 11:34:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu/gfx9: handle gfxoff in interrupt set
 functions
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Yifan Zhang <yifan1.zhang@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
 <b977ab80-748b-4eb7-b05c-5856db02acb0@amd.com>
 <CADnq5_NU4Swq_n12A6HXD+YRRcXahFMYxa4pLHT2-WX33tfgzg@mail.gmail.com>
 <42191bbf-6f92-4883-8aa9-9e808fae3e8d@amd.com>
 <CADnq5_M-CoUDrWs9nOUSUF5yM+Jq2+RY1WS6mYGbWVYmtxgA8w@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_M-CoUDrWs9nOUSUF5yM+Jq2+RY1WS6mYGbWVYmtxgA8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:278::10) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbbf663-cfa6-419e-883f-08de608eab74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjNhNUo5V0RMdWNqeVhQZmMvcndVcG56UzVXa1JYWVMrRVBqVHpzdlVhTGox?=
 =?utf-8?B?VDI1UnZUNzJhYWthM0hOc0tZdXg3ZmNlSlpHTElHOWJqV24xTHBmYm94Tm90?=
 =?utf-8?B?SHpSS1c5b3pBM0hGVk9YeWlWQU5FcFFMTUFnenRYd2NjZGI3eFBNbGpNMXBD?=
 =?utf-8?B?TFFXR2hUUm5VR3NmN2ZRRDN0cHFHRHJnYUF3cXJobmJtbElVb01Xc2M0V3k3?=
 =?utf-8?B?bDMwUHBwUEJHWi9WbjBmYU83dmFYSjhDQVVDL3hjckVRKytXSmZFQ3owQ0JL?=
 =?utf-8?B?Ri9MbG53WmRuNXNZa1JYVittc2tCKzkxVy82OVZNV2ZLcElKZDlHUWl4cElP?=
 =?utf-8?B?OEw5WnVIaFFGb29ZNlM1cjhSLzE1VkxXMjhwNDRnNjFHcEQ0OHlJay9RL1o3?=
 =?utf-8?B?dEFhaGRrdURaYWlzQjdvNVl1OTRFMFV2cVRJSG9KK0drWk42STJ4ZWlYQTBK?=
 =?utf-8?B?WUx0bUZUQkE1SEFMVUh1SStld1A5U1VBSjZvS2xISmMvZ2g3THRoWGU1d2RZ?=
 =?utf-8?B?TXpCT3BVYTZTb1NzTnkxR0NIaU55MTlTV2dpU2JKM1JrZTRORmg3eUQwQjJR?=
 =?utf-8?B?UE9reVA5VHdNdWZscVB3SThiYVNrNThtcS9DY203SWlBN3ZGL2VHMFluNjJw?=
 =?utf-8?B?ME00V29wMDRNdlFqMytZSzhnZmRnZlU2ejJaejVFY1IxWG9qNE40Ym5yYTh5?=
 =?utf-8?B?clRpdUtIQVVnK2lYeXpPSEpRa2FPUG8wK1QxWGM4SVdocnVQZXA2cml3ZnRO?=
 =?utf-8?B?Ris0bVhQeVh6Mko0WVNwcnBsNjFFb0VnRHJFYkdhYytMcnpxSm1MWWhDTkRR?=
 =?utf-8?B?cktGQk9ENkNRVStTMlpmRmRzS0wyNVRxNXJraEhFN3M0eVBGaUFMcFJLU0NV?=
 =?utf-8?B?OGpoZ1NSSnVKNHlYQkdIQ3VZV3MyVHc0VkI5dVpMbXJCTy9hVGc2RTNpMU93?=
 =?utf-8?B?Y0gwNUlMWDlDTElrc2dqWVIyN3ZZa0w5SWdpY01DdTF0aFVxdm1LNlRyL3Mr?=
 =?utf-8?B?YUxLaDlTZjFkOGNyU05mSVlLbHpJTTIybklCWEZsWFpCNEsvaHRwYlJvVjFo?=
 =?utf-8?B?d0NTYmxrUEVXTUZrMTMwb0MrSFpvUlZwWWY5NGJHWkpMcFFYTHBMYitTUVI0?=
 =?utf-8?B?Rmp2Qjd4dkUrTVk0SG0wTFpYclZ2MkdVYS9yS29qeG5OZGREQkQzQ2NPRDVF?=
 =?utf-8?B?LzhzZmlZdlladEtyQURBSGNLNW8xK0pieXJsT0U3L3FsMXZtQk43Mk1Xc1k2?=
 =?utf-8?B?djBnOVdQWTdwWnpBZHJJSHhLc291aDB3RmNhQWVKbmlSQ2hGaXlaeFNISWdD?=
 =?utf-8?B?aUNleVVBNHVXOFNpQjhIL1R6MXd5djhLcWgwcC82U3Z5MlZIRWRBSWdpZFpR?=
 =?utf-8?B?dW9ZbCtnQnZqS0IvNElFR0U3MVBCekw3bkJaMlBtMTI4RXZJK2owNUZVMm1W?=
 =?utf-8?B?aW5OUWNqSW9MSlpzY3dVOGdNSnJYTWRNaGZ0M0ljT1JIbHkvZE1rdElNVVJB?=
 =?utf-8?B?NzJrYUV5VWI5d295d29JSm1obnZpK3hMSy9CMWpLSlRHTUMxY3ZtWkwvcHFu?=
 =?utf-8?B?OFVxV2R4VCtqWE9LcVFrV1pZQUJnbTRwREszUmtvQ04zakNrUEkzV2RsTTcw?=
 =?utf-8?B?ek9QbDczYjd4b0ZqNjUvOFJEeEhrVFc4blZrQ3VUK0xTdXBaczlyUUcwN21l?=
 =?utf-8?B?QXNVUll2blZBZWh1ZTJLcHI3RklIMUk2ekM3SjhVTUhsVjhtazRIWHVYTjJE?=
 =?utf-8?B?SFZaVFMzeDI4b0dicXRibnVrQVNKUkVlVkl1eWNQbm1lTWNpNGg5dmIvY3dp?=
 =?utf-8?B?Y2xkRjY1NVV1ODBjcDh4K0Flc1dZR29qK0pLUVNGTzBBQXpNOVVKbW1vN1ZY?=
 =?utf-8?B?dWZPa2RqRTlFVy9OeE82SGlrbkpMMDJidldxYUs2L3RZdWkvb1BmczZ2UnVp?=
 =?utf-8?B?dVF4N0htclN1bjI1YU90Sm9taDVuUzVZOXNkdUtXWEdwaHN3WG5yQ21WeERE?=
 =?utf-8?B?a2lVc29qNzZFMi9LMSs0T2RUeG94ZisyNHdyLyswb1BKMEI0L0JEMXVjZUU3?=
 =?utf-8?B?Tk9QOGNhYVIyR2Roai9yME13Ym5CYlh6M1ZDMm90SUNPRHZBdmo4SnR4OHhO?=
 =?utf-8?Q?2VHM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YW9xRVhDamJDcHFwUUt0Y05uYzdJaWFvZGhzRWliK3lydTcxdnJzL3hSY2FF?=
 =?utf-8?B?NDRCNG9IMC82cmVnc2NGbkNlT3RiYVU3N2wzUnozdm45OEFSa015cGNqNXF0?=
 =?utf-8?B?T2N1UGp4cmV1UmhUWG80b1ZsVWxNNFEvUVFOMzBvUmJqUUd6LzNEZTlQVmhZ?=
 =?utf-8?B?dUpvUnFHaURBQTZ6a0tnL01OSGJPTnBHQ1cwdWxoOXJ0dHU4MmZrMzlXV0hs?=
 =?utf-8?B?L0cyR1dMOXlUYzZjdFcyQlkzcGppQ3ZGdk5JdWNaSHo3RzJQV3FIdHVma3RW?=
 =?utf-8?B?aWNrRVJlaWR4K3NvNnBicE5sTE9VMlNXcmpLT2luUWQva3EzeU1PRzgwRTRu?=
 =?utf-8?B?Ukt1d2VqMlNaV2Y2SmExT3lJc1RBWDE2ZHlmbUh3MytvdUw4eG9WY3lEVXRr?=
 =?utf-8?B?a2ZPOGJ1SkQ2OGk1c2JFTmhablRsSXM4QkdTK0lqZzcvdnlJb1JoanJrVW50?=
 =?utf-8?B?ZzRaQmVZQnJ3ZzlHWWxHWE9JcnZmQWNMUTRVRDV1ZWxMekZWKzZ0QmhxUGhk?=
 =?utf-8?B?aEhpN3FQVEJhZFliRVNXWmxKekQ3SnVrVncrN1doZTVYOG1BZXBxdXFYMDd0?=
 =?utf-8?B?bWEwNkpQYkRXTlJZNWxLM3g4dXFwK0hHamhoRXVvSURRMXFKcVpTT0xNZEdK?=
 =?utf-8?B?MWlybFZReHZCOW9xRVRwVFhwZThhUzlZQXR5M1ZvR2ZoNTdlTUtFVjlXK01z?=
 =?utf-8?B?VHZGQ1ZHbklTZFdGZHV1YnN5SDk2emtmTzVPdHFTcXE4SVBKSm1pMG5VSjhP?=
 =?utf-8?B?em00Z1c4QWVnMjFyUnR6RUd2SDlMd2V3bDNza3BNSkhmUUZTLzFyTWJWMWhZ?=
 =?utf-8?B?akRCL216dGpOZlQ1VCsxUFJDUUVFejFkak1FUXdxWVY0VFVFZlhPVnA2c1lw?=
 =?utf-8?B?U3lpUmFFTzlzN0RXWEpuUWtpYmpIRzBXZTBvWHMxZDhuWE5XNTB3VHlkLzBC?=
 =?utf-8?B?SWk3TDRBSHU5ZVRrT2YrS213OXNVd1ZSelFDTmNvOG5DTDYxVXpibkMrNXND?=
 =?utf-8?B?dkc4cTFCSUtlTGxiOCtTenhvY3E1UWl3NEttSlhzblJ4RkRJZlR5ajlwUzNx?=
 =?utf-8?B?SDgxRWc4SjhJZU40MW5NVlA0M1h0TTJESFFFWDR0VFNwZG13Ky83cWtsWk9l?=
 =?utf-8?B?anM5cDVLbXJ4TkdFZ1lrcWwxeUZKaUlMcjU5TEdObU8xR08zRDRaN3A5K1lt?=
 =?utf-8?B?bXFwVHlIN29FM3hDNkt0L3BBVk9WSGh4Zyt2OU14S0lZR0tFdVRqaVUzVEVN?=
 =?utf-8?B?VDhSQmJNbkN5WVB3WWVTWnk1ZG9TT2ZKdXZjSEZSOFFiUGwyNG5mclBzMnlj?=
 =?utf-8?B?bDZycTRZa09TSWE2NzVxSmxNUEV3MmhBN0JNOU5mekJoZGRKbTdlaW01cU5w?=
 =?utf-8?B?eEgxRnZtYTlhdXBVTnRzT25ucDhMTFVwVHJSd2d0MDVGV2w0V3pPSjJiVkl6?=
 =?utf-8?B?aHFjdnNoOStGb0Rrd25FNGN5cDNpYzY1Q0hrdTlsMzR4bFlkejlGOFpTWGF5?=
 =?utf-8?B?NzhZK1Bpak9OR1FiNGQzMUFUemRWV2o2V3R1cnNOT2hrbERBQ2JNNU5BTmR6?=
 =?utf-8?B?Z3p0TEhPTFVpL05yZDBQSVdpNkl6aWlSeFg2THF3cUMvUy9HbjNBdUdIMDZ5?=
 =?utf-8?B?ck1xaUI1VTFsOXZTSGk1RXA0SDc3bVI3Z2lWNXRSc0swaGJNMldrc3BiM1Zm?=
 =?utf-8?B?S2FDeHVLbm0xNUx0aEdNcjh3YkROblJCTlg2Tkp0OWQ2ZmZlemJ2WFh4bFRu?=
 =?utf-8?B?OW9lUWhuZmNaOHluS211Z0hjYW1lZ05IeWNJT001NnJ6bXFNRnZKSkNXcTdr?=
 =?utf-8?B?b01MV1l4RXlJeU41L1hNcEJjdUZ6M0piaG1XV3U5L2lJZjluc3g0c002NTZR?=
 =?utf-8?B?a3psMVlwVGVyYmZvVXlCM0FTY003TjZXKzhQVkRFSXBnWkF3bG1VTUJjdFZJ?=
 =?utf-8?B?R1JZKzZ2UlczU1NuT09Xa3NraU9iNjRXckYrdm1HbFZqemhiS0doTHVqOXFz?=
 =?utf-8?B?VVc5dTNkT3cvQ29Vc3ZaN2pOTlFOcUhSYzNIUzdCRmJDbStoVVdFeVU1ZkQ0?=
 =?utf-8?B?dUxpVzJ4N3RLdTB3Ry9zT0JqbGxDaG15T3JDSTEyZGszREFsWVhuWlpOTGwx?=
 =?utf-8?B?REw3WWtubHhTQmdxbERBQTJ1K1ZZNWFCcy9KbFRKc1FVVE9GRWt0WXRsQkp1?=
 =?utf-8?B?R0NnbFdnWnNMRWtKbnNpT25hN2hoYUZxc1dJclh0aHBxYXlScWdsVFZSMEVa?=
 =?utf-8?B?eGNaVG9xdUZzbVhkQ3hpdUx5MkNEenNFTHlDQktIRHpKMDBOYit1anFpYnVL?=
 =?utf-8?B?eTdZWGtMZmFRaE1LU2VOZ0loRnBmLy9CUWpQR3A3UWlXUWcwVko5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbbf663-cfa6-419e-883f-08de608eab74
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 06:05:01.5622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f4+cYVtTMuhy5bkhkdcbHNNupsfdolPXUktljdK2PnK3Fc44n2fSgt8H6zu655Lr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15
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



On 30-Jan-26 9:19 PM, Alex Deucher wrote:
> On Fri, Jan 30, 2026 at 10:05 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 30-Jan-26 8:18 PM, Alex Deucher wrote:
>>> On Tue, Jan 27, 2026 at 12:02 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>>>
>>>>
>>>>
>>>> On 27-Jan-26 1:37 AM, Alex Deucher wrote:
>>>>> Need to make sure gfxoff is disallowed when we touch GC
>>>>> registers over MMIO.
>>>>>
>>>>
>>>> I think interrupt enable/disable sequence is only supposed to be done
>>>> under ip power/clock ungate sequence like in hw init/resume/suspend
>>>> sequences. The fix probably should be in the higher level sequence which
>>>> doesn't take care of that.
>>>
>>> In that case, Yifan's original patch is probably fine as is.  Someone
>>> should still double check all of the call paths though.
>>>
>>
>> Original one is also not correct. For example, if this is happening
>> after reset re initialization, only that sequence needs to be modified
>> to keep the affected IPs ungated during reinit.
> 
> It also gets called in amdgpu_device_fini_hw().
> 

Checked now. What I meant is - we should call ip cg/pg ungate insid 
amdgpu_device_fini_hw() to protect all other accesses within that 
sequence and not restricted to irq_disable/enable all. Now that happens 
a while later in amdgpu_device_ip_fini_early.

Basically, the high level sequence needs IP pg ungate protection.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Alex
>>>
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Cc: Yifan Zhang <yifan1.zhang@amd.com>
>>>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++++++++
>>>>>     1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> index 36f0300a21bfa..05178ee8e0e3a 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> @@ -6056,6 +6056,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>>>>>         u32 cp_int_cntl_reg, cp_int_cntl;
>>>>>         int i, j;
>>>>>
>>>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>>>         switch (state) {
>>>>>         case AMDGPU_IRQ_STATE_DISABLE:
>>>>>         case AMDGPU_IRQ_STATE_ENABLE:
>>>>> @@ -6080,6 +6081,7 @@ static int gfx_v9_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
>>>>>         default:
>>>>>                 break;
>>>>>         }
>>>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>>>
>>>>>         return 0;
>>>>>     }
>>>>> @@ -6092,6 +6094,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>>>>>         u32 cp_int_cntl_reg, cp_int_cntl;
>>>>>         int i, j;
>>>>>
>>>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>>>         switch (state) {
>>>>>         case AMDGPU_IRQ_STATE_DISABLE:
>>>>>         case AMDGPU_IRQ_STATE_ENABLE:
>>>>> @@ -6116,6 +6119,7 @@ static int gfx_v9_0_set_bad_op_fault_state(struct amdgpu_device *adev,
>>>>>         default:
>>>>>                 break;
>>>>>         }
>>>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>>>
>>>>>         return 0;
>>>>>     }
>>>>> @@ -6125,6 +6129,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>>>>>                                               unsigned type,
>>>>>                                               enum amdgpu_interrupt_state state)
>>>>>     {
>>>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>>>         switch (state) {
>>>>>         case AMDGPU_IRQ_STATE_DISABLE:
>>>>>         case AMDGPU_IRQ_STATE_ENABLE:
>>>>> @@ -6135,6 +6140,7 @@ static int gfx_v9_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
>>>>>         default:
>>>>>                 break;
>>>>>         }
>>>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>>>
>>>>>         return 0;
>>>>>     }
>>>>> @@ -6152,6 +6158,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>>>>>                                               unsigned type,
>>>>>                                               enum amdgpu_interrupt_state state)
>>>>>     {
>>>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>>>         switch (state) {
>>>>>         case AMDGPU_IRQ_STATE_DISABLE:
>>>>>                 WREG32_FIELD15(GC, 0, CP_INT_CNTL_RING0,
>>>>> @@ -6173,6 +6180,7 @@ static int gfx_v9_0_set_cp_ecc_error_state(struct amdgpu_device *adev,
>>>>>         default:
>>>>>                 break;
>>>>>         }
>>>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>>>
>>>>>         return 0;
>>>>>     }
>>>>> @@ -6183,6 +6191,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>>>>>                                             unsigned type,
>>>>>                                             enum amdgpu_interrupt_state state)
>>>>>     {
>>>>> +     amdgpu_gfx_off_ctrl(adev, false);
>>>>>         switch (type) {
>>>>>         case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
>>>>>                 gfx_v9_0_set_gfx_eop_interrupt_state(adev, state);
>>>>> @@ -6214,6 +6223,7 @@ static int gfx_v9_0_set_eop_interrupt_state(struct amdgpu_device *adev,
>>>>>         default:
>>>>>                 break;
>>>>>         }
>>>>> +     amdgpu_gfx_off_ctrl(adev, true);
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>
>>

