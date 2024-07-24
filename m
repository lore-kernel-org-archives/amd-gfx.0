Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4913DC3DA63
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jul 2024 18:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B3410E791;
	Wed, 24 Jul 2024 18:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WAuXS/Ty";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A219F10E791
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jul 2024 18:28:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHzjzsOX6beUoECdDU3mfOq7mA9ET4S0mXhCACYPVBxqCXKuApTY2JlaPdFKaNbCR2ltcYIagSpYcOeB1eRUQjIAfYQN0a0PoiV1e1ePsi1OLAD3YKSKVEpCr4i6aMFZCxbZO6qekiBcLf1L8VfACmO7v01TdRfNPYwgVr0pW2LLl8hCq6LFAwQqwfl+v4jF2GmAGt2/2VVVMxGTSdr1IsEqN3/G8mlEbHiW9tDHzYeoHK8BlTKU8E7W5FDPn/+k/EpKj5X13BjR6n1cZgxFr/oeYbQ+LIYJySgw3j71DyyXcdtWNR/6AOFjIw7JBlPGN/U7aUeHzpbkMvgKwpl6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTdqzs7HYbHF0YPWT5oXPXlpvqkseynek0uDHPrI0e0=;
 b=K5rA+Md8VPM6x6oHxLLCQ4x7EVVLBKOe3AuwnqKGi5cqff4TMf6jY2AtQYZbkm25ScRA5kP7ojBsVvyyPj857TDx7hLqpF7uf6gafD/oKBEccFm1k+OwE7i9nKTbsWGXYUL4EHH+L2kmuIte5Bw1aIMuaSqVCdLmlOcNXx/0XmZgYVSKqbUGPQAKGZJO/s/xMAd/+H95dOJaHZ6ospPE+HZdG1r2gnndubPshW9UKc9lPskGjMUYOkXTPKsQArlJP/zH0oyhDUiw8WvjGhVRuAc1MfsliQynZTcbnGl+ga3jY6QURCugMIZRJeSCN5kfSlw1PzLqbPwgizqgao97Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTdqzs7HYbHF0YPWT5oXPXlpvqkseynek0uDHPrI0e0=;
 b=WAuXS/Tys4bKxpRHEbNGSccP8pyujb73rppyiAtau1HroKUHI2aGivktqAzOQVznvCfPp2z4k8pP1us9iEP+UyTrC3vROng2Q0vzFVF2zWCIClPSpGFpfIJ37r89HqP6bQQqIX24xUJW+PCGR5jLk26sKblzEgyeJB+0YwCNxTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 18:28:03 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 18:28:03 +0000
Message-ID: <fe9a43cc-91b1-3557-f38e-fa92685a9847@amd.com>
Date: Wed, 24 Jul 2024 14:28:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Change kfd/svm page fault drain handling
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, Philip.Yang@amd.com
References: <20240719221738.26840-1-xiaogang.chen@amd.com>
 <6b475d85-12ee-3732-4d96-05647374d773@amd.com>
 <054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::20) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 65520c54-fea6-4e21-1883-08dcac0e5b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0MxN2oxV2tGdnRHa0NNYUM4QklGUjU3Vk5iaHJDeDd1T1lHcmJITnYxV01B?=
 =?utf-8?B?VzE4NUtQRUxtelRUWlZIQ21SRkl2STU0UXc5eUJqUnJMUTVMOUdmaE5nWXRW?=
 =?utf-8?B?aVgySEJpbEdoYnRtQVBFVEFsUzJHWTNGVzdWNTZFczZDVCtyUTQxdjh1Z1NR?=
 =?utf-8?B?bGppd0JFNWN0T2x3bzMwRzNvUkhlN05HOEdzTExPSkhNOGpZYy9MRnhkUjJK?=
 =?utf-8?B?aGRFMFcreVA3Tkx2QWEyR1RuR0Y1SSszSEdMT0h1cFFWNkYwZUtWZ21QUXEv?=
 =?utf-8?B?WW50YXN3WlhzSG53akFaSmdRVWlRSFIzdlBaZXlrU0FpdEhtd3JsTmEzV0E2?=
 =?utf-8?B?aldmRG9lQmk3dEh4d1RKS04vRW1TQkdNSXdDOWRza0JQS2VzbFVpN2I3RmVZ?=
 =?utf-8?B?TDlJNTJBdzFtZG5rS1JLVTVrOUhhYk5DZjBHVHdUVmUyTlhMdHAvK1pTTDd3?=
 =?utf-8?B?SFNMYXF0NURWeXdYd0pTSkJIQlhSQVl6aUtDaVMrSllobG92NUxoSnR1dkNK?=
 =?utf-8?B?TVczZEVlZXVWYjVLcGhBUTNXWTVrdysvaWovM3o0N210bUltdU16empIT1N4?=
 =?utf-8?B?QzJFcHFqeVFXTVpTRFBTRkhmazNvdDBJYVRTcHlnTklackMraFBFV1VoRWJj?=
 =?utf-8?B?NTFnSzRhWnlrUnVVeGFxN05JdlhsUzd1SGtQOUlHMGk3UE45OFlqSHF5YUZl?=
 =?utf-8?B?NVFCOXZDc3FyY2lraFNvdVdwY3R6dGhjcWZaallQdXpOazdsZXBYVTZPam9B?=
 =?utf-8?B?V3U2WGR4bHdrQzhJZU5GWjZET3Y0WUU1OFhiZGdaZUxWZDZMNTZ5TmovNXF6?=
 =?utf-8?B?eE9VTjlFWjJQd3pnSHhvZXB6RWkwUi9TNW5zblFENFdQY0Q5NTJCL21qMm0z?=
 =?utf-8?B?bHo4QnlLYjJDUHA5bm94TG1PYzVla3M4cEpwTENWWnFNcUpQeDUwQjFKM2I4?=
 =?utf-8?B?bmsyMVZjcTlzU1o1d05pN0ZubStFL0xncTlGUEN1ZmE1NlBaV2VwbmNtVXhC?=
 =?utf-8?B?OGxsR0NMT2t0N1FyLzUrcmMyT2poZFExYWk2SmxXWFZodFE0dkh0K0s2VVho?=
 =?utf-8?B?OXZVNUlwWURMZ2d4OTFXUG5hTS9LRVdPL3REbWh4cWVWeGFSdVhRNmw4dExS?=
 =?utf-8?B?RXhOcWtnOHJxUWxCTDNCWFkxZUZvZ3dtaVk4VnhYUXBuOWxrSzVLYjFVb2Qy?=
 =?utf-8?B?S1U2T0YzRTU1NG0vbnovdjFRSm94SFJ5NUh5NnRZYmlOQnVLNUZCeGdXMUxz?=
 =?utf-8?B?aGtNNE5rSE50c0ZpUGdSeFNYd1FpLzg5SVYzWTQvS0JKTmZHMEFzenVvL21r?=
 =?utf-8?B?SWcvSG1ZdTFGa3hPMFBTNWJESU9JT1hCc1NNSitYaHMrSGFsd21JbG5HNUdj?=
 =?utf-8?B?V0RLRy9SMGdFYVhvK05Oejl5UG1aNVI5N2pXVU9NeCtUWXJmT29sSHFyTUlX?=
 =?utf-8?B?empZVG1PN2FlTmRPRjNDdHQxbStUakdQM1VDazZ5bVM4Q2RXdllHZUMydXg4?=
 =?utf-8?B?dW5xeEdrNzFOUFpka1BHOFQ1NyttYjZLMGNoc1BoS3lNVmt4a0EvOHdPTGxX?=
 =?utf-8?B?RzB3aE9kTzhuZ3FGbnBodWNMVHZURHAxSWJISzZGR2R4dDFwc0txNUhaajV1?=
 =?utf-8?B?Z1NPWVdPVWIrcEoxc0RTaythRjNTb0lHS1NYWEZIS3NWb2tYT1dLRWE1c2ky?=
 =?utf-8?B?ZnovQWJJRmNxY1JCTEN6WHJqb1VCeDZPVFdUOW5oNlU3TlY4YjFmNDNjYU5O?=
 =?utf-8?B?Y2Rxc1kzZXVydTNKUjk2QU94VmNlQXZhR0dQcHhBWjVDTHRvKy85bE41dUs0?=
 =?utf-8?B?bStFaTc1VHUvOUxHelYyUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01QV2dTY3JxMllQd2Q0V3RlVmRpckZZa3lMZDlPeWRrb0pYdnRvZ1VkZ21k?=
 =?utf-8?B?NWc0VTFUUzFwRmpaZFU1dEprN3FVSzNtc2doZHNVY0xYRGRkNG5XZThPU0ZG?=
 =?utf-8?B?ZitWL3VSajBlcCtHUE12TG84OGVXTjluV0RiaDFsditlYzBMeGhKMlQ3d3pq?=
 =?utf-8?B?UStrZFJydzVSVjVlVWFuUE5yMzIrQVJmTUl6ZFN0SS9OTUZEQmlsd243MWov?=
 =?utf-8?B?TzhmRlVDOUk1dWVjWG1XYU5iektqT3V6RHZXWGwwQVlzeFB0YVY2OEpQRnhO?=
 =?utf-8?B?V1ljdXZHb3lsL3YrenZ3ME92YXM0MXRONVl3ckZJaDhPSTlmK3BYVVYxZDFC?=
 =?utf-8?B?RTJIOWs2eHFMUkgxRi9scDh5SDlrTWxERTVRVGEzR0dneEtsbDd4WXpscWdy?=
 =?utf-8?B?Tmt5WDVyVC9NWFdNalpMcUNyZytzS0taVTByMW9YMC9BVE5ZYXA5ODdWWm5H?=
 =?utf-8?B?RGI2ZDgrb0UwVVo2UzdUNFU0dmgrRjM4aW5yRHN5bDJINFdHOXRMT3c0Z0NW?=
 =?utf-8?B?MEh4ckdpaTNaa3ZDV2l6SUZ3cDVsL2dYSjRpZXljd29Yem1WSU9hWDJrS3Fl?=
 =?utf-8?B?WG11Z3BVb3FYZ1N3QVEwQ3dPcmRyeDNSWDN5MHlQMHZjMkpkRmpvY2lBVG55?=
 =?utf-8?B?dU1JSXYwZnNRNG16cHpDUHBXY3JBeXRaNGpQeHZKQ0FBOGNINW41VHlCV3Q4?=
 =?utf-8?B?cUxYUUVwOTZLbytoYjJ3TkJvMU45d0l4Y2MraDFtd1FDZXVNd3BaV1hPa3NG?=
 =?utf-8?B?cHlkNjNqdWNwVFBKZms0azV5WlA5VjdhcitNTVNYbVNYZm9Sclo1aXY5Nlgz?=
 =?utf-8?B?aVR0ODN6R2haQVdZREw4ZGQycUVweEJWU2F1K2ZzclJKb1FZM1hadUJxUkVR?=
 =?utf-8?B?NU5OM093eU1XbTVsWXVHaW1QVFZxcHROdmRIbm9MdGlvZ3VQVTBBcUVLYys5?=
 =?utf-8?B?NkZJSEo0SEh0cGtWUkJ0R0NYdDByUXFNKy9mb1NKYUhSSmgzN3c0aVRqTG4z?=
 =?utf-8?B?UW1JV3h2WHZUSkU5eXVyTjB4YVhBbm5uZFVzc3hGdDNsZnRVQ3ZvYm5vWDVq?=
 =?utf-8?B?Q0hHNlJpdUwvdjNZSTFWYVRGdzJieWlBa1dlK1M4R3lqb0xHMnUrNjd0cnFR?=
 =?utf-8?B?cEdlQmlMeHpkdi9PWDVWQTJMOUY1VUxEOVYzNVJNVWIzbmxhZXRBZmk2VzZz?=
 =?utf-8?B?MTl2UjFZaGJpRkdCU1BVUXdYazZiM1VpbXRwRXNvZm1KWVZiWnhNaG1iSXlp?=
 =?utf-8?B?YlpYMVBsK0YxbTdINTBnTFBGTEFVWkU0K3phbk5xZU00a1JWTHptY2ZRWUZQ?=
 =?utf-8?B?OEdNeTlLZ3BDRXhTZmtvWk9vMnlUMDkybEw5Yk5kRkVlMWdGK0w0ZjV6Z0s5?=
 =?utf-8?B?VUthOXZLUWpxaDcyWWk3UnZMTnl1aTB6R1FhRnFUWVVVRXhLdlJ0NHpFTWZj?=
 =?utf-8?B?dm9WVUd0WHk3eGZsalpjb0NvNXlVZm1pQnltOVJwMTQ2SDNRMnQyb3FqZElr?=
 =?utf-8?B?US9VUWpVY05xTTZaRmJkV05OcmJnV2hHUmY3Q3J6a0R5c3k0VHp6cmk4dkFo?=
 =?utf-8?B?L1Nhc2thOTA0UjA4M253YVJ2WkNzSUpWMWtZK2d4VUZBU3NVazFkckJRNkIz?=
 =?utf-8?B?aHdIc1NRTmxWN2xNRWZENUJqWlZvVUNqRitXM3Z1bGtDY2NvSHpob3VCQTND?=
 =?utf-8?B?TWc3aS9ENGNzS0xUS3Vma2FOSjNhNGtXVXJIZlNuVHRyeEFWd2t1UGFoK1Rr?=
 =?utf-8?B?V1ltb2V4alBxbFR5WkxrczBkalhhYUI2R09QeUpscVZ0ckVxVlFMNXhIMlkr?=
 =?utf-8?B?Z053V3U3SGlpWEM0M0xRdlNsb08zOHF0Z056NERsK1RSanpOYTgzTCt2WmZw?=
 =?utf-8?B?VXlidGg1ZEsxNjcvdFVITVEvVzVWR2JmZHVOcEE4ZjY1bFV6WGNKWHVkTlhH?=
 =?utf-8?B?NzlZOXArc2l5NXBWTkNqYW50YzBXVDBabmo5dlluUVhQVTk3dDU3V200MlJi?=
 =?utf-8?B?Y244aE8vRUxPQytpRXpvWWtQRGl4akFYOTJpNC96cGVSQ2x0dllPL1F4NVJ6?=
 =?utf-8?B?KzB3N2svS0VlaTNHV0Y3aXBTd0ZIaWJnSk1Na01xRE1XQlg5TVlWUU5kdjhI?=
 =?utf-8?Q?388Q=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65520c54-fea6-4e21-1883-08dcac0e5b09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 18:28:03.7641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wgho7TRA5Al+/VjjhUFH4WGnhYIZUwA3ayGgzguaJb78AyLfeXh1okgt5aR8X1KL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425
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
    <div class="moz-cite-prefix">On 2024-07-24 09:58, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 7/23/2024 4:02 PM, Philip Yang
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <p><br>
        </p>
        <div class="moz-cite-prefix">On 2024-07-19 18:17, Xiaogang.Chen
          wrote:<br>
        </div>
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">From: Xiaogang Chen <a class="moz-txt-link-rfc2396E" href="mailto:xiaogang.chen@amd.com" moz-do-not-send="true">&lt;xiaogang.chen@amd.com&gt;</a>

When app unmap vm ranges(munmap) kfd/svm starts drain pending page fault and
not handle any incoming pages fault of this process until a deferred work item
got executed by default system wq. The time period of &quot;not handle page fault&quot;
can be long and is unpredicable. That is advese to kfd performance on page
faults recovery.

This patch uses time stamp of incoming page page to decide to drop or handle
page fault. When app unmap vm ranges kfd records each gpu device's ih ring
current time stamp. These time stamps are used at kfd page fault recovery
routine.

Any page fault happens on unmapped ranges after unmap events is app bug that
accesses vm range after unmap. It is not driver work to cover that.

By using time stamp of page fault do not need drain page faults at deferred
work. So, the time period that kfd does not handle page faults is reduced
and can be controlled.</pre>
        </blockquote>
        This simplify the retry fault draining and support the multiple
        processes correctly now, some nitpick below.<br>
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">Signed-off-by: Xiaogang.Chen <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |   4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 111 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h   |   2 +-
 7 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..d90b7ea3f020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2763,7 +2763,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
  * shouldn't be reported any more.
  */
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault)
 {
 	bool is_compute_context = false;
@@ -2789,7 +2789,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &amp;&amp; !svm_range_restore_pages(adev, pasid, vmid,
-	    node_id, addr, write_fault)) {
+	    node_id, addr, ts, write_fault)) {
 		amdgpu_bo_unref(&amp;root);
 		return true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 312a408b80d3..1d6a1381ede9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -548,7 +548,7 @@ amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
 
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
-			    u32 vmid, u32 node_id, uint64_t addr,
+			    u32 vmid, u32 node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d933e19e0cf5..5cceaba6e5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -132,7 +132,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 		/* Try to handle the recoverable page faults by filling page
 		 * tables
 		 */
-		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr, write_fault))
+		if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, 0, 0, addr,
+								   entry-&gt;timestamp, write_fault))</pre>
        </blockquote>
        indent should align to the start bracket.<br>
      </blockquote>
      ok.<br>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap=""> 			return 1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 350f6b6676f1..ac08d9424feb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -595,7 +595,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			cam_index = entry-&gt;src_data[2] &amp; 0x3ff;
 
 			ret = amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						     addr, write_fault);
+						     addr, entry-&gt;timestamp, write_fault);
 			WDOORBELL32(adev-&gt;irq.retry_cam_doorbell_index, cam_index);
 			if (ret)
 				return 1;
@@ -618,7 +618,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			 * tables
 			 */
 			if (amdgpu_vm_handle_fault(adev, entry-&gt;pasid, entry-&gt;vmid, node_id,
-						   addr, write_fault))
+						   addr, entry-&gt;timestamp, write_fault))
 				return 1;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c51e908f6f19..8b8d5ab9da76 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -850,10 +850,13 @@ struct svm_range_list {
 	struct list_head                criu_svm_metadata_list;
 	spinlock_t			deferred_list_lock;
 	atomic_t			evicted_ranges;
-	atomic_t			drain_pagefaults;
+	/* stop page fault recovery for this process */
+	atomic_t			stop_pf_recovery;</pre>
        </blockquote>
        This flag seems redundant, as timestamp is 48bit increasing and
        amdgpu_ih_ts_after handle the wrap around, so always use
        timestamp to drop retry fault. <br>
      </blockquote>
      <p>This flag notifies page fault restore routine to not process
        page fault for this process. It is used here when getting
        current time stamp at each gpu's IH ring, then unset it. To make
        sure page fault will not be processed during time period when
        get current time stamps, though it is very short.<br>
      </p>
    </blockquote>
    don't need unset checkpoint_ts, what we need is to ensure updating
    checkpoint_ts with current wptr timestamp, and then free prange. If
    there is issue, probably because missing write_once/read_once or
    have to use atomic64_t for checkpoint_ts. <br>
    <blockquote type="cite" cite="mid:054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com">
      <p> </p>
      <p>And this flag maybe used in future for general purpose that we
        need stop process page fault recovery for some reasons.<br>
      </p>
    </blockquote>
    Then this could be another flag to stop retry fault recovery in
    future, not related to drain retry fault. <br>
    <blockquote type="cite" cite="mid:054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com">
      <p> </p>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap=""> 	struct delayed_work		restore_work;
 	DECLARE_BITMAP(bitmap_supported, MAX_GPU_INSTANCE);
 	struct task_struct		*faulting_task;
+	/* check point ts decides if page fault recovery need be dropped */
+	uint64_t				checkpoint_ts[MAX_GPU_INSTANCE];</pre>
        </blockquote>
        I think it is safe to not use atomic64_t.<br>
      </blockquote>
      not sure what you mean here: you do not want use uint64_4, or
      atomic64_4? I use unit64_4 here. And as you mention below, will
      use <span style="white-space: pre-wrap">WRITE_ONCE/READ_ONCE  on svms-&gt;checkpoint_ts[i].</span></blockquote>
    <p>uint64_t update is not multiple thread safe even on 64bit cpu, we
      should add mutex/spinlock or use atomic64_t. checkpoint_ts only
      update in mmu notifier unmap callback, this is serialized by mmap
      lock, so it is safe to use uint64_t.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:054a813f-8310-466a-9fdc-a3be0cdc4ee8@amd.com">
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap=""> };
 
 /* Process data */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..9dd28d06ea2a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2263,16 +2263,10 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_process *p;
-	int drain;
 	uint32_t i;
 
 	p = container_of(svms, struct kfd_process, svms);
 
-restart:
-	drain = atomic_read(&amp;svms-&gt;drain_pagefaults);
-	if (!drain)
-		return;
-
 	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
 		pdd = p-&gt;pdds[i];
 		if (!pdd)
@@ -2292,8 +2286,6 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
 
 		pr_debug(&quot;drain retry fault gpu %d svms 0x%p done\n&quot;, i, svms);
 	}
-	if (atomic_cmpxchg(&amp;svms-&gt;drain_pagefaults, drain, 0) != drain)
-		goto restart;
 }
 
 static void svm_range_deferred_list_work(struct work_struct *work)
@@ -2315,17 +2307,8 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 			 prange-&gt;start, prange-&gt;last, prange-&gt;work_item.op);
 
 		mm = prange-&gt;work_item.mm;
-retry:
-		mmap_write_lock(mm);
 
-		/* Checking for the need to drain retry faults must be inside
-		 * mmap write lock to serialize with munmap notifiers.
-		 */
-		if (unlikely(atomic_read(&amp;svms-&gt;drain_pagefaults))) {
-			mmap_write_unlock(mm);
-			svm_range_drain_retry_fault(svms);
-			goto retry;
-		}
+		mmap_write_lock(mm);
 
 		/* Remove from deferred_list must be inside mmap write lock, for
 		 * two race cases:
@@ -2446,6 +2429,7 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	struct kfd_process *p;
 	unsigned long s, l;
 	bool unmap_parent;
+	uint32_t i;
 
 	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
@@ -2455,11 +2439,49 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	pr_debug(&quot;svms 0x%p prange 0x%p [0x%lx 0x%lx] [0x%lx 0x%lx]\n&quot;, svms,
 		 prange, prange-&gt;start, prange-&gt;last, start, last);
 
-	/* Make sure pending page faults are drained in the deferred worker
-	 * before the range is freed to avoid straggler interrupts on
-	 * unmapped memory causing &quot;phantom faults&quot;.
+	/* first stop kfd page fault handling for this process */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 1);</pre>
        </blockquote>
        this flag is not needed.<br>
      </blockquote>
      As above, this flag used here to not process page fault during
      time period that get current time stamp of each gpu IH ring.<br>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">+	/* calculate time stamps that are used to decide which page faults need be
+	 * dropped or handled before unmap pages from gpu vm
 	 */
-	atomic_inc(&amp;svms-&gt;drain_pagefaults);
+	for_each_set_bit(i, svms-&gt;bitmap_supported, p-&gt;n_pdds) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_device *adev;
+		struct amdgpu_ih_ring *ih;
+		uint32_t checkpoint_wptr;
+		uint64_t checkpoint_ts = 0;
+
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
        </blockquote>
        don't reset it to zero.<br>
      </blockquote>
      ok<br>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">+		pdd = p-&gt;pdds[i];
+		if (!pdd)
+			continue;
+
+		adev = pdd-&gt;dev-&gt;adev;
+		ih = adev-&gt;irq.retry_cam_enabled ? &amp;adev-&gt;irq.ih : &amp;adev-&gt;irq.ih1;
+		if (!ih-&gt;enabled || adev-&gt;shutdown)
+			continue;
+
+		checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+		/* Order wptr with ring data. */
+		rmb();
+		checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
+
+		if (adev-&gt;irq.retry_cam_enabled) {
+			ih = &amp;adev-&gt;irq.ih_soft;
+
+			if (!ih-&gt;enabled || adev-&gt;shutdown)
+				continue;</pre>
        </blockquote>
        this check can be removed.<br>
      </blockquote>
      ok<br>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">+
+			checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+			rmb();
+			checkpoint_ts = max(checkpoint_ts,
+						amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1));
+		}
+		svms-&gt;checkpoint_ts[i] = checkpoint_ts;</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">WRITE_ONCE(svms-&gt;checkpoint_ts[i], checkpoint_ts);</pre>
        Use WRITE_ONCE here and restore_page use READ_ONCE to sync up
        the timestamp update. <br>
      </blockquote>
      ok<br>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap="">+	}
+	/* resume kfd page fault handing with time stamp checking */
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 
 	unmap_parent = start &lt;= prange-&gt;start &amp;&amp; last &gt;= prange-&gt;last;
 
@@ -2900,7 +2922,7 @@ svm_fault_allowed(struct vm_area_struct *vma, bool write_fault)
 int
 svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 			uint32_t vmid, uint32_t node_id,
-			uint64_t addr, bool write_fault)
+			uint64_t addr, uint64_t ts, bool write_fault)
 {
 	unsigned long start, last, size;
 	struct mm_struct *mm = NULL;
@@ -2910,7 +2932,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	ktime_t timestamp = ktime_get_boottime();
 	struct kfd_node *node;
 	int32_t best_loc;
-	int32_t gpuidx = MAX_GPU_INSTANCE;
+	int32_t gpuid, gpuidx = MAX_GPU_INSTANCE;
 	bool write_locked = false;
 	struct vm_area_struct *vma;
 	bool migration = false;
@@ -2930,7 +2952,29 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 
 	pr_debug(&quot;restoring svms 0x%p fault address 0x%llx\n&quot;, svms, addr);
 
-	if (atomic_read(&amp;svms-&gt;drain_pagefaults)) {
+	/* kfd page fault recovery is disabled */
+	if (atomic_read(&amp;svms-&gt;stop_pf_recovery)) {
+		pr_debug(&quot;page fault handing disabled, drop fault 0x%llx\n&quot;, addr);
+		r = 0;
+		goto out;
+	}
+
+	node = kfd_node_by_irq_ids(adev, node_id, vmid);
+	if (!node) {
+		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
+			 vmid);
+		r = -EFAULT;
+		goto out;
+	}
+
+	if (kfd_process_gpuid_from_node(p, node, &amp;gpuid, &amp;gpuidx)) {
+		pr_debug(&quot;failed to get gpuid/gpuidex for node_id: %d \n&quot;, node_id);
+		r = -EFAULT;
+		goto out;
+	}
+
+	/* check if this page fault time stamp is before svms-&gt;checkpoint_ts */
+	if (amdgpu_ih_ts_after(ts, svms-&gt;checkpoint_ts[gpuidx])) {</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">if (amdgpu_ih_ts_after(ts, READ_ONCE(svms-&gt;checkpoint_ts[gpuidx]))) {</pre>
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap=""> 		pr_debug(&quot;draining retry fault, drop fault 0x%llx\n&quot;, addr);
 		r = 0;
 		goto out;
@@ -2952,13 +2996,6 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		goto out;
 	}
 
-	node = kfd_node_by_irq_ids(adev, node_id, vmid);
-	if (!node) {
-		pr_debug(&quot;kfd node does not exist node_id: %d, vmid: %d\n&quot;, node_id,
-			 vmid);
-		r = -EFAULT;
-		goto out;
-	}
 	mmap_read_lock(mm);
 retry_write_locked:
 	mutex_lock(&amp;svms-&gt;lock);
@@ -3173,9 +3210,11 @@ void svm_range_list_fini(struct kfd_process *p)
 	/*
 	 * Ensure no retry fault comes in afterwards, as page fault handler will
 	 * not find kfd process and take mm lock to recover fault.
+	 * stop kfd page fault handing, then wait pending page faults got drained
 	 */
-	atomic_inc(&amp;p-&gt;svms.drain_pagefaults);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 1);
 	svm_range_drain_retry_fault(&amp;p-&gt;svms);
+	atomic_set(&amp;p-&gt;svms.stop_pf_recovery, 0);
 
 	list_for_each_entry_safe(prange, next, &amp;p-&gt;svms.list, list) {
 		svm_range_unlink(prange);
@@ -3197,16 +3236,18 @@ int svm_range_list_init(struct kfd_process *p)
 	mutex_init(&amp;svms-&gt;lock);
 	INIT_LIST_HEAD(&amp;svms-&gt;list);
 	atomic_set(&amp;svms-&gt;evicted_ranges, 0);
-	atomic_set(&amp;svms-&gt;drain_pagefaults, 0);
+	atomic_set(&amp;svms-&gt;stop_pf_recovery, 0);
 	INIT_DELAYED_WORK(&amp;svms-&gt;restore_work, svm_range_restore_work);
 	INIT_WORK(&amp;svms-&gt;deferred_list_work, svm_range_deferred_list_work);
 	INIT_LIST_HEAD(&amp;svms-&gt;deferred_range_list);
 	INIT_LIST_HEAD(&amp;svms-&gt;criu_svm_metadata_list);
 	spin_lock_init(&amp;svms-&gt;deferred_list_lock);
 
-	for (i = 0; i &lt; p-&gt;n_pdds; i++)
+	for (i = 0; i &lt; p-&gt;n_pdds; i++) {
+		svms-&gt;checkpoint_ts[i] = 0;</pre>
        </blockquote>
        <p>not need to init 0 as kfd_process structure is from kzalloc.</p>
      </blockquote>
      <p>ok</p>
      <p>Regards</p>
      <p>Xiaogang<br>
      </p>
      <blockquote type="cite" cite="mid:6b475d85-12ee-3732-4d96-05647374d773@amd.com">
        <p>Regards,</p>
        <p>Philip<br>
        </p>
        <blockquote type="cite" cite="mid:20240719221738.26840-1-xiaogang.chen@amd.com">
          <pre class="moz-quote-pre" wrap=""> 		if (KFD_IS_SVM_API_SUPPORTED(p-&gt;pdds[i]-&gt;dev-&gt;adev))
 			bitmap_set(svms-&gt;bitmap_supported, i, 1);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 70c1776611c4..5f447c3642cb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -173,7 +173,7 @@ int svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 			    bool clear);
 void svm_range_vram_node_free(struct svm_range *prange);
 int svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
-			    uint32_t vmid, uint32_t node_id, uint64_t addr,
+			    uint32_t vmid, uint32_t node_id, uint64_t addr, uint64_t ts,
 			    bool write_fault);
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence);
 void svm_range_add_list_work(struct svm_range_list *svms,
</pre>
        </blockquote>
      </blockquote>
    </blockquote>
  </body>
</html>
