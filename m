Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538B5C021A1
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2025 14:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACFCE10E6DD;
	Tue, 11 Feb 2025 14:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gKbgedVz";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1691288647
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2025 14:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6BGP0cM60dLlZoybl8j2V61VtexFDoIDjWzh0cTt1lee3rNz6434bF+uH8LPYMLcebTVTNuAStaFkfnId3fSDRtxDFSX8ui2haEB4r3o++3LwpXXT3zFq6Q0JURBAG8Nh4am73eDwkQvw2ZPFV+/LdiVEt5m1TglHNvlQsYiifaWGyHTeBiEbw2umStkOTql7/M0D0z1TrIXmJe1g0B0WJXNzCHCEuuUAxJJ0QpgYMvOOg8fMjbru3om3CvEh19Zvo7n6FV1LEGhSnnFK6xPOsQ2eDkt1goVUcNFQh2KXmH2fSzoToKM5w9ebV5oPFjsmhAvGJ+MaPTgel2ImD1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzBYYe6h6RlpDUJ6wD+wqGeoVw3rBQkSnxKmZwjbr+U=;
 b=lXS4m/pDFo5iVqP58yK1TonIScoCx0wWH2LxnEhi1d0cpvb8oMjNht9MnO93J745YCVwrKfIlwPF4oArsOUOZkMdzu+pQIfKSXklsFstPJi3LOWKRm89a4mmqcBVGQTZe/IonbgbtzmrUp2fxDpOE6iGIn2qODB2zo5fuXwEI0J3yrnwjS/h9a1ytmefqKsPBEE4PRLCyGgVXTCY6Iyhu5H+dignIWFLd31tYrevPrYXdvOOyXcCPI3Dye9lXvBum8R8E3EKMAlzCx0CHqJxRbmmO/YnTZSBmC9qj/k/cfElPhvGQIWnnI3Z7BIhvWC/ycTxp2hy4JVR0n4pSNwkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzBYYe6h6RlpDUJ6wD+wqGeoVw3rBQkSnxKmZwjbr+U=;
 b=gKbgedVzDSGMtwKmsFyKIaws4zMtvMHorzN9/TD1L7d4AqW8V4B7XimDd3ML+K6bGmDALJE0MTueGoDb6LN7Kr1mwDRHIXIYE7kHJw75ZKHTMFN8xnfso7uaI4ErlRHdr5SbE5jh3Cr6UTrMWAgdb0Pt5ZpjZTcCwNsCpDWZ4sI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 14:53:16 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 14:53:16 +0000
Message-ID: <19a6c369-bc68-e280-0dc2-3015de5c20b5@amd.com>
Date: Tue, 11 Feb 2025 09:53:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Unlocked unmap only clear page table leaves
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, emily.deng@amd.com
References: <20250114145314.4633-1-Philip.Yang@amd.com>
 <f5f41f09-b62d-495f-9339-0c9dc6535bf8@amd.com>
 <35670d39-0f91-29ab-e369-6e45b000d486@amd.com>
 <1d6c89dc-f032-4796-a038-c9e897e7bf1c@gmail.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <1d6c89dc-f032-4796-a038-c9e897e7bf1c@gmail.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0371.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c34f500-4979-41cd-4603-08dd4aabd0b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1l0RENLZ3hBV2N6cEJEaC8vUjM2RW1JUWV0M0tpbzNPYlMwUUtjTVRZbFZX?=
 =?utf-8?B?ZkZFYndXMWF1SDV6SjQ1aUZuT3dVWlJsc1oremZzenkrcHloZ2R0UkFwLytp?=
 =?utf-8?B?QVVvQy8vbzl6Qlcxd0YraWpLRHBmQVNkTk5CNE9Uamt6U2tHU2ZLNnhVOXk3?=
 =?utf-8?B?b24xbGgxbnh2OFRuVGdHeFE3TGx5d1p5WVNGUlZZcXZOOXBmUHBJNU1zbzFp?=
 =?utf-8?B?ZmtjVnU1VjByL1JiVS9ZM2I3OEdhMkp3UU13eXM5N3JZajhPeFFONUpkQUJv?=
 =?utf-8?B?UHhXLzM5YlF4NnhCcXBYVHBsb1MxZnVJS2F4cHZETzFwL0VOQnhiOVlVZ1NR?=
 =?utf-8?B?d0FFNXg3cndaOGp0bmUzayt2MGxGWGZNL0pkcjRjZlV1dnMwd21nYWhPaVNo?=
 =?utf-8?B?TnMyd0pmYkZ3UUp2TUdZeHl5RDFIdWdlZW1NaUE4TDlYejdZd3dyRmpwbmJ5?=
 =?utf-8?B?SXZKaU1idkF5a3ZRcEptUURpNFh4Q05ZYnhtS21CbHhETm1id2dUNWJTTWhI?=
 =?utf-8?B?c2s5bk5nY243cWxBUkRzTGRZbG1sdDVCdTluRGF0Q21TejNUNEZtMzI3dzJB?=
 =?utf-8?B?QjB5OURYalNJV1l6ZzZtYWdQb2VnZ2duY1hWaTczLzJLRFYvWlNNSnlYaGRD?=
 =?utf-8?B?NURRUGtZSmJJK2E5dW11cEJtUWdHUUs3Wi9IeHA1bGplaHZicExmQmJ4Znc1?=
 =?utf-8?B?NDl6S3gzUWFiVTdGZ3dwL3NyeHZCOWRSdDgyN1VKOFhzcWdpMlhpU1pkMFIr?=
 =?utf-8?B?a0FEWWdHbnBHa0hCc2UwSC8xb2RiL003UmxISkc0K0o4ak56N0pEWlAyOTQr?=
 =?utf-8?B?V1VtK1JONTc1MzAyRzBBSWxFL01INEs2cTY5UW00UVhoaUJaaUVuTW1pSGNB?=
 =?utf-8?B?NHAyeDlXUmV2QXZOSUp6OU1oM3JENy9ib0J1U1prS0NRRzZKZUtXbDVhRm1Z?=
 =?utf-8?B?ZDM3bGMra0lGZXdPZEdPNzlqelRTS0orZkhSbThmd2FRV2hoWjBmR2xiZTAy?=
 =?utf-8?B?NlRMYmZFT2FlZVJEaW9aVmJXMmQxLzNlT1Q5a1lSbUpzak5Gb1lLSmZKSk1l?=
 =?utf-8?B?bTA4VTl1UEluM2ZTZ24xM2lmbWpGVHhnejVMOUNiRWcybWUwOTUyWE1zVmF5?=
 =?utf-8?B?bGs1dW4xRzIreDg5WTBNakhjb0tJZVcydjA2YXdTWDBEZTBWMnFLaFQyUG5V?=
 =?utf-8?B?Q2MyU0s3QS92V0lGV3BRZjk5UElRV1hkYUVwZ2lrcGVIdWg3L1NKWnArUWk3?=
 =?utf-8?B?bWt5MmdhY3Y4WjdhVk0raXo1d0xvcU1Kb2R2QnhIb0ppamFYSzR2UWRuaWsy?=
 =?utf-8?B?NHlLMFZwdFZlUTF1UlJ3TTFFVngwRVJBOHVVSVBiNnNTbENvQkljMGM5M1B1?=
 =?utf-8?B?MCtYSjdidnJBY0VLZHNRS1o3ZDVSL0lqMVpJazI1MGh1OVIvbitiZ0Nuem5k?=
 =?utf-8?B?a2twUTBGMDN6UVJlSGdJQ1NlVzhkT1gyVHdRTVc0SENFWmVrRjFtdjRnaWlC?=
 =?utf-8?B?Rnp3dmRkaVcydlFiZUIrN3hFSjJlaGp5ZkwyR3N6akd4SEFmQ2ZuOFpidGlJ?=
 =?utf-8?B?NVF0U0VmSjdzNzNFNFhrRUUrcGViR3ZHQ09hT3d5c1VRcjU3am5uUTVQYUw5?=
 =?utf-8?B?ZkM2OVBwWStrOEZ0TXNqRFcwUUJLc2lmd2dKVGRDTS9LZmpQUnZBWEtjMmhP?=
 =?utf-8?B?d3lESjV4d3BndnpieGFiUzdyZ0F6cE8xYkU2NWp0SkZQYTM1cjhXaGJIY1NH?=
 =?utf-8?B?aXhzWjBhdjV2Q2cwbVlFdGU1M2FGQmVFS2h0R3NHM3o1OFh0V1dJbU9EWVpr?=
 =?utf-8?B?d0pDSzYzY3h6NjJwR2FTVFpqK01UODJVSTBpMFN1RGpNRStvcGlWY0VqV3Ns?=
 =?utf-8?Q?1s6W1Qf7gyBN7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1c1UWpBT1dhL3JOVno3cFZzYzJjY2toSTNTRHZ4NEJoUEs0bFdxeG9TUWow?=
 =?utf-8?B?SXNHL2NPTmorajVoU2xYYm4zN2xzVXpsTE5wS2w4TitxZkNIUVNtdWFmblN4?=
 =?utf-8?B?RUdpTVFXdkJWV1cySVdCd3JOY3I5enBtZGIyVnlmTFZabEFTZWxPTWlBVHA4?=
 =?utf-8?B?QTdmaVB1T1EyRTNCcGJwZ29Qcng3cittR2VITHR6SGZ3V245bDdvaWpWYWI0?=
 =?utf-8?B?MzI5dTJsb2pTRGMwVFVyaEQzZkZDT2Q2U081VUpoT3hudzNHZ0trMHRDT2I5?=
 =?utf-8?B?NDB1NWl1bDVNQVVLYTBPek0xNllWdkxvTko0azVlREFzVmhpZnE2Uzk3U0Ja?=
 =?utf-8?B?Y1hOU3MwM3gxSzY1b1B6TE1IeGpjOFZuVXRvOURIeXUzYUZYR1pSa3NrL3NT?=
 =?utf-8?B?VGJqclFnNWJYTThtOXFJS1plZythWXNwT1RiekNiQUk3UitnNVgxd2N6M2o5?=
 =?utf-8?B?WGtxanA4ZWdqb0txY29BeWJzM0JYaGRJU3c4U1M0MG5CN25VZU5qVDhxTjV6?=
 =?utf-8?B?SEVtS2hMVWxrcXJqL0pMSm9MTkl0cXAvUkIyOHRxbnliQWpCU1R4blNselN0?=
 =?utf-8?B?UkRZMVYva25xSjEzenlhbklZZWVxNmxGaGFreTdVWnF6RG0wYm1UTFVIa2ZW?=
 =?utf-8?B?TldQdFB6K2lYbTRrY1Y3QlIxLzVUSGhhS2RzaEhaYS9ROUdUeTJ0R2hWRkpM?=
 =?utf-8?B?ZFJ5VlR0eDdQWUlPUEZLekc3Zi9TSUtGR0xFY05HOGlyT2NwRUZCSXNmY1Zr?=
 =?utf-8?B?VU5VQjBCUTlNUmdHdWZhQndhTVQxZXBnajN0U09SRmNiSGR5RllRbk9wZlJm?=
 =?utf-8?B?UDF3Q1FpZXRXV2VVTm1EU0JEeE9uRU8xbXdhb3R0VDdlZEE0a3NocTVyclRz?=
 =?utf-8?B?d1hhaVZtVDRGWllhdW5tU1NocktNbEFoNHV1V21Ccit0c0pzY1JodFpiSGpi?=
 =?utf-8?B?OFltbGMyY3ZEZGM5MGovZ2Q0N3kxeisxWnpmbFlNMGdzMlp4U256aktUREFy?=
 =?utf-8?B?MXU3UVRyUCtjaldNVXd4dk1IZ2dabTVZNnNkV2I3MnVqZ01GM1RaZ0hhN2JB?=
 =?utf-8?B?TVllZ1M3a2ZxNFN1YmZOYzJFVzNHQTVwblcya3JOWHQxZGZaTU9PbU51Njdi?=
 =?utf-8?B?V2VaQ2FtaUlURnh2akM3QWgvdk1xTU00dHdGYlVmaUtFQjBIV1RDZ3IxUEJZ?=
 =?utf-8?B?RVF3bkc0cnBDRjZ3aDN1d29xdlFYMUtKbTlLblpkOXZWT3Bmc2d0SGhaWVRO?=
 =?utf-8?B?RFlYRnp5SmIxVzNnY1cyUXNFZVk0NmM4OW1NbkoyY1poZXVnbjF0emtCdWVh?=
 =?utf-8?B?YThHenp2bnprTzVRWng1aENqa2RLSWg0UFNTMUg3TFRySVN4ZWpIQlpVR2Uz?=
 =?utf-8?B?SEdrNm4zNkxrbllXTytGUU5seWdmZ1pZM1lCbGVzT1V6SjA1UEZKQzdmUHkw?=
 =?utf-8?B?TEdzTnh2SDFMUG95dVhjSWtqelJzNjFMWkJYMFdEYTBrTng0UnpXWTY4dXFv?=
 =?utf-8?B?dC84bHZZbHIwMEhoSnVIb0ZNM2hsY0JTTTU5NmcyUEw2SzNaV09zMnRjM3hX?=
 =?utf-8?B?TzhweDN5YUFLZ1VMdHBGdVArbnl4TkVsNG90QWkwb1kveHdkUjZQQnkrK0po?=
 =?utf-8?B?clR1dnlwalQ5Mmo2NS9MMnZkZVp6WHQxZkMrTWZPY3k0aEpDRlpWNVZ0c2ZH?=
 =?utf-8?B?dGV0cUNLdnhFQmJTUkYzVWpyTWhqUUhZNXd1NG5qZTlwUVduZmExajRobXRx?=
 =?utf-8?B?d1lBRTBuVUJmR3RNVlNkZSsvT2dBQnRCc0RwVUwyUTdIZlEvUVpsSEw3MElT?=
 =?utf-8?B?L1N5eWE3dmQrNHMrTDRwRDV6R0ZtZUNWSXY0ZUdFc1lrY3dUeDZuTkZacjBF?=
 =?utf-8?B?TE94dEVXTEdZYVVScVhyamROTWc2Vk84NmZLMmY2MFV1TEE2UHV2M0x4WWxK?=
 =?utf-8?B?OCtubWhveUh4SDIyV3RjeUVqenF2SE5DcW11YklPd1Q0MU5wbi93aCszMmdG?=
 =?utf-8?B?YVN5SE1mUnhQOGx3b04rQVJvMFBYTTJTRnRDbk9Ub2xOUmo4Snc4OHVOWGU3?=
 =?utf-8?B?YitSTlQrK3ZWSjV0TDFrV0xUZGV0MUNTWktqWktyR3VtWTNLNGZmQkc3TVFz?=
 =?utf-8?Q?ouQVwtxdVVk+UlqOayFPSe5YQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c34f500-4979-41cd-4603-08dd4aabd0b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:53:15.9973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhmJbV5275HZtIzha/iuX3uBrUYdsRPswnpz6ZHhcl9FQXLarR3v08JEBqSsPCD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
    <div class="moz-cite-prefix">On 2025-02-11 05:34, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:1d6c89dc-f032-4796-a038-c9e897e7bf1c@gmail.com">
      <br>
      <br>
      Am 20.01.25 um 16:59 schrieb Philip Yang:
      <br>
      <blockquote type="cite">
        <br>
        <br>
        On 2025-01-15 06:01, Christian König wrote:
        <br>
        <blockquote type="cite">Am 14.01.25 um 15:53 schrieb Philip
          Yang:
          <br>
          <blockquote type="cite">SVM migration unmap pages from GPU and
            then update mapping to GPU to
            <br>
            recover page fault. Currently unmap clears the PDE entry for
            range
            <br>
            length &gt;= huge page and free PTB bo, update mapping to
            alloc new PT bo.
            <br>
            There is race bug that the freed entry bo maybe still on the
            pt_free
            <br>
            list, reused when updating mapping and then freed, leave
            invalid PDE
            <br>
            entry and cause GPU page fault.
            <br>
            <br>
            By setting the update to clear only one PDE entry or clear
            PTB, to
            <br>
            avoid unmap to free PTE bo. This fixes the race bug and
            improve the
            <br>
            unmap and map to GPU performance. Update mapping to huge
            page will
            <br>
            still free the PTB bo.
            <br>
            <br>
            With this change, the vm-&gt;pt_freed list and work is not
            needed. Add
            <br>
            WARN_ON(unlocked) in amdgpu_vm_pt_free_dfs to catch if unmap
            to free the
            <br>
            PTB.
            <br>
            <br>
            Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
            <br>
            ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h&nbsp;&nbsp;&nbsp; |&nbsp; 4 ---
            <br>
            &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 43
            +++++++----------------
            <br>
            &nbsp; 3 files changed, 13 insertions(+), 38 deletions(-)
            <br>
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            index c9c48b782ec1..48b2c0b3b315 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            <br>
            @@ -2440,8 +2440,6 @@ int amdgpu_vm_init(struct
            amdgpu_device *adev, struct amdgpu_vm *vm,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;vm-&gt;status_lock);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;freed);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;done);
            <br>
            -&nbsp;&nbsp;&nbsp; INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp; INIT_WORK(&amp;vm-&gt;pt_free_work,
            amdgpu_vm_pt_free_work);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_KFIFO(vm-&gt;faults);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = amdgpu_vm_init_entities(adev, vm);
            <br>
            @@ -2613,8 +2611,6 @@ void amdgpu_vm_fini(struct
            amdgpu_device *adev, struct amdgpu_vm *vm)
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; flush_work(&amp;vm-&gt;pt_free_work);
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; root = amdgpu_bo_ref(vm-&gt;root.bo);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(root, true);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_put_task_info(vm-&gt;task_info);
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            index 5d119ac26c4f..160889e5e64d 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
            <br>
            @@ -369,10 +369,6 @@ struct amdgpu_vm {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* BOs which are invalidated, has been updated in the
            PTs */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; done;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; /* PT BOs scheduled to free and fill with zero if
            vm_resv is not hold */
            <br>
            -&nbsp;&nbsp;&nbsp; struct list_head&nbsp;&nbsp;&nbsp; pt_freed;
            <br>
            -&nbsp;&nbsp;&nbsp; struct work_struct&nbsp;&nbsp;&nbsp; pt_free_work;
            <br>
            -
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* contains the page directory */
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base&nbsp;&nbsp;&nbsp;&nbsp; root;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence&nbsp;&nbsp;&nbsp; *last_update;
            <br>
            diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            index f78a0434a48f..54ae0e9bc6d7 100644
            <br>
            --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
            <br>
            @@ -546,27 +546,6 @@ static void amdgpu_vm_pt_free(struct
            amdgpu_vm_bo_base *entry)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_unref(&amp;entry-&gt;bo);
            <br>
            &nbsp; }
            <br>
            &nbsp; -void amdgpu_vm_pt_free_work(struct work_struct *work)
            <br>
            -{
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm;
            <br>
            -&nbsp;&nbsp;&nbsp; LIST_HEAD(pt_freed);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; vm = container_of(work, struct amdgpu_vm,
            pt_free_work);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp; list_splice_init(&amp;vm-&gt;pt_freed, &amp;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; /* flush_work in amdgpu_vm_fini ensure vm-&gt;root.bo
            is valid. */
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_bo_reserve(vm-&gt;root.bo, true);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next, &amp;pt_freed,
            vm_status)
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            -
            <br>
            -&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(vm-&gt;root.bo);
            <br>
            -}
            <br>
            -
            <br>
            &nbsp; /**
            <br>
            &nbsp;&nbsp; * amdgpu_vm_pt_free_list - free PD/PT levels
            <br>
            &nbsp;&nbsp; *
            <br>
            @@ -579,19 +558,15 @@ void amdgpu_vm_pt_free_list(struct
            amdgpu_device *adev,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_update_params *params)
            <br>
            &nbsp; {
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm_bo_base *entry, *next;
            <br>
            -&nbsp;&nbsp;&nbsp; struct amdgpu_vm *vm = params-&gt;vm;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool unlocked = params-&gt;unlocked;
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (list_empty(&amp;params-&gt;tlb_flush_waitlist))
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            &nbsp; -&nbsp;&nbsp;&nbsp; if (unlocked) {
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            list_splice_init(&amp;params-&gt;tlb_flush_waitlist,
            &amp;vm-&gt;pt_freed);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;vm-&gt;status_lock);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; schedule_work(&amp;vm-&gt;pt_free_work);
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
            <br>
            -&nbsp;&nbsp;&nbsp; }
            <br>
            +&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; * unlocked unmap clear page table leaves, warning to
            free the page entry.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp; WARN_ON(unlocked);
            <br>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_for_each_entry_safe(entry, next,
            &amp;params-&gt;tlb_flush_waitlist, vm_status)
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_free(entry);
            <br>
            @@ -899,7 +874,15 @@ int amdgpu_vm_ptes_update(struct
            amdgpu_vm_update_params *params,
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; incr = (uint64_t)AMDGPU_GPU_PAGE_SIZE &lt;&lt;
            shift;
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask = amdgpu_vm_pt_entries_mask(adev,
            cursor.level);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pe_start = ((cursor.pfn &gt;&gt; shift) &amp;
            mask) * 8;
            <br>
            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = ((uint64_t)mask + 1) &lt;&lt; shift;
            <br>
            +
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cursor.level &lt; AMDGPU_VM_PTB &amp;&amp;
            params-&gt;unlocked)
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * MMU notifier callback unlocked unmap huge
            page, leave is PDE entry,
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * only clear one entry. Next entry search
            again for PDE or PTE leave.
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = 1ULL &lt;&lt; shift;
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else
            <br>
            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = ((uint64_t)mask + 1) &lt;&lt;
            shift;
            <br>
          </blockquote>
          <br>
          That here looks to much like a hack for my taste. entry_end
          basically denotes the end of the pages tables and not the
          updated region.
          <br>
        </blockquote>
        yes, agree.
        <br>
      </blockquote>
      <br>
      After going back and forth over the different solution we found
      that we do need this hack for now.
      <br>
      <br>
      There is basically no other solution than to update one entry at a
      time without introducing a new function to do this.
      <br>
      <br>
      So feel free to add Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a> to this patch here, but please
      look into cleaning that up as soon as possible.
      <br>
    </blockquote>
    <p>Thanks for the review, I will merge this in to solve the issue
      for now, and implement new unlocked unmap function from scratch as
      you suggested to cleanup this and improve the performance.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:1d6c89dc-f032-4796-a038-c9e897e7bf1c@gmail.com">
      <br>
      Thanks,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
          We already set frag_end to this here:
          <br>
          <br>
          frag_end = max(frag_end, ALIGN(frag_start + 1, 1ULL &lt;&lt;
          shift));
          <br>
        </blockquote>
        <br>
        Here seems the root cause, for example, unmapping frag_start is
        8MB aligned address, frag_end is frag_start + 8MB, but for
        unlocked update we want to do page walk again after unmapping
        2MB.
        <br>
        <br>
        Also the max(....) seems meaningless, as frag_end is always
        &gt;= frag_start + 1, this can be changed to
        <br>
        <br>
        if (params-&gt;unlocked)
        <br>
        <br>
        &nbsp;&nbsp; frag_end = frag_start + 1;
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Which basically means that we should update just one entry at
          the time and then walk the page tables again.
          <br>
          <br>
          The issue is just that we immediately calculate a new fragment
          after each update:
          <br>
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag_start &gt;= frag_end) {
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* figure out the next
          fragment */
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pte_fragment(params,
          frag_start, end,
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flags,
          &amp;frag, &amp;frag_end);
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (frag &lt; shift)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
          <br>
          And that looks like the place we need to adjust something to
          allow updates of the leave nodes.
          <br>
        </blockquote>
        <br>
        yes, also we should always break here to restart page walk for
        unlocked unmapping
        <br>
        <br>
        if (frag &lt; shift || params-&gt;unlocked)
        <br>
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; break;
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Alternatively I wouldn't mind having a complete separate
          function for unlocked invalidations.
          <br>
        </blockquote>
        <br>
        A complete separate function will duplicate lots of page walker
        code. Alternatively we could change amdgpu_vm_pte_fragment, for
        unlocked unmapping, always return frag_end to 2MB (or 1GB), not
        4MB, 8MB....
        <br>
        <br>
        Regards,
        <br>
        <br>
        Philip
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Regards,
          <br>
          Christian.
          <br>
          <br>
          <br>
          <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end += cursor.pfn
            &amp; ~(entry_end - 1);
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry_end = min(entry_end, end);
            <br>
          </blockquote>
          <br>
        </blockquote>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
