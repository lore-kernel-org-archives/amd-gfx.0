Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D597EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 16:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C571112C3A;
	Mon, 22 Apr 2024 16:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FSvqoyng";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2064.outbound.protection.outlook.com [40.107.212.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EDA112C3A
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 16:15:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTzQsgAT2db3poe0jWUoXK0oIx8k7EK2hdsECitExzDuWXt6owyO86xoqHZrA/6Pdyza7DkJCLeCiW3px4tc4+XC6s0h4czTC9Y4SVHxdPMXUXzwCkKIIJsT68XNWHJzFB1rP/1A0lXP78waCen57CVYIvdUfKb7IsC8pQD3gina5I+j5t9Kej1lRWG+hpsIEwrNyoShvIk5ieJP74vnYTUCZkOZaYnCKCxj/EQweMbpNx5H1vsDNmDnNh8G2AUX6ewYYsnhNOW6wu5Plke58zdkGbaO53eLYAenqcfwOm5n/RDkhhBrYEz3h22WDSY22cVEoVmrsge7HUgptNkI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kyibVCpTmwqqssGY+PfZKQlDakjUGlJKeFNJP1U3wU=;
 b=eOGlZNDciitLZylV1AJ+oisYNDSxfmtkahql7l8oof1UHSEXQPqlFk6v4s8S8NEuzqrXj5QR1ApRUUBMYE67u6niM6Vr4HPFpVNWAtzwyf6FZ7VPWkACm8/DYBicPSapwNTrRiFbspMgLVkPL+y2e/WgsaCuX1B3HlMSAnzxi65GuYAPAz6kxDjLayDmf2bDDtxsk28FWJd1pfEWr6lSdR2EJxViKbUdnlX0URltNrB4PxDfTq6mZIc4tLNHYbhSoQjG/5YW9R4b6T2m3vQjjZRjzpDzzXiKfsmT8uEGqqZPDKuh+Hzh+VbQIg6D+VLaZorTD8X3w3zLmDJn7aAWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kyibVCpTmwqqssGY+PfZKQlDakjUGlJKeFNJP1U3wU=;
 b=FSvqoyngSU3OxPz9Y/nnudKIojsNIx7Tu3wvYeUXspRDNZPOTronJXxegg/790X2jHL5gLS/+vMnRYFrRxxHcStwh0xkwbn1zK6YvgDjryK7Dzbnyk2Fut0y7bkSN48qSPZTrB5N/MxzvqIlhu674ExXhvvl2NRC+t/UpB9uWEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:15:39 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:15:39 +0000
Message-ID: <badc1650-d310-0ec0-7dd5-15ad304882d4@amd.com>
Date: Mon, 22 Apr 2024 12:15:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] drm/amdgpu: Handle sg size limit for contiguous
 allocation
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240422135725.11898-1-Philip.Yang@amd.com>
 <20240422135725.11898-3-Philip.Yang@amd.com>
 <60f0ec7b-52d4-4e8c-a58a-91824af9db5c@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <60f0ec7b-52d4-4e8c-a58a-91824af9db5c@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::21) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d24a35c-6ed6-4f1a-c81d-08dc62e77323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djdTV1JrZzFmQVlKMTFvVW1iTGhhOUNDZkIxN1luanIxRllDa0NKTjNEbmEz?=
 =?utf-8?B?a1JYMENYbE1GNFhJYnlBamRFTTFDNUZ4THRZaUVGVGluamVudFNKSHVHRDNn?=
 =?utf-8?B?Z20xR1UxNHlBcm9maFY4NklEVDFyMkI0QWEvamc3bmNtbkFyK3ltNHI3RW56?=
 =?utf-8?B?ZGRSRjhZSFROaEE2UnU4NlVoa3cwWGZOSUFTMWV6S2t5RlVxZmY3ZERDbVRo?=
 =?utf-8?B?Rzg4b0ErZHpIMmxZNG91cVRCeHNLa3A4bzhBVW55Sk5vVjdFV2ZVbWRsTFQ3?=
 =?utf-8?B?MlJWZE5GTEs4K09tZTd6aW1LRG40SEl2eXovS01ENXRseHoyTHZSN2JqQjFl?=
 =?utf-8?B?VDJFVGhoTGhnOGJwd2hBOHlvbTU1SEQxZ3Y0SEQ1anROaWhFSXVWYnlvOGxs?=
 =?utf-8?B?MGNGbktFNVd1ZXY4ck9BWE8zSzRDWTlvZ2JOU29tZHNBakJkWExvLzBhMTRX?=
 =?utf-8?B?WFY2MUdtTXBpVDFQWkxqNU1QYy9RT2E4ZHlhRWpBSU1PeWlud0JNeHhFRTAr?=
 =?utf-8?B?MG9CQVZ0WSsyYktCTlFjZ1VqZ01HOU5LLzFLcDd5N3lUSUxBeXZLMkdWYm16?=
 =?utf-8?B?c1JmZnhjN1RMUUQxSk5vRmZERHZoeDdRcnZBdko4cFZ5d0ZMODN2VlNSUmpj?=
 =?utf-8?B?N2R1M3piWkFlbU1GeHB2V2MrTWZheEVWOURsTThFdWlXeTNuaXV0RlhJUzc3?=
 =?utf-8?B?a2M4SHMyRTcrdnMzNHBWVjVLZDRWVU03L2o4anhWeURUNkZ1d3poc3N5TXp5?=
 =?utf-8?B?dHNBVFR5Wi85dXU1d2tueHVuNVdJVy9DRm5NL0ZtYnEzaytLUURteFhQLzY3?=
 =?utf-8?B?eE5TUWM0MXBydUFLZnVnUmM4WG1sK3dmR0d3UFJFeHdvQ1JHQlZNUmFGYjVM?=
 =?utf-8?B?VnV3aHBXS2ZRNnpDTFp4dHNtakpHRzl4V1FRWVp0SW5vc3BacWNZWDl6d2lV?=
 =?utf-8?B?V3h6bElMODdOVUZrR05iNXBwdjBSVkQ5VFNtZ0VGUXFndC95Q2RPa255bmIr?=
 =?utf-8?B?MGpkdHQ5K3BSZ3VKbk5ENm5ObGFsRG8yMVJsQU5QNEVSTWIweWZYTlYvb0pD?=
 =?utf-8?B?Znc3Z3NjM2ROSzZ0dk9EVjR0TlFRNkJUQ3dUTEtnU3pUU0lDTk1CcGsva2dv?=
 =?utf-8?B?YTVpODhteG90Nm5BYVdoalNxZlZxWTVMSmJXa3pJdjdVRWMzRTBYcUVodUU1?=
 =?utf-8?B?YnFCSVdGa0NzZlZ6aStzNVQ3SVhnekRSK1FWSUk5cG4vUnVHaFUycmhlS1ox?=
 =?utf-8?B?VlhvRWkrNHZJbVdNUTkwdVArOVNtSiswMkFENFNWOXY4UVBaSlZyKzkvZXBi?=
 =?utf-8?B?Y3lDL3ZXTmprZ3Y1UWZORXE0WTMweXF0Q0Fsb0h1anZQZzZNRXNMU2VDa3JW?=
 =?utf-8?B?cWMyd3o5SlkrR1lJQmZBdklFQ2JOUlZ1TCt3UmgzNVJWKzBxaTZZQzhsUmZq?=
 =?utf-8?B?MDZ3VFJ6YkpjTU91b0JLZm94T0dQSm41NXVQT3dCV2ZYZnAyeWdzUTNRUkhM?=
 =?utf-8?B?cVJDWjVpRndSU0MydTBkRTVIZXlGdDArYWZaOXdpb0VHOXlvMUtnSU5ZWEJx?=
 =?utf-8?B?T0dSY3NNYTNhVUhUYUp3aER3Q2RhaXRwOGRFSzh2VmpFOU52alhZcTNvUmJx?=
 =?utf-8?B?MnZ0U0ZuekFOckdCVkNwalFxTlpVUmlTRm5VUE9IbCsrTU40TURxWHZ6N1RY?=
 =?utf-8?B?cUF0N0N5UFNWenQybWcyNklNRG50NzRDektuaTI2M2lBMDJnd0hJTHNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q04xV05xT3BzbG5KN01CcGVWaXo5RmdlN1R2c3JBSHNPaktZdUY0aUwveWlY?=
 =?utf-8?B?Zk5yV1o5WjdUR0VGb3NQWDk2NXBTOVdnZWNQMCttSnNCa3N2dlNaNmpqVXgz?=
 =?utf-8?B?cVpQSXRLQitrMldWNnhVTGVhelJHVzkzNU8zZk8xUS9Ca3JqZ2lSaGoxRHB4?=
 =?utf-8?B?S2xaYzRZdnlEaC8xWWFRdnRwRSs1TmRoWkVKYVpRZFhhZWNvdGhLcW1SQ3hD?=
 =?utf-8?B?L0Q4OWhFeUphWnd0cWFZR3hDVVlkRlBma2t5OGpQNGRCRGhiNnd3a29RU1NU?=
 =?utf-8?B?NUNOSWM3ZEFNQWY2eklBemVPL0JxMlh0QVpnNnBTSVpHL2Zrd3ZYZ1A2cjdk?=
 =?utf-8?B?TnNUOFdIR1RyS0tjUU9ZVjlRSEUvc1EzQlVnUzVaRjRvUFlYTlNDOWh5MDJV?=
 =?utf-8?B?K1oxcEpudjB2QVRZaWRWVG5STFdUOWpqSVFSQXhqUXhCMURzU0dxckcvQXhj?=
 =?utf-8?B?N3dWRktnQmI3UitNOEY1WXhxZVlDUjVaUFZvTHcxcng4alNoL1QxWnpnZVZy?=
 =?utf-8?B?RktsOGJuS3crYXl1T1pqOWFYM2VwZDl0OVUzMytJT1FkdWZWaktRK1E3VHRh?=
 =?utf-8?B?azZ3VlI4TDVsWGlTNk0xOEM3WG5ySk1EUjc4ZUlhZU4vb2pTRzQzL3g1L0Ru?=
 =?utf-8?B?MnN1VGpqSHo4bVc5cStUMmVwMEVNNWcydUo5S2xsOFlVNE1ZU0dhQlJlSnJx?=
 =?utf-8?B?cVNKM2o2RitzNHNoWCsxNjRhdVJVaCtLclo2SGRGUjJQS2oxT3NIT3hiRFVE?=
 =?utf-8?B?Q0x5bzZmOGhEQVpOR0JLeWQ5dEIwUnFWNGF6SnJSRmZVNXlHM1puNTA1U1Zx?=
 =?utf-8?B?dXVHdWVSSzYwQVZkMDNKbldIQjBxM0s2MEFVYVFRTzdYdFdDSnlqb0dXM2Zq?=
 =?utf-8?B?Z0xFK0gyYmhjeFk0dzdwRkVuSWRybHZObmxRbktKQUFCL0JrZGovUnp2M0pP?=
 =?utf-8?B?U205eEgxV1NRNjZyNEt5MDhJVDZGbmxRL1oyQ2VWaWlWTndRYmVBVEFNemNE?=
 =?utf-8?B?ZmtkMVdCc0J0ZTZwMjdCa1B0dDZ0U2wrc0xPMFY5T3BnMkFvSEN5YUhLWURF?=
 =?utf-8?B?c2gyQytFdHFIYk45dnhUNkw0OWpSeVZlS041VXZac05zZVJpWHhoRjF5N3JH?=
 =?utf-8?B?SUE0SER3SVBUVzMwYjNJbUUxNG9UWEFqc1JWUDZkV2pNbVFZMlJDWGt2RDdw?=
 =?utf-8?B?YXNSL0grMm00UC9iOWcxTFJxeGVGQ3huRG5aMVYxWXdPc1FML2s2aXBOM3FV?=
 =?utf-8?B?TmJNaVVqOSszSVJXVWZEVTFBT3p3MDQ4Y1pnQ1pNc1YyTW90blVwa2xscXUz?=
 =?utf-8?B?Z2c5aFpvZnptRnltdml6WThvSTR1dGRaWWFyd0h2UmtUVklidlVucFRNMzF3?=
 =?utf-8?B?WnJJeFFTOUliMENCL0ZWQ0pjNTNWeGkyRzV5bWl4UmlLNURRQjRDZElPaVVv?=
 =?utf-8?B?NHQ2RS9DcXV5TVpuclVGV084Z2FVOTVqdlNrbnBnbmZzYzBlQkkwRUd1ZGwr?=
 =?utf-8?B?TWFSbmhTL3Jlekw5MGdsaDg3MlJETGhkTXlGQW14QkV4Z210S0MrWEFkMy9E?=
 =?utf-8?B?SitNQW55bGYxdFNRdnBxUmFhMFEyMThQZXJqTmhxUmNvd0FmOG5RZldUeXBP?=
 =?utf-8?B?ZDhHY1IwdmdUa3kzTjRJTEVxcE4zY2k1bFczSzhhYUQxVnREWEVaL2pFcGcw?=
 =?utf-8?B?YWFVMXQ5Q3F5M1NWSlBMd2xGVXVqWkxSQytzZ0pFa3hPdWNDd2V5ays2TzB5?=
 =?utf-8?B?bFp2bjM5cEVMWjY1N1hWTVh6cDQvR0c0dlczRVBsRzZUbUJ0TDdQclUrVDBr?=
 =?utf-8?B?L05wYkVvVVlSQTlzVmZtbmtYbytNeTVaRWppQ1hNMG9iL1AxUldUT25PVFYy?=
 =?utf-8?B?dnJqRExQSjY0UG9rSlJKNGh2cEF3SXdHeGcrV0t5RVJrdUd3Z205d2VkRE9X?=
 =?utf-8?B?OWlYd3RFK1VJekloSThtcFF1WUdBZDRlNkFjbXJQMm5ERmNzdnl3NHlvQnNq?=
 =?utf-8?B?VmhxbURRanhJRWZ5bzQrbUF4NUFKMGRVdHdlRmpMNVpCdERiWjhXWEZvNWhU?=
 =?utf-8?B?SmhBWWdnaElabFJFZmY4ZTdiOW14QW5hMVBuSkVEeTZsakljRHdvazdKUTVH?=
 =?utf-8?Q?wgco=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d24a35c-6ed6-4f1a-c81d-08dc62e77323
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 16:15:38.9677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkh9GqYBXfca5JH9kGMTxGh3xQZTO1KMeVKqK/SiflSgbghTfJu5w2V6uqIsUGgQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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
    <div class="moz-cite-prefix">On 2024-04-22 10:40, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:60f0ec7b-52d4-4e8c-a58a-91824af9db5c@amd.com">Am
      22.04.24 um 15:57 schrieb Philip Yang:
      <br>
      <blockquote type="cite">Define macro MAX_SG_SEGMENT_SIZE 2GB,
        because struct scatterlist length
        <br>
        is unsigned int, and some users of it cast to a signed int, so
        every
        <br>
        segment of sg table is limited to size 2GB maximum.
        <br>
        <br>
        For contiguous VRAM allocation, don't limit the max buddy block
        size in
        <br>
        order to get contiguous VRAM memory. To workaround the sg table
        segment
        <br>
        size limit, allocate multiple segments if contiguous size is
        bigger than
        <br>
        MAX_SG_SEGMENT_SIZE.
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 17
        ++++++++++++-----
        <br>
        &nbsp; 1 file changed, 12 insertions(+), 5 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        index 4be8b091099a..9fe56a21ef88 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        @@ -31,6 +31,8 @@
        <br>
        &nbsp; #include &quot;amdgpu_atomfirmware.h&quot;
        <br>
        &nbsp; #include &quot;atom.h&quot;
        <br>
        &nbsp; +#define MAX_SG_SEGMENT_SIZE&nbsp;&nbsp;&nbsp; (2UL &lt;&lt; 30)
        <br>
        +
        <br>
        &nbsp; struct amdgpu_vram_reservation {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 start;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 size;
        <br>
        @@ -532,8 +534,13 @@ static int amdgpu_vram_mgr_new(struct
        ttm_resource_manager *man,
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(min_block_size &lt; mm-&gt;chunk_size);
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations */
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, 2ULL &lt;&lt; 30);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = remaining_size;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Limit maximum size to 2GiB due to SG table
        limitations
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * for no contiguous allocation.
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size = min(remaining_size, MAX_SG_SEGMENT_SIZE);
        <br>
      </blockquote>
      <br>
      Well that doesn't make sense, either fix the creation of the sg
      tables or limit the segment size. Not both.
      <br>
    </blockquote>
    <p>yes, right. we don't need limit the segment size for
      non-contiguous allocation either as this is handled by
      min_block_size. I will send v4 patch to fix this. Then we could
      have another patch to remove the while loop, size and remaining
      size to simply the code in future.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:60f0ec7b-52d4-4e8c-a58a-91824af9db5c@amd.com">
      <br>
      <blockquote type="cite">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((size &gt;=
        (u64)pages_per_block &lt;&lt; PAGE_SHIFT) &amp;&amp;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(size &amp; (((u64)pages_per_block &lt;&lt;
        PAGE_SHIFT) - 1)))
        <br>
        @@ -675,7 +682,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(res, offset, length, &amp;cursor);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.remaining) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_entries++;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, cursor.size);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, min(cursor.size,
        MAX_SG_SEGMENT_SIZE));
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
        <br>
        @@ -695,7 +702,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_first(res, offset, length, &amp;cursor);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sgtable_sg((*sgt), sg, i) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t phys = cursor.start +
        adev-&gt;gmc.aper_base;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t size = cursor.size;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long size = min(cursor.size,
        MAX_SG_SEGMENT_SIZE);
        <br>
      </blockquote>
      <br>
      Please keep size_t here or use unsigned int, using unsigned long
      just looks like trying to hide the problem.
      <br>
      <br>
      And I wouldn't use a separate define but rather just INT_MAX
      instead.
      <br>
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t addr;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = dma_map_resource(dev, phys, size, dir,
        <br>
        @@ -708,7 +715,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_address(sg) = addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_len(sg) = size;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, cursor.size);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_res_next(&amp;cursor, size);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
