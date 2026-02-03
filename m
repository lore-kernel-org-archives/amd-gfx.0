Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78C0E8783A
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:23:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0C610E05A;
	Tue,  3 Feb 2026 14:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HZB53mZu";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013050.outbound.protection.outlook.com
 [40.93.196.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B2110E05A
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouoU2B5FK2wXwG6Qvvhjc+bvxZOef+kaq45N9jvqWee1c81G2yg/YJX+JaV2O3310ArDPzqftn9fxuZMdVqw4Ew5wrlW1ndk4U+IgicchAGOpRzYBomdkTX2E2T1tyYlBSfJcWsvCuhTbHb/6EJCC3Em9Wu+nYUhMAtFdAZ4KWw8n/l1VU4jup8V+6upEsh5cDOSKf+FpflR9YcDriyQC0gcWKXCHZCScX6ojwDCojDGTRMkQHEmUfujP9q8/YkW/YPi7gVqE5OskW7fVaSt0EQG2Mdh9MmU8Cbyfh9vI3Scya5hqHTafbTk9U9L4jbaY/LvXL7nKoLXyeAT7d3lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JaQwtffqfilDAPbHLUUn4O/bU4OnM0oxTpnYngNWi0=;
 b=LV4vLSKUB5dHEl0suMqH0gK1DSmAlE/qbskmYd3n7XqKUduNgXoIFaTprjZQhxE8QnSWQrWiFshsO/W6ise9VSqNmFBGEhU5h1d2gPwzEf5b3Dky2mQpfv80cLkGVWuOFP+15JsqP2mxzJeIfv2r941AkeRP+52jm7U+EWHFInGlNbfnnmPyXyk5CmdaYiNtDiCR2RBEAMC1XBNR0LMYuQ+n3dzHpKtTu1Rwyw5vHQ7LR7yyaBd91n2TvRG5zm+lCte2D8iUddVA4//3rOujJYGL/1as1Wn+uqOFMAUS6CN8W1x5vJbMY50vFf4zqq04R8KlKJmfGi8Yv0PfYuODaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JaQwtffqfilDAPbHLUUn4O/bU4OnM0oxTpnYngNWi0=;
 b=HZB53mZuWYXl7kA9oENMlgmNMmWuIl9HV2XF7FQn9Rcx3bmgDMlH1p114+zhnhM45Kjg8V29vPxN986yLe+rbxkTTcy5qagvO2rF5p0hlZOQz03mwp3yBfYuySMQkH4jUKaK5uE3PYv2+6QLZNMYep1gTkPk1nsynt59Wc2902g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 14:23:04 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 14:23:04 +0000
Message-ID: <efaa1f85-df4d-4c85-a9b1-e081b0545a63@amd.com>
Date: Tue, 3 Feb 2026 19:52:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdgpu: add MQD update support for user mode
 compute queues
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
 <20260128105847.2898288-5-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260128105847.2898288-5-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: b90edae5-cc14-4875-31b0-08de632fbe12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d2hZWmVwUzhDeVpNNkcyV3dRZmhxSjF6M1A4bGI2ZVVJamNUcVNKVVNrQkw0?=
 =?utf-8?B?eFJBYTZmWjRVSGhsNlNsZ0VRRDdYaXdVQTNjL0xnbS9Yc2pSNTJUcnBvVWdq?=
 =?utf-8?B?UzZaanZuZTJXK0pHOFFHTHdBQjl1QUlBVjBKcituN0N2MVBuTTYwYjNvbzNa?=
 =?utf-8?B?SGw0NlFIZC84QmpkQVZCUWlINzlxWGRzY2dNVUNTS0N4aTd4c2JCR0FTREdh?=
 =?utf-8?B?clNKNW1rS3NwSEZ3MWZoU3UzNVQ4NnUzV2NjejN2NUZXRmVwQWZ1M08yVEov?=
 =?utf-8?B?N003d3RSdm1TMWlZZjBTYTZFcHFnalVkU1NhdTBxd2pDSVdEeExmbDFHSFRw?=
 =?utf-8?B?MmhpNlVvSXUyK2FEbU1naHNtQkZQYlhqbWthNUhoMXNtOVUzRHRES1RvZ1d5?=
 =?utf-8?B?Q2FNZVkrRXRQS2tYOFRFVi83MGxXOW1MMVUxbi9lZGN1L203bjU4NHl0ekhB?=
 =?utf-8?B?R2pVM085N0tDZXBpcklIYWR6aHRpSklXdXRJV1FVOEhGRlpURjQ3MTU5TS9P?=
 =?utf-8?B?cnAxTmErZHpiVkN6dW1kZkVYWXJkOUw1a0ZJNWFQaUxETG11Mk5neVcvNXhw?=
 =?utf-8?B?SytSVWRXRlZwQjBVR0hlZlUyQTlocjhIeHRLeTV5YnBnTTh4WGU4ejJYRkR2?=
 =?utf-8?B?Sm1TcVpVcUxsL01YR0RPNWdFeThaOXQ3U1lUNkJwaGZTOVlaazJPUDZYdkhJ?=
 =?utf-8?B?L2RPNzg1LzBrLzhFL28xOXplYXFEaGQ4SkpJQ3B4cnZ1dGxVSlNhR2NDaURL?=
 =?utf-8?B?ZVBDRVNvYXN0R1FQODZSZi8vMnVzNjJuT3dSUmpvK1c2RHRXcDF2U2cwSm1I?=
 =?utf-8?B?dnpycExnNENZdEV2WHJiSzB3RDlvVWU3VitxNTJjWUdkNStaOVBNM3k4WTFy?=
 =?utf-8?B?OUFzZklLQ1VYU0Jobitua1doU25jZzM4QWhFMWU2QXh6a0hoQkF1cXNRWTNP?=
 =?utf-8?B?U1RneUJLMEs1SDg1MWhNKzJKaGIyMFJRaXQxVU1NOTFBcG1wbzNoUERXTUhy?=
 =?utf-8?B?Z0lud0dMOHhUVklmSUkxVTZReXBOVW1oSVZoWmRpb2ViRFFlS2trWVJEQWdw?=
 =?utf-8?B?am9oWVA4dC9WY2Q2MUxveExCY1BFNmJWcFVJblZENmpEOVNjeXFHTDdNbkJv?=
 =?utf-8?B?SmlOb3NMY29La0Jnclc0eUpOcVpKMmNWZ2xiWWV5SmtQeXJBU25RNEl3Vzh2?=
 =?utf-8?B?T25rRlNGU3J6cjRQWlhNa0dxbnJNWDVMeFptL0VOaXJGbS84Z1NubVNZL2dP?=
 =?utf-8?B?RE1BUXhGY24xcTBVZEdGMDFaYXNtcjd6eUVrMktrays4Y1pDMGVGdHRqK0hN?=
 =?utf-8?B?NWN3S200TWE5QTFER2hrTmxZZDNDRnBiVHB0TXd0WW1hdE9YbGhUc1BxanVz?=
 =?utf-8?B?OUV1cWNVNXJnQWU0NzFESS90NEJQdUpHR2tBaDMxSlYwN0JpQ1QvUzQ0cE8x?=
 =?utf-8?B?WlJmWmFWUzZWWnk3MkZDZGI3dndWZnFBRWlJYllVamMrTG14KzZrQ09JS2Np?=
 =?utf-8?B?emlsZVlUM202eFNPTFA0TGFRYWFYOS9wY1JWNFBKWWc5TlZUcUZQdW4yUkRv?=
 =?utf-8?B?OW16OHRNNXRESkJxOHUwaXU3TUp0TjVLMWdEWFNzM3hIektOUnRNamZvdlpY?=
 =?utf-8?B?L1NuZUNVWlFOVzB6RWMxS25sM1l5VXkwaDlRN1FCWEpJZkxzQzNSeXVkTnBE?=
 =?utf-8?B?d2s4dWxQRDlVYmFiUEkrZTVnZGpYajRsWGVKNnFaYXh4Nno2eGxmbFFJZVdX?=
 =?utf-8?B?RTBrQ0I0RFg0K09Na3VzSW0zR0dZTFNaSG14YjlBcW1sRmMzdSsxUjUxeVJL?=
 =?utf-8?B?U09qYnZVVmYvQzlXOTBZSmtTM2pZdnlkZmVZVFRuL016RWdZVjROQXlpSHVQ?=
 =?utf-8?B?eGdjQVdubmNqaDY2RkQyWTBCdGJxWllycDVQd3N6aVYxRkhFenYzNERuNGdz?=
 =?utf-8?B?aFdxUmlIU2YwbFpRWkpVbXNwNm9HbFlaTGtRcWdoUGQxL1A2aHRPT3RMTkQ5?=
 =?utf-8?B?VnRVNXhmWE85dnRhS3BwM3hCaXBZbWpPTjcyQVAxc1hJZlpadmRJcGtvR09t?=
 =?utf-8?B?L1lLakxadkp2bW04M3l1d1ZKRUYrbi9CVWlMTGFyQ2lnSkNpUk9mT0xYYzF0?=
 =?utf-8?Q?bpRA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlEQlBnblJCOUlyc3orREJSYldEL2dQMFJGVG1EYWNPNzFKS1BObDlXTFhG?=
 =?utf-8?B?eVZxWkc0cFhNWWxsV0Mvd2tGL1FVeVR0Uk1XalduRUNGWkd4Z0orMm1VbDZx?=
 =?utf-8?B?Y3lRc2RhcHFKN2JMSG9NMWNUbGZzWlFIOEU5Snk3eEFzd3BtWnJWL2lJSlhz?=
 =?utf-8?B?S0svVlEzYTl3YXB4MHJjanhHb2cwYitvbFNSYkxQWlRoSWVQd3l6QmhBOUd4?=
 =?utf-8?B?ZW9CN3E0NURxOXVRVGJ1ZFp6eEVJMlFwazBVWHhKZ0FQMER5OTdQNUo5MmhS?=
 =?utf-8?B?eHBzVjhVWFQzck9Jb1Y3TTFIbXRJSE9Ga1BQeVJ4TUJJSEx6Z0xVVTdBL21J?=
 =?utf-8?B?bTEwZjVlNU8ybmlYY3dEbFFOUFQzcWRDbkNUWk16VW1ZWGxYSHNTMTczM1Vh?=
 =?utf-8?B?QjY2Y1AvV2RmaUh3dlZDdVZHd0RYYUxUQlRjVWxBakR6cE82dEQ2NXJFMCtV?=
 =?utf-8?B?T0VsaEpnT3lkS295UEZrRk8yRDFoY1VUZWIrQVFMT0lYbDdIRzlmczBQczVs?=
 =?utf-8?B?cjRpS3AvNDFpdTdCajZvVmFWY0pWd00xUFlFTGRzTTdWeFhrOUh0Z3lxSjVs?=
 =?utf-8?B?akdtZThZRXB0R3M0ejNPMVVsM0hkbWtMclR4cE5INnBOc1RYaUsvMDlHQUJz?=
 =?utf-8?B?Z2t6SGxpWDhYOTg2Ykk0LzVxaWZjQW1zRFoxaTE1N3hSc2JuNEtsVnJvL1NE?=
 =?utf-8?B?a3ZRVlg0SVM0c0xXN2ZQQnAzVGhWdVdLdGFxb25xRE8vS1hUbzFZNU5zdHVL?=
 =?utf-8?B?QldjNWpBUlBHRHpPRlJlWVpDZXYzVXpjUTBoTkhSNCtRK2IvUXZkTVpZTmVM?=
 =?utf-8?B?UWdlVTNsd0JrVVJLNVhlcFUzV2tJRVA2N1gzZzV6RlF5SFpaWHpmUFd3OG43?=
 =?utf-8?B?ZDduWWlFYW5OVmpiV3VDVFpNdUVac3N5azR3OXljWlpYVy9yZWZtSUhVbHVY?=
 =?utf-8?B?cUpnT1p0Q0xzeDVQUGJsVEE5NUFLYUQ0Zm5KQTJlNW9uQXhEMHp0SWNBbUpV?=
 =?utf-8?B?TlcvQ1RUV1hQVDhXRnVncVIzZGdPZ1ZxWGo4Q3lTZGNqVFp4UHphV045dXoy?=
 =?utf-8?B?Q3ZHblNkZ1lTcy9SSkZrd2xsV1JTSURCQXlMTmNSNDVmY2duc3FOcXlacXRz?=
 =?utf-8?B?akhtZjEremltNllPZHVYRi9hTW1odmc2cVIySUZIZG1FYlFSNVlKdmdibXA0?=
 =?utf-8?B?SnJybXlmZ1FBLzFyU1VFOFNLV2dJNWZiRmI1TnFLbXc0VXFSUWwrSlBUYUtY?=
 =?utf-8?B?K2FmZTJtOTIvRnBDVlVlbGFhRVNSZEpzTFYzZnlMdkt1QjIvUC9Nc3RIakxi?=
 =?utf-8?B?bEEweWYrUnoxMW9Nc2w1SmttZStYVkMrbzZFSmd0eXRhcHNoY3EzbEZianE4?=
 =?utf-8?B?QTZzYmhzSmVuMlRkNmlsdno2UHlRWTczZkY1V3FPc3N2Q1lyVDRuSWdobE1j?=
 =?utf-8?B?ZDJsMHdUQXY0dGJPa3BCeUtoZlhBREZzWkxSSkxuRzQ0dm9RTnRCMFU3ZXZt?=
 =?utf-8?B?ei9PZDE0OXl1QVI1eTBoRzlCUnlCb3RLVGdDb29HMWx3eFNmeS9XSkM2VFZk?=
 =?utf-8?B?WkJyS2xEVDNGYWc5a2V1WFpCL1JjdVBFZTRoR09FMGZMU0wyNzhsZ3h6d2ti?=
 =?utf-8?B?cXE3YXdlY3l3QloxZWN1ekpFajZyZHhkWW9tZERENi9jTmxVN0JJMDl4a0Rm?=
 =?utf-8?B?cnNIRHh4NzRML2ZJWFVvOTc3WTRQb2lRd0lJTFduSTBsc3JqZk1EVjJmYXpJ?=
 =?utf-8?B?aVRCNVhRNVFEa3pHYldhckNKalRic3hGUktUZWV3QUlNaUZTcTBSbjd2N0hN?=
 =?utf-8?B?WTBDWURIODRzVkhjRk8rUUlWaXd0MTgvTVp0TjhNSFNaRHlIUnVybGREUHg1?=
 =?utf-8?B?RkkvOUtodkp2SVdTZ2dKVS80ck8yVEFLU25kaVpoUE1KRHF0OUpFQStkR0Fl?=
 =?utf-8?B?MUJpNERiTFJuM3drUkRBdUUxeTByeGRBUGJvUzc3NWtjcVlzQk1Jc1Vtamtx?=
 =?utf-8?B?MEc0bWVDbnZTN3hrdFc2aWxkQzNmMXVJeC92UmN4ZnJ3NE9lRFNXY0NkUDA1?=
 =?utf-8?B?UUpiYi9nV3VFNTA3VEhqelZOZ045UmhpV0FJT3JycUswaUwrYVBrNEl1Z1ov?=
 =?utf-8?B?TWxCeHNKTjNvb2FjS3FxNUI0QTZxV0dOelVVaGc1ZEl6VWNGT0dhWFg2QjRk?=
 =?utf-8?B?VEVpWm9HTWl4YURVMHVWalV1Zzh4L2xTN0ltUU9tQk9LeUt5OFdLbWVzaElF?=
 =?utf-8?B?YzB0czhYWFpKTTZkc0t6QlErdnVDNGxmQVVKdUt3UkVnWDA5UFBKdzB4cmZH?=
 =?utf-8?Q?g8Pa4b+h4CFtGcMmnf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90edae5-cc14-4875-31b0-08de632fbe12
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 14:23:04.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uRmsCSXypX+mPP5Apvlg9riPKVT9bvaPzWOgSx5vKWektWGox8+9fSdru3PtmrB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
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



On 28-Jan-26 4:28 PM, Jesse.Zhang wrote:
> The update functionality allows dynamic adjustment of queue properties at runtime,
> enabling better resource management and performance tuning for compute workloads.
> 
> v2: Return an error for non-compute queues. (Alex)
>      remove the parameter minfo
> 
> V3: put the new paramters in drm_amdgpu_userq_mqd_compute_gfx11. (Alex)
> v4: move the define AMDGPU_USERQ_OP_MODIFY to patch 6/6 (Alex)
>      add the props input paramter to amdgpu_userq_set_compute_mqd
> 
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 166 ++++++++++++++++++++-
>   include/uapi/drm/amdgpu_drm.h              |  28 ++++
>   3 files changed, 194 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a8f4f73fa0ce..ad136145316b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -819,6 +819,9 @@ struct amdgpu_mqd_prop {
>   	uint32_t cu_mask_count;
>   	uint32_t cu_flags;
>   	bool is_user_cu_masked;
> +	uint32_t queue_percentage;

This field is not implemented in KFD itself apart from active/inactive. 
Should this be kept in the same way?

Thanks,
Lijo

> +	/* used in gfx9 and gfx12.1 */
> +	uint32_t pm4_target_xcc;
>   };
>   
>   struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index f2309d72bbe6..d5251f2d7613 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -30,6 +30,26 @@
>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>   
> +/* Mapping queue priority to pipe priority, indexed by queue priority */
> +int amdgpu_userq_pipe_priority_map[] = {
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_0,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_1,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_2,
> +	AMDGPU_RING_PRIO_2
> +};
> +
>   static int
>   mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>   {
> @@ -272,6 +292,105 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +/**
> + * amdgpu_userq_set_compute_mqd - Parse compute MQD and update queue props
> + * @queue: Target user mode queue
> + * @props: Queue property structure to be updated
> + * @args: User queue input arguments
> + * @uq_mgr: User queue manager (for logging)
> + *
> + * This function only parses and validates user input, updating queue props
> + * (no hardware MQD configuration - that's handled in MES layer)
> + * Returns: 0 on success, negative error code on failure
> + */
> +static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *queue,
> +					struct amdgpu_mqd_prop *props,
> +					struct drm_amdgpu_userq_mqd_compute_gfx11 * compute_mqd)
> +{
> +	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
> +	struct amdgpu_device *adev = uq_mgr->adev;
> +	const int max_num_cus = 1024;
> +	size_t cu_mask_size;
> +	uint32_t count;
> +	uint32_t *cu_mask = NULL;
> +	int ret = 0;
> +
> +	if (!queue || !props || !compute_mqd)
> +		return -EINVAL;
> +
> +	if (compute_mqd->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE) {
> +		DRM_ERROR("Queue percentage must be between 0 to AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Validate priority */
> +	if (compute_mqd->hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM) {
> +		DRM_ERROR("Queue priority must be between 0 to AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM.\n");
> +		return -EINVAL;
> +	}
> +
> +
> +	/* validate and set CU mask property */
> +	if (compute_mqd->cu_mask_count) {
> +		if (compute_mqd->cu_mask_count % 32 != 0) {
> +			DRM_ERROR("CU mask count must be a multiple of 32.\n");
> +			return -EINVAL;
> +		}
> +		count = compute_mqd->cu_mask_count;
> +
> +		/* Limit CU mask size to prevent excessive memory allocation */
> +		if (count > max_num_cus) {
> +			DRM_ERROR("CU mask cannot be greater than 1024 bits.\n");
> +			count = max_num_cus;
> +			cu_mask_size = sizeof(uint32_t) * (max_num_cus / 32);
> +		} else {
> +			cu_mask_size = sizeof(uint32_t) * (compute_mqd->cu_mask_count / 32);
> +		}
> +
> +		/* Copy CU mask from user space */
> +		cu_mask = memdup_user(u64_to_user_ptr(compute_mqd->cu_mask_ptr), cu_mask_size);
> +		if (IS_ERR(cu_mask)) {
> +			ret = PTR_ERR(cu_mask);
> +			cu_mask = NULL;
> +			goto cleanup;
> +		}
> +
> +		/* Validate pairwise CU mask for WGP-based ASICs */
> +		if (cu_mask && adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0)) {
> +			for (int i = 0; i < count; i += 2) {
> +			       uint32_t cu_pair = (cu_mask[i / 32] >> (i % 32)) & 0x3;
> +			       if (cu_pair && cu_pair != 0x3) {
> +				       DRM_ERROR("CUs must be adjacent pairwise enabled.\n");
> +				       kfree(cu_mask);
> +				       cu_mask = NULL;
> +				       ret = -EINVAL;
> +				       goto cleanup;
> +			       }
> +			}
> +		}
> +
> +		/* Free old CU mask */
> +		if (props->cu_mask) {
> +			kfree(props->cu_mask);
> +			props->cu_mask = NULL;
> +		}
> +
> +		props->cu_mask = cu_mask;
> +		props->cu_mask_count = count;
> +		props->is_user_cu_masked = (cu_mask != NULL);
> +	}
> +
> +	/* Parse HQD priority and other compute properties */
> +	props->queue_percentage = compute_mqd->queue_percentage;
> +	props->pm4_target_xcc = compute_mqd->pm4_target_xcc;
> +	props->hqd_queue_priority = compute_mqd->hqd_queue_priority;
> +	props->hqd_pipe_priority = amdgpu_userq_pipe_priority_map[compute_mqd->hqd_queue_priority];
> +	props->eop_gpu_addr = compute_mqd->eop_va;
> +
> +cleanup:
> +	return ret;
> +}
> +
>   static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   				struct drm_amdgpu_userq_in *args_in)
>   {
> @@ -325,10 +444,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   						   2048);
>   		if (r)
>   			goto free_mqd;
> +		r = amdgpu_userq_set_compute_mqd(queue, userq_props, compute_mqd);
> +		if (r)
> +			goto free_mqd;
>   
> -		userq_props->eop_gpu_addr = compute_mqd->eop_va;
> -		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>   		userq_props->hqd_active = false;
>   		userq_props->tmz_queue =
>   			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> @@ -432,11 +551,51 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   	return r;
>   }
>   
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, struct drm_amdgpu_userq_in *args_in)
> +{
> +	int retval = 0;
> +	struct amdgpu_device *adev = queue->userq_mgr->adev;
> +	struct amdgpu_mqd_prop *userq_props = queue->userq_prop;
> +	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
> +	struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
> +
> +	if (!queue || !userq_props)
> +		return -EINVAL;
> +
> +	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
> +		return -EINVAL;
> +
> +	if (args_in->mqd_size != sizeof(*compute_mqd_v11)) {
> +		DRM_ERROR("Invalid compute IP MQD size\n");
> +		return -EINVAL;
> +	}
> +
> +	compute_mqd_v11 = memdup_user(u64_to_user_ptr(args_in->mqd), args_in->mqd_size);
> +	if (IS_ERR(compute_mqd_v11)) {
> +		DRM_ERROR("Failed to read user MQD\n");
> +		return -ENOMEM;
> +	}
> +
> +	retval = amdgpu_userq_set_compute_mqd(queue, userq_props, compute_mqd_v11);
> +	if (retval)
> +		goto free;
> +
> +	userq_props->queue_size = args_in->queue_size;
> +	userq_props->hqd_base_gpu_addr = args_in->queue_va;
> +
> +	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
> +
> +free:
> +	kfree(compute_mqd_v11);
> +	return retval;
> +}
> +
>   static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>   {
>   	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
>   
>   	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	kfree(queue->userq_prop->cu_mask);
>   	kfree(queue->userq_prop);
>   	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>   }
> @@ -513,6 +672,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
>   
>   const struct amdgpu_userq_funcs userq_mes_funcs = {
>   	.mqd_create = mes_userq_mqd_create,
> +	.mqd_update = mes_userq_mqd_update,
>   	.mqd_destroy = mes_userq_mqd_destroy,
>   	.unmap = mes_userq_unmap,
>   	.map = mes_userq_map,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index ab2bf47553e1..c52949ea8c1e 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -341,6 +341,7 @@ union drm_amdgpu_ctx {
>   #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
>   /* for queues that need access to protected content */
>   #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
> +#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE	100
>   
>   /*
>    * This structure is a container to pass input configuration
> @@ -460,6 +461,33 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>   	 * to get the size.
>   	 */
>   	__u64   eop_va;
> +       /**
> +        * @cu_mask_ptr: User-space pointer to CU (Compute Unit) mask array
> +        * Points to an array of __u32 values that define which CUs are enabled
> +        * for this queue (0 = disabled, 1 = enabled per bit)
> +        */
> +       __u64 cu_mask_ptr;
> +       /**
> +        * @cu_mask_count: Number of entries in the CU mask array
> +        * Total count of __u32 elements in the cu_mask_ptr array (each element
> +        * represents 32 CUs/WGPs)
> +        */
> +       __u32 cu_mask_count;
> +       /**
> +        * @queue_percentage: Queue resource allocation percentage (0-100)
> +        * Defines the percentage of GPU resources allocated to this queue
> +        */
> +       __u32 queue_percentage;
> +       /**
> +        * @hqd_queue_priority: Hqd Queue priority (0-15)
> +        * Higher values indicate higher scheduling priority for the queue
> +        */
> +       __u32 hqd_queue_priority;
> +       /**
> +        * @pm4_target_xcc: PM4 target XCC identifier (for gfx9/gfx12.1)
> +        * Specifies the target XCC (Cross Compute Complex) for PM4 commands
> +        */
> +       __u32 pm4_target_xcc;
>   };
>   
>   /* userq signal/wait ioctl */

