Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87231C3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 16:23:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BCF610EB1F;
	Fri, 16 May 2025 16:23:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dg50MJGW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D1310EB1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 16:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZd4625qn1IE25H8K7N1LfGcG7YRdJxBDK3jKHNGa2eJ4nKgUlL9MQNb0kVNNNAnLRkHMN/oJ4fLFyLp2f7Q+kj0FDc7MyOki+hcurwn7xOL3edVxS0PyFD0LZFyvJZIcUj4EK0tdpnAyTwhg3LErboZfwGJRaUzkVuahlTQ+mIXT8Yyu0dJYblNEQSUpYFGdRzpCTOtLO/YiFGaFBwBirT5CC7SN+sA8L6rFocApO1gINxYp/m5pqt23agn5iAAD45y0yrRcJgNdSMDAwYCX0Lz8Icv8ZTlVn4/NhrP//Vw8iPbR5SnCf/k7d4BHVa12z0HnIUih58V7EGXikuymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGcz6uHFYMu8jX3qPHuC0SF09+fb5d0DY7mRjh3O55U=;
 b=hqPMmF/SUxRqzjttzjQxjomBLrl8HT8h3/ksjsimse5NdlTpg05tMGdHhauSaTDadg37kueKQ4ZHqll/89ghOSv0Ptkky4E4RtH7dxbLr6SdyBt/17B5e14F/fbOqt7zcYTkXXiWOMPgAUa52TdH9ghHTkmZxmQyEJNKS53pF15G3RNNvEYsGlDx9FLbH2QzxFOS9/a76wVETtBX+8q7j8EPRUg97GQxAlMMXgQd/eRVHmsjNwGu14YqW+KRI20coNp7wqwM5FS1/5m7EggKtDgBds8cWmY4fP/1TWVJd7UnOntO5kX0Qroj37sHj1ZVw1cDkD+fhYlJsorFFrLB0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGcz6uHFYMu8jX3qPHuC0SF09+fb5d0DY7mRjh3O55U=;
 b=Dg50MJGWEad1RpEI/hTJyt3QkMBtMyUn8QbEnPzw5mNincojvnpZYQV2O9WNh68QUlu1TUwongqNeICt14H7CXx6coSGqtJnn3AQJTFTfgF+ijQ/7GO1KfAAMiXXjHI2HPHTC5pAGdvtO1Co8aKgpNCNMKxeSgxXkON8gnmIABA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 16:23:22 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%5]) with mapi id 15.20.8699.026; Fri, 16 May 2025
 16:23:22 +0000
Content-Type: multipart/alternative;
 boundary="------------RYNdvV4mFmUkrNmbYAv0lLS3"
Message-ID: <73dd9680-1aca-4e73-b43f-495fede147cb@amd.com>
Date: Fri, 16 May 2025 12:23:19 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: read back register after written
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-9-David.Wu3@amd.com>
 <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
Content-Language: en-US
From: "Wu, David" <davidwu2@amd.com>
In-Reply-To: <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
X-ClientProxiedBy: YQXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::37) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: fb55c995-5f77-434d-6614-08dd9495f9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1dCVmRYQmo3Zlk3bm1aSGdYcDJUaElBbmd4QmE3UzhrUWpoWTgrcGFGQmZX?=
 =?utf-8?B?VDdOYjQ4cmtiR3JVU1dsWjRXa0loQnNPZmlMUDAxYjZUWk1tK3ZpZTBWT1hw?=
 =?utf-8?B?WXNhWHBBbE1GZnpwN3ZRcmNiTHFZclVuUUZqSFpyV2kwby9OcVBzRG5FbkxK?=
 =?utf-8?B?QmFiZ2srZEdDVnJaZEtmd1dYTEZFRTNPSkVzK0tOcElHdC9Pc3pHUWIybzBx?=
 =?utf-8?B?bmpUSTI1Y25yUWp3Tjd4bVJ3TjNuZjRZc1cwT1pTVm1Qd1hMRExObXUwdkR4?=
 =?utf-8?B?QVZmWHFQTTBrZDdraVEyZ2FxcnpVNDJqcTZSNVBYeXRCUnBvV1JoRjRQaW9o?=
 =?utf-8?B?dGdXVTcveFdDU1FTYkFKMk55aENRTndLRWF0SWVCTzBmZFdpUTFqN3I1bWl1?=
 =?utf-8?B?QXJYUFl2c0tOL0hJVFlBQ0V1V0NkR2p2MWgyR1ZNOE5STEdGOGNTSVR4bE9w?=
 =?utf-8?B?KzlDV0pEYTl0dkxJOHBsSkw5UGVxT3g4NVNCcXd3S211ejVzN3BrNTBiaEVS?=
 =?utf-8?B?RVJEY2VlNGZ4RENLelpENjh0Vk85R2VPWFU0UGNZWVMxTkJmVm5hbnAwM3Jp?=
 =?utf-8?B?WndGN09NblR2QXZpZDRuSVhOUUQ5VnNlZms5SGJMMFkvZDRNemk1dTJ2cG9T?=
 =?utf-8?B?ZzhBdFdDMWpuNW9NaE5ZOTNuTmFXNHpPbnEwbWVnRUhnMkFMc1EzNkVUWDJK?=
 =?utf-8?B?cUtYem1Fc0lqUkhBcG05ZlNSTVdEOGttN1hpWEJ6MU01eGpYTE54MCtuUFdV?=
 =?utf-8?B?OXBzbXBSSDhmVlRTUTJTSUdFeG5CVGpDTTQ5WUVwdUdBRnRtSlJZL2VPZWZK?=
 =?utf-8?B?VERPb2VVSnZUWVczRG05Qkc5eWs3UURGN3I3VExXWkFlbytrd0gvMGlJUENG?=
 =?utf-8?B?bTFYMHhOS0k5aEw3bzN3UmpPYTJTbTc1YVF6T1NHYWlyR1BjWkVLL091L2ov?=
 =?utf-8?B?UGJHcmUzRmg3L0VuT3hHdWtheGZ2L0Y1Y1d0SzNacWxzYXdDNjgzVnh6OUs1?=
 =?utf-8?B?YWE1OEZOdXpFRnpNbGJaek1kbTdKZys0Z2cwbnkvTytheFF5SWdWWUhKWVJv?=
 =?utf-8?B?a3M0TXREMGZpbEhEb0NyWTlMdWpyM0sxWkl4dTRQRG81MnR5cWFPampuVTJJ?=
 =?utf-8?B?OHRsSW9EQzJBYjBTdTRVTEpjYUtpU0pBQndTazBLZCtPa055SEE5Rkhhenov?=
 =?utf-8?B?NkJGMS94bWdlc3VHK3cxVTV1VHVqOU1XQUhrYmsyS2NQMmhqdXpYQlRYVWtQ?=
 =?utf-8?B?NkRpRW1keWEvbFdtVUU4amJuWDU5WTZqNEVnY2RoOGh2dlJDdWc0T3pqU3l3?=
 =?utf-8?B?blc4RndzVFZQdlNCSU56Q3MyT0ZCazVsbi95U2ZLaHYxSUxIOTF2U1hwa1I3?=
 =?utf-8?B?RUQ4bG9yK3FZSUNNUVpOSXFQQ2U2S05maXQ4SWJyaFRINFZwSU1JRTdiekpw?=
 =?utf-8?B?bTB3WHlua0hENUMzMytiSE1ubmNqYXkrdlR0K3ZuaG5pL3hpK1V5NDNNK1JT?=
 =?utf-8?B?RjhMNjh0RS9PZVFDVU51TFFZbHBiMlNqcmI3amtvdldqdU56VFBOLzA4SFYr?=
 =?utf-8?B?M2NYanJrTGROL0h5T0tlV1FMSGdYdVE3N1pLYXFXWVRTSlJkL3MzaEdwcHRx?=
 =?utf-8?B?SUdoR1F5QlhtVDdlOTBXK2xZSlNhem9MUUZ4V1RtY0pKSVh5L0NqTTFxZTBT?=
 =?utf-8?B?ZllvZGI0QUNKM0hTQXpaZHNJK2IyY3pPS29oL0sxQXpmVG1QOHBvTWdUTlg5?=
 =?utf-8?B?K2dyVkVNenlDSVZtbXBuTjhvcDBDSVY5ZzA3UmExZGtxQzNubnVXbDM1ekM5?=
 =?utf-8?B?UUxMNlB0YjZPd2RZaU1nS2JtMHl6MThkY2JyZ1NNUm9PRzVoeXdrNkdnQ1pa?=
 =?utf-8?B?dFQ4K0lpbVVweHhQOFpaRDcrZjlZQlJjcjZvbG45MTdNTEhZNEpWd0lNWE4z?=
 =?utf-8?Q?fxrECMdV9JI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhReHR4a3dtdnZyai81Slg3anh4Wk4zckUrb3hiMmc5eUR0VC9FR29DNmR4?=
 =?utf-8?B?QTBvcWFUaGExQ25acm0wd1J0S1NyN1dzK0VCWTFPa3JzUEFlYUcrcjNSU3hJ?=
 =?utf-8?B?cmxkOThjY0xFWDhpYVA2eHdhTzVPSDIrWTNIVzMzUkdkNVdwek5BcytHT21D?=
 =?utf-8?B?eGtqU3ZnNUg3VnB4RmFySTErVXNSTkVIbWc1RFJ0UGFyMVFLVGdzc0RMQXV0?=
 =?utf-8?B?SXg3NlBzRVVzdlBUR1JOV0xuU1c5WmNJS1kzMHRvYVBUZkkrYlFWdXhUbUFw?=
 =?utf-8?B?aVRjZzdZWVJ4Z0NZeWNHelNFaGx1TE9YNHJ2MDlYdWEwYzBJQnd0SFJGRitE?=
 =?utf-8?B?aHdyMzh0Yk4yUFByTjFUaHlIUlVJZk9NVjZZemhjQWc4eitlcXUzdGVjRFlr?=
 =?utf-8?B?Wko2RGc4aFFuK3c2a2RrVnhDRE1YTHlKb21SZlpQdFBEeG9BdVB3WVd5VVdM?=
 =?utf-8?B?ZTErTjcydkQ0bjFFY0g4Nnk2dVplaktlRTJVUHFnaUpwTzJqQXZyNjJOcEFH?=
 =?utf-8?B?WUNHSVF5US9uVllnTC9UbWZxcTNrbHBFemE0S3ZHVzdBcG56a1BPSnRVb2NL?=
 =?utf-8?B?aFlTUXRidnpUVWJQVTlEbjZGQXppdHJRK3JXMzVjajZiVWZ3RnU5aXhDbkdT?=
 =?utf-8?B?Ym1LbUtJaVoxdUZzVzhMbHlFVFJqNW9CZndDS3dIUDJsVDQ2UmV2U2RJL0sz?=
 =?utf-8?B?VG00em1kSHIvUFp1ODQzWjIxMnd5cTR0ZDlaUHU2NnFLQTNhRTVMOE9EaFp6?=
 =?utf-8?B?V1IrZnhBTXY5cVJuYTA1bCtsTFJWSy81TU5kOWptL2IvcStCbFdIRHlPb2VH?=
 =?utf-8?B?Y0p1QlM0cTdNblNVQmNoS3g4OG9sYW14bk81bnFLdmVvT0NLMENFVzFDcThQ?=
 =?utf-8?B?cUU2eHVTTW1MZEZoMzgyQWg4dXVIMEhWTys2Unkvc0pLR01IclllaytHZENV?=
 =?utf-8?B?bmQ4S08vRE1BRXNNcFZHMmdjUHBMVWlZT25JYUdpWlJEd2VPNFc2RlcxTHVn?=
 =?utf-8?B?dGVpZVJRSjFuTDdONWI1Ulp1c3ViZzcvb3c5N0hkenJQbzBYbEluc3hzSzRw?=
 =?utf-8?B?SDZ0QldJaUg4VXM4VGJBcXNkSWhQV0RaQ05HYnMrZjVSdkJPaWdJZ2xUTXdn?=
 =?utf-8?B?S2c2emRTVUtobkh5bEU4aUZVcDJPaGhINVdjRWlNQkNoV3o0ZnZBaHJ1VGFk?=
 =?utf-8?B?VEZRdHlQc1VRN3ovRTZGcFhsbTRHZ01qRTMxMTk0cEhEMnZNNEJYZXYvTlpD?=
 =?utf-8?B?WU1wSUpwa0x3eU00OWlDRVFhM3dYYzdwdWNXRndnRVc3TnkxaTN1VnU1cGY2?=
 =?utf-8?B?VFBLaFlaajBiVXd5MTRZQ2VtMDlDbklWbndaYmM0ZlVQRCswZmdTckpacGN6?=
 =?utf-8?B?bjBBYkUrQnIzUit1SUx4ZHZ2ZUVXVlJ4SFZFVU5VWEFVNThiRDd4QlUyaVlE?=
 =?utf-8?B?S3FQQTZqQ2pSZndxUmd2UUNuL1RDKzBuNmwyK0k4Skx5ZDNra0h4MGV6cmtZ?=
 =?utf-8?B?bm1wQkUrcW40K0pOMlNzcklPQ3pNLzRjRHlIVlJFRTVTQnZYcEdDZ0dGTUpZ?=
 =?utf-8?B?enVreVVFdzlVYkNrVUdGMzM5ZEZXNWNES0tibUY3c29KeDNvUHhnYkhyK05T?=
 =?utf-8?B?UlJxQUNiU3dPSldabDlwbCtZVXN5c0NydVorVFRUbmJDbmNtVUpDY0VWcUxO?=
 =?utf-8?B?N2o2TUZ0czU2ZWVqa3NCZFVXQWtCclFuVHd3SXpqVE1rUzVjOFBwSU1qZCtY?=
 =?utf-8?B?dWgreDg3NUl5WHVNRHFrUEdTZVBVakN6cmcvZFA5ZVd5cGZwWEtkM1R6ODRq?=
 =?utf-8?B?TzhCU0w1b0V4ZHBqck01UU1ESkFPM1czVTluUDhaZVNzTFFNLzlnRXJkWDc4?=
 =?utf-8?B?YzI3c2hUQXVVKzk5VDlBN2xGa1R3VEtXTm5veXFsekZJVlBYZnpCeE5MRXp4?=
 =?utf-8?B?Q0Fxdy93aXNzOU1FQnM4bjdSYUVsMVFyWk50TkV4MzdUWVRzclRrSU5mbXN0?=
 =?utf-8?B?WUZHRjh0d2ZqSGNNazBSSndKQldUTVl6bFozbWZEcm45bjUyK0doWFZEZjN3?=
 =?utf-8?B?ZzBSeFljaWFxc3NDVEdUNk1YVDRoc0dsdVdMT3hrLzhnQ0YrZ1JXYWtDbzJV?=
 =?utf-8?Q?c+fdb63GAgrZYf5os6/Z3wtrP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb55c995-5f77-434d-6614-08dd9495f9f4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 16:23:22.3092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPaFblCutZ/mqptOF95jUctylGYmmnkV4K1sZ+R5FYukSSAeBLM6DnB2u1rbshNI4Ef96I9a4dtODcEUl9qwPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

--------------RYNdvV4mFmUkrNmbYAv0lLS3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,
For this change on VCN5.0.1 I will leave it to Sonny for a test. Since 
the readback is for each VCN instance it should work for that clock 
domain. As Alex has pointed out that readback post all writes will let 
the writes hit hardware, using UVD_STATUS instead of VCN_RB1_DB_CTRL 
should serve the same purpose. I also tested it on STRIX VCN4.0.5 and it 
works ( using UVD_STATUS  instead of VCN_RB1_DB_CTRL ).

Sonny - Would you be able to test this simple change?

Thanks,
David
On 5/16/2025 3:07 AM, Christian König wrote:
> On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
>> The addition of register read-back in VCN v5.0.1 is intended to prevent
>> potential race conditions.
>>
>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
>>   1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>> index 60ee6e02e6ac..79d36d48a6b6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>> @@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>   	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
>>   		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>   		VCN_RB1_DB_CTRL__EN_MASK);
>> -	/* Read DB_CTRL to flush the write DB_CTRL command. */
>> -	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
>> +
>> +	/* Keeping one read-back to ensure all register writes are done,
>> +	 * otherwise it may introduce race conditions.
>> +	 */
>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
> I'm not sure that this is a good idea.
>
> The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.
>
> Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.
>
> Regards,
> Christian.
>
>
>>   
>>   	return 0;
>>   }
>> @@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>>   	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>>   	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>>   
>> +	/* Keeping one read-back to ensure all register writes are done,
>> +	 * otherwise it may introduce race conditions.
>> +	 */
>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>>   	/* disable dynamic power gating mode */
>>   	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
>>   		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
>> +
>> +	/* Keeping one read-back to ensure all register writes are done,
>> +	 * otherwise it may introduce race conditions.
>> +	 */
>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>   }
>>   
>>   /**
>> @@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>>   	/* clear status */
>>   	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>>   
>> +	/* Keeping one read-back to ensure all register writes are done,
>> +	 * otherwise it may introduce race conditions.
>> +	 */
>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>> +
>>   	return 0;
>>   }
>>   

--------------RYNdvV4mFmUkrNmbYAv0lLS3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Hi Christian,<br>
    For this change on VCN5.0.1 I will leave it to Sonny for a test.
    Since the readback is for each VCN instance it should work for that
    clock domain. As Alex has pointed out that readback post all writes
    will let the writes hit hardware, using UVD_STATUS instead of <span style="white-space: pre-wrap">VCN_RB1_DB_CTRL </span>should serve
    the same purpose. I also tested it on STRIX VCN4.0.5 and it works (
    using UVD_STATUS&nbsp; instead of <span style="white-space: pre-wrap">VCN_RB1_DB_CTRL ).</span><br>
    <span style="white-space: pre-wrap"></span><br>
    <span style="white-space: pre-wrap">Sonny - Would you be able to test this simple change?</span><br>
    <span style="white-space: pre-wrap"></span><br>
    Thanks,<br>
    David<br>
    <div class="moz-cite-prefix">On 5/16/2025 3:07 AM, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b52390dc-05a3-463b-9bee-001c6cafb303@amd.com">
      <pre wrap="" class="moz-quote-pre">On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The addition of register read-back in VCN v5.0.1 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 60ee6e02e6ac..79d36d48a6b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
 		ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
 		VCN_RB1_DB_CTRL__EN_MASK);
-	/* Read DB_CTRL to flush the write DB_CTRL command. */
-	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I'm not sure that this is a good idea.

The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.

Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.

Regards,
Christian.


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
 	return 0;
 }
@@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
 	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
@@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	/* disable dynamic power gating mode */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
 		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
 }
 
 /**
@@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
 	/* clear status */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
+
 	return 0;
 }
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------RYNdvV4mFmUkrNmbYAv0lLS3--
