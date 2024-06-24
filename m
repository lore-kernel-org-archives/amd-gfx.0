Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4ACC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 16:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4090110E4DA;
	Mon, 24 Jun 2024 16:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TjCs7oRv";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3536710E4DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 16:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBBOHnx62khES1lvtpKPrh4EapreWCPf7FbUbtQ9PpUNhVmQq+ct1mbU6FzPSxnLUtPCYNUw1yuS7Jt4GLfM/enMwnnsZ0ZeEtLwvyQNR/D8CmSpX+w109qvWXQ6J9thwR0gs58yATFc/kiSXRYgctPa/W5WHQ7Gl9KixlerpCze65od1v+G9vwHaGgASNsjwzDvvBtGRq8nQHfMA2IxO8a6ZCObE2BFrKc+ooOZIf6O45gyFYqmMvr96a3TK/die257/GFgp9b2CoS+axqNXqTkFjRqIUwLmRV/q9Ti7B/z2vvq2Wzdy46TeMrl/48wId1Xo8f0cThdgqXK5TyMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLST1/W8X8NAKMgYgvtnJYqmdkSnO/rMwOaRjtl7bAw=;
 b=bqvsvoH0L/ggG0z6cSNRTmoOqchtByP8uRlIfW6kf9HBdPkJIwgXgRC6c4FlUls0SSkUu/DzxpXJHb0e9Sdhahh5Id0ZZ7ks7QaxqEWH+g7OqrMZZqOHdxJLZtCPv5fe05asPQ0o+SevTr+4BTs+bcLQg03vVcl8xWGbNI0y0gm00duOzZgwnmNVQ6QKWjSP0S2qp0Gr/0gYdg7NWw1W45vVD3g+8+MM4Fi0vI3HA9DyA2kW9TUPNugBWDLe6JnC6vZOA30SBdKmELg5Lksh+vR9Jj8pK6lNwZaib7ifC2j1yEyTKlxY4ZhnZZuGSuvwI/KdDQEGsgMc8dedN6TU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLST1/W8X8NAKMgYgvtnJYqmdkSnO/rMwOaRjtl7bAw=;
 b=TjCs7oRv0IvqCxeh+AaIgNiuf3KyFCKOYsA46+ScxdAEI5OxORP8zvKyggTxyk1NHsOYd5XZzI7xOK7Ln7Uunz+KgihzDXaFs4drmJEZUTdaGcUlPPUq51mQppiuK7fqpVaOMuVcKBN8RkjgFzcXMK1i9WNffjYr+Chj/Py7fWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 16:17:09 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:17:09 +0000
Message-ID: <4ba31ef6-951e-c891-efe8-dc97470d29e6@amd.com>
Date: Mon, 24 Jun 2024 12:17:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240621172823.168595-1-xiaogang.chen@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240621172823.168595-1-xiaogang.chen@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc9649b-bc7b-4792-e468-08dc9469194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REJrMTlhSGZGdHBxaCtHRGswSkIxeGl0R1Z2VDFFdnRjVHk1MVoxcmQwVVJJ?=
 =?utf-8?B?MEYrdEZ6WXBuZnFiUnhyRm9TS2U2YTcxMHp3T2k0L20xRTlpSHN6YTFpaWFG?=
 =?utf-8?B?a3Q0VVlUaDJKREhmazNPVi9UVEJPMnFuTm1rbElWWExqdHExanY4a0ljSlBn?=
 =?utf-8?B?em5QWVBBRHBlZlRnclpDcHZUVlhpaXpxd2UwRkxjcnRxTWc5aWlqSXJqbnhO?=
 =?utf-8?B?VHAzd29DQ2R4YW1QdEMycStCLzMzRUhaNVpJSjljWTdVUHpwbS9pbHhPQVdX?=
 =?utf-8?B?TCtVSVBGWXR5WE1ndzRUN0R1OURzQkNyWlF1NVp1REFQMlJwU2hCMzJUQzZJ?=
 =?utf-8?B?MTJYaSs4S1JtN3REQmV4VVRlRS85S0x6ZURMRGQxUy8zQzhxQkt5c3RkSnFB?=
 =?utf-8?B?V1gra3dkVHRZMnhtNmVKU3phZm9oN0drNDFBRzFjWlR2MmpqTjVEZjlBYmQ2?=
 =?utf-8?B?TktkbktDWHdZdWp2S3JRNnF0RTQ5MGVtMUJsVjgvOTEvcWJrTlhWV3c2eUNw?=
 =?utf-8?B?RUJSUERiTlUwekc1ODBaUnRMMmkrWmM2ZktxRUhXaW5NTVo5WXV6VkNacUls?=
 =?utf-8?B?aEJxcjBXN3o5ZG5OZ3BYZ0FOaU9OSy9veVkwTUM2ZXIwajdVYUZUdzRRUGsz?=
 =?utf-8?B?U2ZqSjZxeURabWgwM0tvSjV1ZC9QeE9zZEhJQkdRbVhSWHJIeVBBOTBqZGtk?=
 =?utf-8?B?VkIyMk9iWVYraEpOUFcxZXBseVZIaWFqbk03cmpVTFZnTnlIaFUrYkN4NXZu?=
 =?utf-8?B?SC8wWHpYN3Y2ejBIeG9ONVAzZHBVZU5hQzNzU3I0VVhidUdCQ3dFeDNaMGZL?=
 =?utf-8?B?ZjR1RktJSmZURXlqaStNQ2JXWC9EVEUrT05wbEw0RzRKUkE4Y2ZTOFlvY0dy?=
 =?utf-8?B?ZjR0TkU0WEZ2VWpxK2F3eW9JdFdOUzJadW9uM2lCWWhiRDZ5VVk3QitCZkcy?=
 =?utf-8?B?WlNPb1NMQUFnKy85NS9SaGNNRlBFTmp2UWFMV3FvR2hSdGFRd2MxTmNxUU94?=
 =?utf-8?B?bklZTlBLaGh5Z3hpRlZSN3k1clQxMXlHRndyaUJlaDlhRjBpT1B5ZjJwNXFE?=
 =?utf-8?B?RXlBT1hOSEp6MWxKdE5uSUpZYlljMmN5YStwTnJnaUdZbGx6dkRuSlZJaUor?=
 =?utf-8?B?b2FyM1B2aWdwUStDUEwrMDBGUkpwNlhLVzd5S25LM3dnVHkySExYL1V6NGVu?=
 =?utf-8?B?VTZFWXE4RklpSmU5WFhVRkZ4OWRkZ2JOUEFnVlc3ODNpUjhZNXUyQ3JCQy9m?=
 =?utf-8?B?ektjdUZiMG1MbW43aXpmKzVZL2ZuQ2VLOFhTU2N3aEZvNVMwdVpkSGUvb2ZT?=
 =?utf-8?B?TGJxUmRnK2JwcVc5NTZyZUw1QVVIelFLRmxlSjdvR2d2Q1JtU213djJsa2pq?=
 =?utf-8?B?Rks5OG1rOWI3cTE0c3FWbHl3VDJpM1o2WVFXL1p1encza0x0ckFDNVZKbGU4?=
 =?utf-8?B?STNVeHNrOC9qV0I0N05vRHNUa1I4UjcyNE9MZjhXOUYvclN6amdESkNXVTdK?=
 =?utf-8?B?cXdPUzZYY1YxVG9RN3ZaS0lVeHFKN3hhTWNyaVNhTXJvK0pqT2IwRllXOHZW?=
 =?utf-8?B?MFFnKyt6enNMUUhJeEtDbUg5akxCZER3T1ZDNUFoZXp0emlzNlBFbWFoNjVl?=
 =?utf-8?B?Tm4ySHRFcmw1NkpMZHVQOFB2VlUrV1hOYmoxY3BNRlRIU1p3OEc1Vk95eVB2?=
 =?utf-8?B?N0hvT0ZNaFdBdFE0NEZIRGdtL3V4TWh0RFJFdTFVOWlhajRqM2VqcVJyS3R2?=
 =?utf-8?Q?+W/y+BywJ2uMh8NKmb4V13EcJloslGweL4IiK2r?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjNNdmFzM3pJNWRQYUtyVE1Gb01DQWFrd01pMjNWRndmckRKRE5NSVozSXVB?=
 =?utf-8?B?MkVhR1VDTjczbFBWZTQ4d2FwVUZtVmY2UCtlTzQxNTRUTSsyL0dJcm5uUVZM?=
 =?utf-8?B?M2xKQTFOSlB5M2tNRnNyZk5OTEIweUR5V3I2M21kR1dldjIwdUFFZ1h4MmdZ?=
 =?utf-8?B?aGtibllXdzk1MlFta3JKbHU5aWVNM1hrb1ZRUzhRR05jdm9UUWlxRkNIdWNW?=
 =?utf-8?B?UndKTmRDVzhTVkg4ZWRmSWw0NnVab01HRTl4d3BpWmhmbnp4RFBkWEh2ZHh6?=
 =?utf-8?B?dVREa3pkZzl1OW8vK3Qxa2VlUFBEUHRwMVBOZnE5Q2xOK2NHcGdTYnZJaEJF?=
 =?utf-8?B?b2tHZnI2aHdTWnVLWEFFVVM3aXZ6aEV5b3dSeWR5RkJyQ3JXNGx5UWJvU1pS?=
 =?utf-8?B?aGhOemNCQVJRZWJNN0Z5MDNYQ29QSElUTjJZY1ZYR1VnUG9IdEdsLzRoU0lO?=
 =?utf-8?B?N3NRWmRRb0F1ODlMOUN3aEt6SSs0eEJyK1RhWkZKdDBqMDdFR3loSjVFejZY?=
 =?utf-8?B?eVpBMVoyajlNNWluNWRRMi9sYmNvZkFxditHcjM4UG5CVHZjOEpyZUlMOXZ3?=
 =?utf-8?B?ZlVaRXlMbzRCakNsUXZMNkJkU3ozZHRrbVh2OGxVaGRNSHl5Zy9KVmY2QnBp?=
 =?utf-8?B?TldRZTlKZkNHUVhtVEJIMU1qbFZIcEZ5RlpkaUpWeHZ2M3JnQ3NacG9NekZ3?=
 =?utf-8?B?OVZBSUN4bGMzODJVZHVaZWo5VGFiQ3N6RWpuTEpzbkxUeXA0MVJmSDRYQmVI?=
 =?utf-8?B?ZVZXKytXM0pFNTNNV2tldXl0Qm5TQlhHaDAyUWMvYklXTm1VM0VuZ2UzdVZv?=
 =?utf-8?B?bmNiKzB4Y0RzLzNKRXNLM3BTVlNDdnVqbS9hRXkvanpYb2RYUFVOVldwTWFR?=
 =?utf-8?B?Si92QzVxelJJMjZCZlJ1bUtUWUp3TkdRT21FS24vTUdQSHlmNE5kRnMrd2VU?=
 =?utf-8?B?RnErWWlLVUVaQ3ZCTklDTjZpYngxdFByMEU2MEZVVE1XSHBhR09Lb2VlZkYv?=
 =?utf-8?B?MU9XbTJHTS9ka2haN2xtUyswM2VPQVpwMC9nQ05vRDV2bUlyWVl4WkVBQy9F?=
 =?utf-8?B?ZmZ4YWxYK0FBSjZCQkpINUw2UjNMZkdXVFhmU3lsSmhPbFhrNzBtNDdObFNv?=
 =?utf-8?B?dUUyQi90cEhMd3N6bk00dGtNMWpkekhPYlN6UDZwbXpzOVEzaE5MejFndUQw?=
 =?utf-8?B?Y1o5QWU1M2QySS9zS29rZHpRTjlxYUFpUk41a2xiYzZrdTNuQzN4a1B2TGgr?=
 =?utf-8?B?OU1lVlBDRXRLWFVCSkZtbHhrbUhORWZSTTJLcTNwdkRjWTdoU1lmdHVVTlBz?=
 =?utf-8?B?T0wrT2JiNE9ZMVcyU1paV2JVbUs1OUNIa2lXSEk2c055MDdROTNiVDZHcVhi?=
 =?utf-8?B?Ky9Mc2NXZCtiUXk2TmUrdEh6QStoZTRPZjhMenpmVk96ME9YcVZHM05TdW4r?=
 =?utf-8?B?dFU2OWZUTlRMMHFKbENDemh3QmxDczRaVThhdGpBTGZKUDZCUXdxRWFxZkoy?=
 =?utf-8?B?RStMVi9hNEJ2L0dRSXpYTDdTV3hHcm1GWkZOZmlLOEpMQlY3UlpzT1Jqdmxt?=
 =?utf-8?B?eWhKMHoxVTRUL2Rnc3JONmFiWEc1WlRkUld4Z3dDVnBNL2hPcGlZZnNGZ2ZS?=
 =?utf-8?B?WFc3VDJSSWpHbDIreWsxNEJha2lycG1PSjRDdzJoZXZXM2ZnUXFJdjVvNHMv?=
 =?utf-8?B?MU12bEVjckFIRmc1WGhLQXNCaWFEYkJvZmcxaTF3eUVFekl0VWhlWFNQVnpj?=
 =?utf-8?B?enVid0xPZDRnTnljNi84LzIxVmRTRlA0aUxtQ3dMQ0l3YTRMeXcyaTVsYlFm?=
 =?utf-8?B?OGVxOTUwbldneTQ5Zi81ZVhxYTRicFVrZ3QxRFcxdWJsOE5BdExZam9sdlVH?=
 =?utf-8?B?eXdOVjNhc0Y4OHFQUVErSy8ranhzWVozd3hPZDJRdXo4WUhyeXk4cnRHdnpv?=
 =?utf-8?B?WWErMHozTWpic3doTHN2TlhUM1d1VFB0YU9xeHhiYXF2dldYaEt1TUtQR1Fj?=
 =?utf-8?B?OCs1aGV3NmgyV1JmYmxIdTlLOW1Qamp6alR6WXpaOGNwMzQwbWFhWDVBbDN2?=
 =?utf-8?B?Uzc5MFZBSWNWVFdkTS9abjk2c2RlbVA1bXVqT0lZRjlRTTc4QitvMEYzTGhN?=
 =?utf-8?Q?/kAc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc9649b-bc7b-4792-e468-08dc9469194e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:17:09.8402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UYrEaB4VgeTsdAiwF3nUv/h4ZSJ2244ugtId6NCV9+pkZ7F5SiE0oyBJtCWf7jT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-06-21 13:28, Xiaogang.Chen
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240621172823.168595-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com">&lt;xiaogang.chen@amd.com&gt;</a>

When user adds new vm range that has overlapping with existing svm pranges
current kfd clones new prange and remove existing pranges including all data
associate with it. It is not necessary. We can handle the overlapping on
existing pranges directly that would simplify kfd code. And, when remove a
existing prange the locks from it will get destroyed. This may cause issue if
code still use these locks. And locks from cloned prange do not inherit
context of locks that got removed.

This patch does not remove existing pranges or clone new pranges, keeps locks
of pranges alive.

Signed-off-by: Xiaogang Chen<a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 89 ++++------------------------
 1 file changed, 12 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..a8fcace6f9a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -904,23 +904,6 @@ svm_range_copy_array(void *psrc, size_t size, uint64_t num_elements,
 	return (void *)dst;
 }
 
-static int
-svm_range_copy_dma_addrs(struct svm_range *dst, struct svm_range *src)
-{
-	int i;
-
-	for (i = 0; i &lt; MAX_GPU_INSTANCE; i++) {
-		if (!src-&gt;dma_addr[i])
-			continue;
-		dst-&gt;dma_addr[i] = svm_range_copy_array(src-&gt;dma_addr[i],
-					sizeof(*src-&gt;dma_addr[i]), src-&gt;npages, 0, NULL);
-		if (!dst-&gt;dma_addr[i])
-			return -ENOMEM;
-	}
-
-	return 0;
-}
-
 static int
 svm_range_split_array(void *ppnew, void *ppold, size_t size,
 		      uint64_t old_start, uint64_t old_n,
@@ -1967,38 +1950,6 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	return r;
 }
 
-static struct svm_range *svm_range_clone(struct svm_range *old)
-{
-	struct svm_range *new;
-
-	new = svm_range_new(old-&gt;svms, old-&gt;start, old-&gt;last, false);
-	if (!new)
-		return NULL;
-	if (svm_range_copy_dma_addrs(new, old)) {
-		svm_range_free(new, false);
-		return NULL;
-	}
-	if (old-&gt;svm_bo) {
-		new-&gt;ttm_res = old-&gt;ttm_res;
-		new-&gt;offset = old-&gt;offset;
-		new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
-		spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
-		list_add(&amp;new-&gt;svm_bo_list, &amp;new-&gt;svm_bo-&gt;range_list);
-		spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
-	}
-	new-&gt;flags = old-&gt;flags;
-	new-&gt;preferred_loc = old-&gt;preferred_loc;
-	new-&gt;prefetch_loc = old-&gt;prefetch_loc;
-	new-&gt;actual_loc = old-&gt;actual_loc;
-	new-&gt;granularity = old-&gt;granularity;
-	new-&gt;mapped_to_gpu = old-&gt;mapped_to_gpu;
-	new-&gt;vram_pages = old-&gt;vram_pages;
-	bitmap_copy(new-&gt;bitmap_access, old-&gt;bitmap_access, MAX_GPU_INSTANCE);
-	bitmap_copy(new-&gt;bitmap_aip, old-&gt;bitmap_aip, MAX_GPU_INSTANCE);
-
-	return new;
-}
-
 void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 	uint64_t max_pages;
@@ -2057,7 +2008,6 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * @attrs: array of attributes
  * @update_list: output, the ranges need validate and update GPU mapping
  * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
  * @remap_list: output, remap unaligned svm ranges
  *
  * Check if the virtual address range has overlap with any existing ranges,
@@ -2082,7 +2032,7 @@ static int
 svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list, struct list_head *remap_list)
+	      struct list_head *remap_list)
 {
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &amp;p-&gt;svms;
@@ -2096,7 +2046,6 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
-	INIT_LIST_HEAD(remove_list);
 	INIT_LIST_HEAD(&amp;new_list);
 	INIT_LIST_HEAD(remap_list);
 
@@ -2117,20 +2066,11 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			/* nothing to do */
 		} else if (node-&gt;start &lt; start || node-&gt;last &gt; last) {
 			/* node intersects the update range and its attributes
-			 * will change. Clone and split it, apply updates only
+			 * will change. Split it, apply updates only
 			 * to the overlapping part
 			 */
-			struct svm_range *old = prange;
-
-			prange = svm_range_clone(old);
-			if (!prange) {
-				r = -ENOMEM;
-				goto out;
-			}
-
-			list_add(&amp;old-&gt;update_list, remove_list);
-			list_add(&amp;prange-&gt;list, insert_list);
-			list_add(&amp;prange-&gt;update_list, update_list);
+			list_move_tail(&amp;prange-&gt;list, insert_list);
+			list_move_tail(&amp;prange-&gt;update_list, update_list);</pre>
    </blockquote>
    <p>The main purpose to clone prange is for error handling rollback.
      If removing original prange from svms and update it on
      insert_list, how do you rollback to put prange back to svms after
      splitting prange error?</p>
    <p>We hold svms lock to access prange, so it is impossible to access
      prange after it is removed from svms.</p>
    <p>Regards,</p>
    <p>Philip&nbsp; </p>
    <blockquote type="cite" cite="mid:20240621172823.168595-1-xiaogang.chen@amd.com">
      <pre class="moz-quote-pre" wrap="">
 
 			if (node-&gt;start &lt; start) {
 				pr_debug(&quot;change old range start\n&quot;);
@@ -3533,7 +3473,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct amdkfd_process_info *process_info = p-&gt;kgd_process_info;
 	struct list_head update_list;
 	struct list_head insert_list;
-	struct list_head remove_list;
 	struct list_head remap_list;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3563,10 +3502,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 
 	mutex_lock(&amp;svms-&gt;lock);
-
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &amp;update_list,
-			  &amp;insert_list, &amp;remove_list, &amp;remap_list);
+			  &amp;insert_list, &amp;remap_list);
 	if (r) {
 		mutex_unlock(&amp;svms-&gt;lock);
 		mmap_write_unlock(mm);
@@ -3574,21 +3512,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 	/* Apply changes as a transaction */
 	list_for_each_entry_safe(prange, next, &amp;insert_list, list) {
-		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		/* prange can be new or old range, put it at svms-&gt;list */
+		list_move_tail(&amp;prange-&gt;list, &amp;prange-&gt;svms-&gt;list);
+		/* update prange at interval trees: svms-&gt;objects and
+		 * mm interval notifier tree
+		 */
+		svm_range_update_notifier_and_interval_tree(mm, prange);
 	}
+
 	list_for_each_entry(prange, &amp;update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &amp;update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
-	list_for_each_entry_safe(prange, next, &amp;remove_list, update_list) {
-		pr_debug(&quot;unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n&quot;,
-			 prange-&gt;svms, prange, prange-&gt;start,
-			 prange-&gt;last);
-		svm_range_unlink(prange);
-		svm_range_remove_notifier(prange);
-		svm_range_free(prange, false);
-	}
 
 	mmap_write_downgrade(mm);
 	/* Trigger migrations and revalidate and map to GPUs as needed. If
</pre>
    </blockquote>
  </body>
</html>
