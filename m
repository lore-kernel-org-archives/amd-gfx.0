Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB592CF6C16
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 09:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F4FC10E561;
	Wed,  7 Jan 2026 09:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pt6W+lZU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76C010E561
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 09:08:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=raZKY49phGx+O3ku8KeDE2h1IgIe2qX6uqVYiyyqxanZ6uhpnAA3vi8ln8h8ShcxHGixJ69wOHuhoP9I3ONXr8M1bePAP9IVpBH8jcaHapuSQBEQSF3PNWf5CSAnYrZVuzZkr2LnRazFMgk6h4SbKvMwqsny+ep+UxPoxx2wNeXjYytHQXH3u61ZwrFcPxIPJPETfGC37G+9pSUuqk2IqCysnaXyN9NQ5TU7cV/uqM7si5COuEM7QOwzmcijZC9MBGa3XPCrW3/uwjUuLYU4GVyZLcDmt5oIXRAem97+DJtPo6oVq48nVvNDmGJDrdnA6XJixFRIv/VdNEdG6Nquaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvfCdUndppwlao6dIHD2CnZ7QWUa5hS0UcCTMZ9p57g=;
 b=Gefceel+tYi8gkk2OYGRrA7UrNszmNrF4H5tynO23xXMGzIkFAPkzhBg7k3u+AJawIlOt+YVTcqirqarR8UuZNt6rWaF9sXjZcOxj9Dhcdvzl+qMdJK+hm3Inf+3XX00nidPISqoyhGyQ45Hhh/zpjEpeGqwEE9htAe3xKR9gC6DppMwDtYoIkTcMBaVCU6TG8sZfjnH8HWygLHb0oznVJ3nWkdL0qoFvgZlrZZyHSxqg0QBcOswkPHDXor04NFhXb4QUs66En5tiwnd/A1i/8xuY0x/m9ev+vyauWFuxPtOnKjVkWY1Au+aBVgrNZfYteI1jPwPMiKvOnovugYjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvfCdUndppwlao6dIHD2CnZ7QWUa5hS0UcCTMZ9p57g=;
 b=Pt6W+lZUSDzt4Vo4KFe75UdL58gP1z9Er+zp5Pbffbyzc+fFhdZcl5MOthopbfKMtlNGfUvZhnNLTEaxvUuu8R2OslTan1LNHA5ZpSqElBDohnR5Uc/4uYZPTKZ6ovrjEMkc71SGeDzNR0Nh7SPlkerT90xl+KjNMaIpIn5ZEgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 09:08:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:08:13 +0000
Message-ID: <0dc1ed39-d5d2-4f06-afe1-40d58c7eae75@amd.com>
Date: Wed, 7 Jan 2026 10:08:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/12] drm/amdgpu: Consolidate ctx put
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20251219134205.25450-1-tvrtko.ursulin@igalia.com>
 <20251219134205.25450-9-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251219134205.25450-9-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB4215:EE_
X-MS-Office365-Filtering-Correlation-Id: 6998e808-44d0-4cbd-72c6-08de4dcc4932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGg1bFIxczZqUjE2ZjZGLzA2VWZPejZXcGUrRmM1TnVUakZpdFJvUDYwTzFp?=
 =?utf-8?B?OU5VaDViSVE3TXJPUGhvQ01uTHhKUEdVK21ualA0dkVmaDZxalgxeXRBR2E2?=
 =?utf-8?B?VXE2Tktpa0V2U3dzVVhsM29STTJtSS9kNDJZTjdFTm1BbHFna2tIL2pwWHVl?=
 =?utf-8?B?YitDM2ZXZ2hDTzJ4QkQ3ZGIvd2UrNCsyYWwwMkpFeUlyZGQvYmU2ejFvYXN0?=
 =?utf-8?B?Vkd1REc1a2tMSGxHb3Q5elRKT2kzK3RaaE55ZzcwTjd3aHROV3VTeklNeUpL?=
 =?utf-8?B?MmdIUEZYV3RmQytuWGthcTdtZi9SOUFXS2hudlM5V1h0MjZnMUVHcStCNkYz?=
 =?utf-8?B?a255bThUVWd2NmNxUjdXMSsxdCszN1hIQ2xwTjAvalozckNRWHFkajVYQnNF?=
 =?utf-8?B?SVlwWFpZMDhyNHpXWjQyVTBkM0E2MHRJVHVxdDE0SWNnRTczQzVXNk9kUGNX?=
 =?utf-8?B?N0FuMXhpVVEydzNwQ2l1Ny9rbGM0ZExuWHpIL2pXeXJhMGxlNlhNZ3Jyb1JP?=
 =?utf-8?B?S0haVlJEbGxhVmpPQW9iRnNTSXdLVjc0R2l1TVNHV3l3d3pKNWg5azVsUTFJ?=
 =?utf-8?B?ejl6RFF6ZGdrUEhTNGhINWh6S0NrTnYxQTZubUlOVHB0aHFwS1YyeWlsVVJw?=
 =?utf-8?B?Q0hHV21nTFRCdGJheDAwOUFwL005Rjd0c1pvc2p4V2VDUmhpd0J4YjBSaVdR?=
 =?utf-8?B?bHE1VkM4QlFzdFRBM2UycXI4dWg2YjJOSk94YnBOK2cydHQ4dE4vNUJqTUVr?=
 =?utf-8?B?WmZ5RWc0T0RXaGpCWTliT1pxZm5pNTgwMTJrSU5NL25oNkdNZ2U3aGZsSWFP?=
 =?utf-8?B?SC9LMTZsREljRDFvS3dSNDRwdmI4K0JBRVRWcWxTMWRTUDByOWVyOEpkRHpX?=
 =?utf-8?B?ak55Mjd6KzMvUDVnU3I1bDdyOVBTdGxTTWgrc05VMXpHY04rTWlvcEVmMm5r?=
 =?utf-8?B?T0FwdGE3SzVJTGdUUlptTngwekJqTjg2WkVKMWFqWnpCRG9hWXhRc2E0Tlo3?=
 =?utf-8?B?ci9lYVkyamN0Y2c3ZGVsczY3SzlkSmFCTVVUc3FKVWFnbDhsWnJQcE84WXQ3?=
 =?utf-8?B?QnloSmFZQjFyOGh2dFN6UDgyNDZWUDhpdWgrMDArbVlDZ3FKRG01ZFR3R2dI?=
 =?utf-8?B?QmxrT0FrUURJSDUzbDIrU1kyV0c0RmJVZ1dRWmMvVzlpNTB4Q092SkFiY0JH?=
 =?utf-8?B?UUJmTjNLTU5ESDJuQzcycmR2WFRHTGluTmQwM21DaU5PaHo5dkdIK3NtRDEr?=
 =?utf-8?B?c01wWXJlZjRCNWFaT0wwY0xKemRoZ0xRbWllMmNBdXhYTTNUR1VJQXdFUU8r?=
 =?utf-8?B?by91L0F0WW9SM1lOazhCOHQvNjE1bW9LMjBWTkZKSHcxQmdoVUFoU3FTekVH?=
 =?utf-8?B?WVE3bWlVUklKTVNBdzI2V2swekhJTy9OZnN5L1Boa1V2RjVtR09xWHJlZXFi?=
 =?utf-8?B?OVNTQ29LNGg3cE9JWlVhcFRvRkNWaHM2ODJmQU9BM1JyaEp4czliSjBycHh6?=
 =?utf-8?B?Ky9VUFQ0eURFRXdwRDNhWE1yTm9mZnczTGJ0MVZaeVdMRmM0elNkdmhvaFFS?=
 =?utf-8?B?cW1oNHY4TnJOcUVPOHNVRURpRFRhZjZjUEFjbWR2UFBMZE5CREdQaGd5SUFm?=
 =?utf-8?B?TTV6bzZUWExjNDRKVmhydHlDUU1scFB6OUtITS9GTWpZMXA4dWVTbTNOSzN2?=
 =?utf-8?B?cUlUQjkvMHNqOVFGYklKQytxRlBCK2FwYUpDb0w1UHN2TldIMDYrSkpySHhQ?=
 =?utf-8?B?VER1Wjg2NmJISGdxVjk5c0VBcTR6YkpxamQyRE1pMEhXR1BINFNTb3NhRERE?=
 =?utf-8?B?aHdqUlppRFhpUHgrbUorVHUrUG1PTExjR1VIUUZQb2J3bUEvRkx1ZkRycXJX?=
 =?utf-8?B?OEsrTmd3Y0lraFBETDkvbzlNSVJxd3llWmkzbGozemUrcTdwV3FjektrMVlC?=
 =?utf-8?Q?pdKtnCF8x3ugAFn+qKm8QgFKkocvVY/H?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJkR2ZJTUNaMDJJeTlJUmh5amFGN1FaOEp3M1g5eHp0cmZ6TzdVUlMxdUk2?=
 =?utf-8?B?MTBOUlA2WnhyVnJSQkJieGpqU3EyU3ZueXVXZWdqZGZLbmxnY2tQcmZaR05C?=
 =?utf-8?B?SHZ1QlloZ2VGUnNabnErV1lvUGZkN1ZBUWNGcDBjMDFQUDFNTWN0elh4V0Qw?=
 =?utf-8?B?WFFYdlFXYTkvUXQ1QmJMUlJrNmg1eGZ6a0dnL3B2Qk5rOEdXTTh6N25LN3dM?=
 =?utf-8?B?dEFIN1lsbjhjSDlpRWYrM29KM0RiNFNKWWE5YmMzSUNKOWZqM1cvelJDRFo5?=
 =?utf-8?B?Q2RJeEtiaHArNmNWUDhKV2RFQnhPSlJkWnk5UVMwbC9NVFhFRFVZbW05UmRH?=
 =?utf-8?B?UnJ3MGJQc0h6OWtXbDJwQWNCVXQxZE84TkZoRHltU0h1NXd2VTc1Um83RFFx?=
 =?utf-8?B?dUkweUwxRmtsU1VBL3c0UXJQbHVST01rOXNPbEdjaEV1K1BtRUdMQmpvcGZM?=
 =?utf-8?B?ZnZMTkJFWjF1Y0NodENJMDR2cXZQYnE1RXJqZzJnZlhpYnZZZkIxNXhDTzZQ?=
 =?utf-8?B?aFZ5QWtsNnRoaGJWTHBXZUdVdmcyckUyVVJqZTlHTTNRRFFFY1NqQ1BoREdO?=
 =?utf-8?B?SktXTE5MeXY4ZklqcVY1d3RhWHgrNFkxaXNvb2tvd082NnMwUTBDRFlHZjd1?=
 =?utf-8?B?TUtrNWhSS0V1ZGFTcGxEbjU5Z0E2SS9JTFp6ZnZGRkNDeUtYTDRkZ3NmQnpD?=
 =?utf-8?B?Ymh1MFliaGoxbWV6bVZXREY0Ym5MUXhiT0hyWVU3UW8vSWExb2FWMzdpeDU2?=
 =?utf-8?B?K3ZSMDl2Z0NrVDloYm8zQlArdE5uRGlkenR4UXVnNUxvczd5K1F1L0pxMDlp?=
 =?utf-8?B?dklJTjNZS0wveHo0bktKb3NpSGxQZE1VLzdEK3U5WWdzL0QyVCt2c1d1NXVr?=
 =?utf-8?B?c0szZHZRdE5YaEs2VCtWV2UwbWhjY3BWa1hTZEI1YjErYUNrUkxBNFRJdkoz?=
 =?utf-8?B?WDh2emNRb0RldytyVGpZaFdKM3Q5Y1cyWjg3WS9HM2w5ZytqbTlmMHZBT2pj?=
 =?utf-8?B?MUhrZlEzVTdvU0dZaS8rbFFOWnFuMmhoMGRmZnNPc2ZCaVEwQjFqS3ZYaDZI?=
 =?utf-8?B?VVg2MDB1N05yWHBrRmpTR21ZZzlhTnJwM2VyNjVHM0p4S05zWlAxdWdEMEI0?=
 =?utf-8?B?ZDBFSjYxQ25tV1ZUM1BCLzN2T09uM2Z1a2t3UmNMMW9HOXYyVlY1OUJKQXRl?=
 =?utf-8?B?MEVnUFJMc2kwQXVXbWZ1Z3NSUnVIZXNJblJmejZKMXdHV1JkSTR0M2RlT0dY?=
 =?utf-8?B?NDlyVFFLSlJmdXRsTXlROVZjNVlWR1E0TmVVWkQ2TjZQMmhrc3RvYWpMY0lz?=
 =?utf-8?B?ZnpwZVdtUjROOElyWWVaYW1iY3BhSkRUV25jK1hJcU1JQ1V5TG0rVURWd1Ir?=
 =?utf-8?B?MTl3OEV5aWg4SzY4VlhYNlFNQjJSMXNROHQ0YkR3QWh2cFRoQit5RHltS21u?=
 =?utf-8?B?V3k1VVd6NnZvOCthbTl1emE0TmJEdGdmdE5GOTQyUU4wOHUrUXBncW8ySDI0?=
 =?utf-8?B?N0ltdnM2bnNoU3VieUR1cEY3YzJTS1JaVjVLTUNhZHB3OFkzWnBEeDdqUEpM?=
 =?utf-8?B?Z0F1NlBINWZXUXZYWXBWR1NWcThzRWtVY0owc2hZak5vWmJqVW5Ga29rOVN3?=
 =?utf-8?B?UUhRdkhnampDUUsxUVQ4eEpuZ2hTR0N1c0JoaFdVNDNhWEpodmduUklGZHZn?=
 =?utf-8?B?ejFmNDlYQ1I2UEo4U3kwNHlDdjBTVVViYTlmWGJkeXIzYUE3eGdGZTJRZzBa?=
 =?utf-8?B?WG5GS0UxS0pVZkFLeitLcXBYaUtQbktkNCsyR3dWOEdQZVJnUEZVcnhsOEQ5?=
 =?utf-8?B?VG1Gem5GVnZvQVphUVNFbHJEUjR3emk4dE9Hc0tuaUY2akdSMmdPS0N2UXh2?=
 =?utf-8?B?UlUwMEVITDVzeG53SGM2cGFWYmFZNUJ1MU5BTnFHOEVBRGxFd0lrZDR0RlVt?=
 =?utf-8?B?cW1USUZaT2tKYVE5S3lLQVloVU1vaFltbUM4Q0VuU2VZWld5R2RiSGFwQ0Nw?=
 =?utf-8?B?aGV6d29leXhlYTMwbGNsbUZXdzROc21IRjA1YllVa3RLTmx5SFRHajJmRUVD?=
 =?utf-8?B?L2RIWXJsWXdLWFh0UGVBc0Y2Q3cvRjJNT25zMFV3K2o3UmtTU3RXNTFJQXBh?=
 =?utf-8?B?VEdmSlp1aks5OHB2bldad01taTVVUWNZckZPc2ExSUM2VGkvdzdub05ZRXU1?=
 =?utf-8?B?L3BHZ3Nuc1ZSU1kxaVdFTXVXNjI4Q0YzR0lFMW1YdU4zKzZQVU5OUWRhMXJz?=
 =?utf-8?B?WUgrSHpBVFdSeVpENURjNFlOdi9KMWFtZnp0Y2cyUFdVSERBVDNzNWlLMFox?=
 =?utf-8?B?eDdsNDFDVHBqQnN4Zm1xbWFxVkd1cFIvaEZWQmozZ1F1QkZoTUlOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6998e808-44d0-4cbd-72c6-08de4dcc4932
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:08:13.1519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p66ZtCPxFDVetnRXfUNcRtUmzW0U+Lyqg4YNebCZWISMDvIZ/YzMkwiEY7L7V8ED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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

On 12/19/25 14:42, Tvrtko Ursulin wrote:
> Currently there are two flavours of the context reference count
> destructor:
> 
>  - amdgpu_ctx_do_release(), used from kref_put from places where the code
>    thinks context may have been used, or is in active use, and;
>  - amdgpu_ctx_fini(), used when code is sure context entities have already
>    been idled.
> 
> Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
> and destroyed the scheduler entities, we can consolidate the two into a
> single function.
> 
> Functional difference is that now drm_sched_entity_destroy() is called on
> context manager shutdown (file close), where previously it was
> drm_sched_entity_fini(). But the former is a superset of the latter, and
> during file close the flush method is also called, which calls
> drm_sched_entity_flush(), which is also called by
> drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
> used entity, or flush it twice, there is actually no functional change.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 103 +++++++-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   9 ++-
>  2 files changed, 38 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index dd1e562dbaed..f3d5a7180bda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -269,26 +269,6 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>  	return r;
>  }
>  
> -static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
> -				  struct amdgpu_ctx_entity *entity)
> -{
> -	ktime_t res = ns_to_ktime(0);
> -	int i;
> -
> -	if (!entity)
> -		return res;
> -
> -	for (i = 0; i < amdgpu_sched_jobs; ++i) {
> -		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
> -		dma_fence_put(entity->fences[i]);
> -	}
> -
> -	amdgpu_xcp_release_sched(adev, entity);
> -
> -	kfree(entity);
> -	return res;
> -}
> -
>  static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>  					u32 *stable_pstate)
>  {
> @@ -403,28 +383,47 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_fini(struct kref *ref)
> +void amdgpu_ctx_fini(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>  	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
>  	struct amdgpu_device *adev = mgr->adev;
> -	unsigned i, j, idx;
> +	int i, j, k;
>  
>  	if (!adev)
>  		return;
>  
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
> -			ktime_t spend;
> +			struct amdgpu_ctx_entity *entity = ctx->entities[i][j];
> +			ktime_t t = ns_to_ktime(0);
>  
> -			spend = amdgpu_ctx_fini_entity(adev, ctx->entities[i][j]);
> -			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
> +			if (!entity)
> +				continue;
> +
> +			drm_sched_entity_destroy(&entity->entity);
> +
> +			for (k = 0; k < amdgpu_sched_jobs; k++) {
> +				struct dma_fence *fence = entity->fences[k];
> +
> +				if (!fence)
> +					continue;
> +
> +				t = ktime_add(t, amdgpu_ctx_fence_time(fence));
> +				dma_fence_put(fence);
> +			}
> +
> +			amdgpu_xcp_release_sched(adev, entity);
> +
> +			kfree(entity);
> +
> +			atomic64_add(ktime_to_ns(t), &mgr->time_spend[i]);
>  		}
>  	}
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +	if (drm_dev_enter(adev_to_drm(adev), &i)) {
>  		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
> -		drm_dev_exit(idx);
> +		drm_dev_exit(i);

Please keep i and idx separate here.

Apart from that looks good to me.

Regards,
Christian.

>  	}
>  
>  	kfree(ctx);
> @@ -502,24 +501,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_do_release(struct kref *ref)
> -{
> -	struct amdgpu_ctx *ctx;
> -	u32 i, j;
> -
> -	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			if (!ctx->entities[i][j])
> -				continue;
> -
> -			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
> -		}
> -	}
> -
> -	amdgpu_ctx_fini(ref);
> -}
> -
>  static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
>  	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> @@ -527,8 +508,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  
>  	mutex_lock(&mgr->lock);
>  	ctx = idr_remove(&mgr->ctx_handles, id);
> -	if (ctx)
> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> +	amdgpu_ctx_put(ctx);
>  	mutex_unlock(&mgr->lock);
>  	return ctx ? 0 : -EINVAL;
>  }
> @@ -744,15 +724,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  	return ctx;
>  }
>  
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> -{
> -	if (ctx == NULL)
> -		return -EINVAL;
> -
> -	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> -	return 0;
> -}
> -
>  uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>  			      struct drm_sched_entity *entity,
>  			      struct dma_fence *fence)
> @@ -921,29 +892,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	uint32_t id;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	idr_for_each_entry(idp, ctx, id) {
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>  		if (kref_read(&ctx->refcount) != 1) {
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
>  			continue;
>  		}
>  
> -		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -				struct drm_sched_entity *entity;
> -
> -				if (!ctx->entities[i][j])
> -					continue;
> -
> -				entity = &ctx->entities[i][j]->entity;
> -				drm_sched_entity_fini(entity);
> -			}
> -		}
> -		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +		amdgpu_ctx_put(ctx);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index cf8d700a22fe..b1fa7fe74569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
>  extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>  
>  struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
> +
> +void amdgpu_ctx_fini(struct kref *kref);
> +
> +static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> +{
> +	if (ctx)
> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +}
>  
>  int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>  			  u32 ring, struct drm_sched_entity **entity);

