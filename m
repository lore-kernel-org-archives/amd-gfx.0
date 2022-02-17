Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C771C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 10:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAA510EBC3;
	Thu, 17 Feb 2022 10:43:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A40C010EBC7
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzOP7AcjCeYB3mCeYIaWd0HTrNKCtzLX/i7qZkPAsOsSc7dOB0SMGbeGu7YyK0ii2g6DCxkeymS23AIkLf8B2aIhmbXVNifimdI5JIio02/rrF5QSoklyeuX9w2srI6nMWoEapVQi7lFh43YMhnRXId2E/vRGo8llOg+bnNEPtctUMzeIOcX4hy/5hwbePlBw5uDPVH7wIwgOO2qvbiVnhYbYjWYU0CJDsHMZpBbaf700kPTZ04p+7VopzHGLWzY84zRbAJ1SStxKpINevzvK7V6hfbvOZkSYFfTo7LY5PlLPPdlplbRi+tlOdJyCUaVvcdsP9vlbsCC+ns3ZPSjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/w77MRygbscy0NnmcJvmSZr0/Ao1auHwJTNjz3qnvs=;
 b=m8CEIchsPzYZ6brSeRdfJpisgU+7CnltmWDUHzBPsYQg+gBkB+P/vOjjtJkmMj0h2X+7aCt3wyOC2ZW6g+32AZ/emgaotgGtqEFjfkKDsgPD07w4ZgnLkQW9nJ8G5xyTPco5fC6wz8NYGzKbQs1p6Glavrbp5nRNWTSO3HwYMLMJvdf72cMGZz20N9Ij7jVL/cQh99nwcrz+zOSf8mvh+3dpbdpNP1nUItRfKC429h2GWZpJ0opGgY3VIy0kct24mvsTuqrDgn0eg5Hw/C8si2t3gZLMZIytWDT8klTQ/6cvkhoj9+zdezT/SonKBlhGTC7JarclMsAhEypI0FiENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/w77MRygbscy0NnmcJvmSZr0/Ao1auHwJTNjz3qnvs=;
 b=ko6qKF7bdfJEl4goRPsqkszb4gXI01hTW3+oH1u4VAUxRc+e9jfZuMtYGBAMU2YN3ZxTPEURh9lm/LItKlFgngMVQ9fjQzD/5eGKLty6n60lL6+k5d/rV9s9rIU6PkvX5BtfHYFdfhom3GKMCFxzglbzKIA2sdeAE3raxpNGu9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 17 Feb
 2022 10:43:40 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e920:c950:24e1:1154]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e920:c950:24e1:1154%5]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 10:43:40 +0000
Message-ID: <ff3633eb-2ba1-567a-722d-cba44b3a6935@amd.com>
Date: Thu, 17 Feb 2022 11:43:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 1/2] drm/amdgpu: add debugfs for reset registers list
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 "Somalapuram, Amaranath" <asomalap@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220216094949.3169-1-Amaranath.Somalapuram@amd.com>
 <e9f1e95f-5aac-4a25-51f1-b971a8189d79@amd.com>
 <ed1103b1-835c-e56a-3118-17bd60f0f5f9@amd.com>
 <d531c825-332d-036d-c4b4-5e2cf39edb52@gmail.com>
 <94eeed88-69ad-5823-0505-dc86b36c4007@amd.com>
 <09a4d26f-04be-2a84-343a-32166d21afd1@amd.com>
 <b19700b6-3f68-1654-a07a-371351fe3652@amd.com>
 <dedecd79-ca3d-7b1c-595a-a6e5e56d2161@amd.com>
 <60b40c93-0cee-dab1-b032-b52fd23ebd8e@amd.com>
 <0129eb0b-39b4-befb-094b-c282d1841c6e@amd.com>
 <b8cb6a88-76ed-8326-5007-7eb066d1d692@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <b8cb6a88-76ed-8326-5007-7eb066d1d692@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0204.eurprd04.prod.outlook.com
 (2603:10a6:20b:2f3::29) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a46cec8-d627-4197-a6b4-08d9f2025c3c
X-MS-TrafficTypeDiagnostic: MN0PR12MB5785:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB57857DD4B9253500D3442ABB83369@MN0PR12MB5785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgdmnbtP5Yw0PyJRBgkTcuyK3pdG/M5862hzBaEv87qQZ+rFa7c45GZqWEseNYUfAtozTKRijOzTyE+14y0cuFN9DJpXPBL02dIGJfJshaX0vpKMZ501cWyMzwu/AheNJ83f85A8VvjrhFPYqsEjQLQbBvhDiBw3qqEnB+kwywu7IweN7h0Vw2Lyeq0M1Tp0syTFJffTAdqvrJmRdTHypHoEXO1humJ4PYbM8ME+IFIThSQ9GovtE41eVipxBDQk/ep6YqvKfSVKtU4EWd9FIsbzPfvQYGuEwe/PvYMDdNRFmrIwisRgojYMkKQJZSfXVMwgBsYqife/TVBXvtOvsf/wdJ/VBcKOE4nuH7JeilO4Tt2WOCzCURCDA7Ds2jh0ATrctQEGyYAuWOH+Y9oO2tqyFXK87ZKix/DuzzbarJoOqfVTEQpZepch4oCcCnyIsqPfcG6FLgh3C4mXmzyN0n4QG11rzWaSB+OGrij79VT0qwSi7/kDcBn8Tqopv3gvdbxtfgd+0TTDG4gS0TpiV/M3+aTxumEtKtk5d+mSyovck6yZQHoNn6EjasBEdOzB+town8oB2E2u3LNvVA4w0lPyay2lNWNBG1amzWo+uVn9fJma6mGoP5wLEMivLSRVsFqjIPg8MX/4GFZ+LXv9KC3beVOzpbjL5j/GVpPrmIhV12aPYgHuqIfygW4MQdCuuxcKj51PVtrPxL1zc+8Vr847YDbP45aSaGEuh12gjGaFgLEZRN+geT2rXwOnwH6/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(36756003)(4744005)(2906002)(6512007)(53546011)(6506007)(6666004)(4326008)(31696002)(6486002)(86362001)(508600001)(5660300002)(66476007)(316002)(31686004)(186003)(110136005)(66946007)(8676002)(2616005)(8936002)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm45QW9HWEhiV0VlL2ltbDh3WlBidGZXRjZTbnZnLzIwaW9raFBQOHptWWNw?=
 =?utf-8?B?Qkk5bTl0MmdFTEg1UnVGdDJjUWcwUW81MWU4QTFwRDNaR21UYlhWRkEyeWZo?=
 =?utf-8?B?TzY4aXl2eUpScVVzT2tjSVZ0c3NrV1lITTl2U1V2cE1sc3liMi9YVUJhNEZM?=
 =?utf-8?B?aWoxRHo2bzNQak5HVWNJTkE1TDNaWWEyWlRyMWE2WDgzSktLd0xGeFpoMzBQ?=
 =?utf-8?B?bU9jdzJsUmJZRlpGbm0zaHdlQ3B3KzJsYU5VTjV1MkcrQVVnbytEQmJ3bmlL?=
 =?utf-8?B?b1QyTktNWEVXT3dTUE5GZVN0NHNEZ3Mwa0sxRk1vVUZUS0xZZXE1WDkxZkox?=
 =?utf-8?B?K1hTL1l6TForL2RvbkxZM1lobWFJV1ZGS2gzNWU0SHJqbi9JZ2paZHdrcnhh?=
 =?utf-8?B?aC80cTJzM0hTMU1XT1IyUWtQSlgvUEY4T3hUNzVqK210Lyt4TDJMajFSS25E?=
 =?utf-8?B?ZkZHL1p1ekVTQWl2U3JDeFVXaXIwbjVPVzZsN0NxOHJ4UFpJYWExOXlIR0h4?=
 =?utf-8?B?cXJUaDI5Z2Uwc0NiVEg4NVRLS3JNVDd2Tk1uYmpTSXRacU9Vekd4TUpUUjdC?=
 =?utf-8?B?OEQ2NllqTmVjZE8wdGhIQlVsNG1RdkpBTXAwanFJTEd1dWpTMzZCL2xrUjVY?=
 =?utf-8?B?UTJsL2ZzUnVVaGJUekdpd3FLWHNVaE8yVkdhUXhpQTBLUmFNUnliU2JkWmZ4?=
 =?utf-8?B?WE50a2xPYlEvV05HZTlGTnNSY1kzQUN4SVRJZ1JqNEh3bzA1M1ZXcysvUDlm?=
 =?utf-8?B?RlZtVXdpMG8rV1hoMkpmeXQ3UnQ2ZFY1dzg0QU04Z0RpcUJiNzNUaVcwNVlP?=
 =?utf-8?B?aDQxRE1QKzdNVTJvVGFjMVRwbGhmcm96QWdGWVIxdmRlc2ZBODZ3c3NYcmw1?=
 =?utf-8?B?clViK3I3cUt4ZS9abDZSbXA3dW5OQnk1UzRlUGJtdVdFd2Ztb2RvSnhjRXd1?=
 =?utf-8?B?c2p5K3k0R2dZUitqZXhhdkRLOVlWR2wwaXdKUTVUUUR1T3NheE1OM0VrQnhY?=
 =?utf-8?B?UCsrek5OdmpzcXlZQjFDQmFwQURnN3pPeDBTbmlyNUhhVHU2US9FdmVMNHV0?=
 =?utf-8?B?a1FqaFFWSFZ1ZVkrV3VXaVJ4b1E2ZjVrdDBLUkZNMGR5Yis5dzNiblFONDlu?=
 =?utf-8?B?TU5kZDEyc0pLMnN0UG5KbXN4QVJXVDZ0Sld3TXFKWHA4N01Ua0JlM2VDVjI2?=
 =?utf-8?B?c1NRUE5Bd2tyOFZWTGZyQk56anFmTDVlc2pEdXFOeDhNeVliWnFUMkNubGIr?=
 =?utf-8?B?eEhzRkx3MU1rMnlwMTZ5ck1RU29IYks4emZKRHlnRlhHRzdNWi90dTllRERq?=
 =?utf-8?B?M3VDelhDZm0wNld5TTZaWEF5M3VsWUI2blZILzFKclZrZ01FVUFaM2ZVS2Yz?=
 =?utf-8?B?ZU1pVy9YeWx2R091ZEIzNVlLU0dnS0pHamFBL3ZPU2xEN25WbEsyODJaUzFD?=
 =?utf-8?B?ZHp0OVVnVk9NamxOWjZSYzJJb3RRYk5LQ05Wc1MrNzNZT3FLbEROcHpHZXE5?=
 =?utf-8?B?VXBGcVFKRWlkWTVaWGxSSTR5VktUbFprYm02aE8xSlNxN1B4YkhuY09leUJu?=
 =?utf-8?B?M3dmRDg2eGl2bEY1dE9WUitmRFFoY2xKTm5RU2taYnkramJDSC9YSm4yTFJE?=
 =?utf-8?B?NEhqZ0J2Sm1sQ01wZFR5eEFuSTJwWVQ0czlDcXhXVjNwaVZid2xIQllNRU1T?=
 =?utf-8?B?aDd1V05ldkZZcWZNKzBYRHBUa0UzS3BjM0xwZllnYmUzVVB1TFpuYlF4QXQz?=
 =?utf-8?B?bHlGeE5KVkVBR2xTQWhIZVNwbHZvWjRvQkpIQUNmVGErN1FzOFF0enRNOStz?=
 =?utf-8?B?d0l3K2RyRXY0U1F5T05Bc1ZuT1MzbDhoMkNWODllM1AzSHNTSm1hczVJbEdO?=
 =?utf-8?B?cGU2Mkt5QWhSY3hvTDVEVkpHUWx1S2xtdWp6MlZnaGU1NVdYR3ZMUlBROUgw?=
 =?utf-8?B?Q2tvdmxZK3ByQ3Z2SHdLQ0ozcGNpeTJsTEdva05BMTBxSEFrZGZ6SFFwbllO?=
 =?utf-8?B?Q3NVTCtiVnRVWGszR1R6OFRTaHVha3pNL1hhaittQndjZjFjM0V2a2FoZFVj?=
 =?utf-8?B?UGp6NUtaYjBtOFFDMjdOOUZTQy9CemVObGpZNDJOV1lHSkNFZk9qZU9lSTdB?=
 =?utf-8?B?RzloMnZ3ckVmNXFaYng2MTh5cGZoZGRXNUN1U2g5ZnVma1lWekJ6VDlzSG5a?=
 =?utf-8?Q?V8NjNNDRZTbtRS/+CfVLiDk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a46cec8-d627-4197-a6b4-08d9f2025c3c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 10:43:40.4095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KevuMIV+F3pFSkh1e0jSjJq/Q6/FnE8zaO9Lx9P/yd5liAVL5BfictSViXMr1XPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 17.02.22 um 11:09 schrieb Lazar, Lijo:
>
>
> On 2/17/2022 3:34 PM, Christian König wrote:
>>
>> [SNIP]
>
> Is this passed to core memory management by a component like drm or ttm?

The dependency comes from multiple directions. But yes, both DRM core as 
well as TTM have that restriction.

Additional to that we have dependencies through userptr etc...

>
> I thought reset was mainly internal/contained to device level as we 
> reset for multiple reasons and system as whole shouldn't be affected.

No, device reset is vital for core memory management. Otherwise the 
whole memory management concept wouldn't work.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.

