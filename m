Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB1C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10DA1133CA;
	Tue, 23 Apr 2024 13:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kj49/7Ao";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D90811317E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:42:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO0qnu62ru3WXap6+NpbA77Gjjd8rjGcds16jVjCJNyDVmbx57gC7ro5F9BKlbzDuYvPL6d8PphAkuydv3aqEhaOHhrHnHceJwLAEwHl5O5VSA2dxY4eskLeDnuW9yhDgzi3ClBAJONihsBpqQvhhXX9w9xAtA6AftjSbg1i/2Of0gECKBxrICXo5J9s/sAodsHb/mA59JhfCISt7NRX4Uq6jPWI5WXNZv2FR2LTw8/W4paqxBlxw9hMrynSe1S3zpo0nnxh8penQ6TSzg3wAE8qMOnzZqUwnR9tzlvlYzISFDPWMy2QzEzAdlEIGo9SemVdGWEfzRXqPRuv3DWGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsT/fZqfcNnzRONCtqnnPCYkBzNPFk67mICbDK0pcA4=;
 b=NHpY+An7PfHU4sHSXmrACmWYS498opnUEcFsJ85WNDzxDYgbuRpE2MERfgNKRnuEXe73Oalb4gCLOuWOq1HoLRqXw1Zdu+7fPd/reA6Sugf/4KzYdcgsNPjEsra6oBRgKTVT++lI1TEmQ7LYpZ53ybj+NXKlF0C3rmyAnqkeggpYtY1N/4YSzvxt1hpQFsq8Lsygbaq9/KbFeXBqP2EKCQFs966AxQsD9wZZvMofRu3RiCVZ5YSlQU9PV8upZlsEPjQa5p9jLzKsLxLboHtjxYGP+xj1NC9YEFFfuERoqiI+BM9ChDlMI8boed56SMrJ0pAY2pFFzlGD0Q2lfNdcgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsT/fZqfcNnzRONCtqnnPCYkBzNPFk67mICbDK0pcA4=;
 b=Kj49/7AotaZHVbfWFNiPo9j3Wl29QJOFcy99BZp0OkHr2MnZ2yExaYElQBqck25+RJ2kkA25rLWKerZKfP4dr/G8w/UB8z22zI5kpu/9VTxHkJOZuUWSiKvP2Gzlvm1cdpJl1kgffFs0vjpIty/QTeRMgyaIEb8CXwO0xLsOUfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:42:41 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 13:42:40 +0000
Message-ID: <ef8bb77f-a0d1-1447-90c5-9e1af259a094@amd.com>
Date: Tue, 23 Apr 2024 09:42:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 6/7] drm/amdgpu: Skip dma map resource for null RDMA
 device
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423130450.25200-1-Philip.Yang@amd.com>
 <20240423130450.25200-7-Philip.Yang@amd.com>
 <a7779c0e-124e-4fee-b884-b0cc7075554d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a7779c0e-124e-4fee-b884-b0cc7075554d@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f768c-8e2d-47ee-e4a5-08dc639b3e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnFCTkNmNk5EMnU0S3dVMlp0cWpjWTFnMU9lc0lIRmIrakp5dDB5dTUzSjNy?=
 =?utf-8?B?T1YwT2Rxam9FT0krY25nRXE0TWtUdnBOZmJPTTArWVNrRytLMXJSc3AzK2pZ?=
 =?utf-8?B?M3hxTG5IQS9sZXNybFRQM2JwRHZmT2FXY3FINUczV2FTUVE4QUJSclR3STQ2?=
 =?utf-8?B?MHkydnNLeDZOQ0tVbFNsbHQyREMzcjZGbHRuUVlJMCs2anlnendXWVM1QnZj?=
 =?utf-8?B?MVhNOElUWElCdk9LWFBLaTNLQTF3UVN0VVd4MGhDRGVKT3BxOVVaOVRNTXZm?=
 =?utf-8?B?RE96UXllbHRHeGZFcVd3UGRNbVNXdGNFdFBDWHN1ZEpCL1ZwR1NlZzQ5TTFm?=
 =?utf-8?B?c0NIa29FWUwxS0xoMDNNak0weXpaQStuUkxOM0FDU3p5YkpraTIreit2Y2dp?=
 =?utf-8?B?NEJGU1VoM2plN09pcGFnQVVMTitZN2hGVXlhUlVZUmc3SFJhT0JhUS9qd283?=
 =?utf-8?B?Tjg2Z2xnWWVHTldUUVNsQzN0WlJFUTV6eEd1clFFS3dubUlDVFZpWnlic3RR?=
 =?utf-8?B?aklaRzJDSXFld21wWE1wSDlnMmcyZkVPdnpMWDcwajc1TGRVcmpaWkN0WnlP?=
 =?utf-8?B?TnFKRFlJV1RlYmxXb05OREtlK2tpOVFneUhMTVhNSFJuMUs2djRVU3IzTGFP?=
 =?utf-8?B?VTNNVzlLcENxYnZic21aMXpOTU44RlRoeGExalY4Z2RUcGt5dERXQlhtbjBQ?=
 =?utf-8?B?VlVTK2RseUNSMGdFNXliQ3I2OWJOdDdEanVZSXlLVWFrUHRWL3NpaGFMekd0?=
 =?utf-8?B?aWF1Vll2K2laK1cyM25XS0U0dDQyb0hoQnRzczIyRVpBeWpoOE5ieGZvZFZ5?=
 =?utf-8?B?dlRJMTR6VkcxSE5GcUhvSHNhRVR3dngvZHJhSjVRUG13bkx5aXo4ZERUM1Vx?=
 =?utf-8?B?QndIT2prTTh6bnZ5UCtZaWVxUVIyamJNbGdjUnNOZ3pzSlVmNTVxQ2ZmNDNZ?=
 =?utf-8?B?a25tTkt5bUlDdFBnNHk1akdlZUxBUnUxMmJpQTdaMUxzS2c0Nmd6elo3MWN0?=
 =?utf-8?B?UmpVZGNwdEl1aVB5cW5DREZnb0xoK3gyczc1SDNiNDd6ZG16dmZXQXFQOWIy?=
 =?utf-8?B?YkhSNHJ5ZjFRWENlUFpWMmI4N0pydm5lT3VvYjgzWHVqb2hpaG9JOElvaWVN?=
 =?utf-8?B?MXJwcFhWdWxlTTJGSWJVYU1SK2VFTUtJOGZJbldCdkNWaGdKZGVyZXgyYWg3?=
 =?utf-8?B?WEtGMnFCTHVqZ3V4bTBMd0lkZHBtMTAyRjRYUFdqMHdrUWRlVDhiZnBJUjhl?=
 =?utf-8?B?R0dMdDdWVFJvRWkyejRPaG11azUvY0RKRWkvakVzcUlUYUNEME1CZGhDR0xu?=
 =?utf-8?B?WkNadExlWnp4WHMzVzRBaUZCdEZzZ2hOQ3NmcitQRUJkc1JNYko3TEtVQi9Y?=
 =?utf-8?B?bnliZnJWQmxGZlkya1hnV1pHY3NyZHFldXBYLzUzVFZoMDh1L3d4L1VrTmU3?=
 =?utf-8?B?d1J0ejI1azM5TE1aN2k1N3NTanJON2V3NjNRNmdXQ1NLMjRaS3RlSjF3eUZG?=
 =?utf-8?B?SVgzNnM1ZUlEbzBQTmRvdDJiR3hkYzh1VStZY0wwbUdoWWpFV1orcnZYc3Js?=
 =?utf-8?B?dVdUckdTaVlENWxmdnNNNE5rVzlsTGphRVVJTVFzUnFqTUtlUTNvOVU5aU9B?=
 =?utf-8?B?anowd3pZMWVqTUtoMmJ6U2JZVk1MbmlIOUhsRGFIeFVDcGdiVS82K2FsbXB3?=
 =?utf-8?B?VHFPV3lvdnFlODNzWGVkM3RDcHkwVW01aHpyV3Jud1Y5cjVXU2tQdnF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm4zY2xCRkpyR1dxcW1HMXJkSkMwUDN1NHB6T3BuQnlVeGx5VWFDdjJjdXhH?=
 =?utf-8?B?VjJhaC80V2UxMlhzbFBvaXVkenRFc1BmZEMwZlB5U2ZpNWtWTi9FRGxwd3hq?=
 =?utf-8?B?VDlIc1NhazE4ajBRTUs0c2tva0ZhT0RnL0F0cUp4NHBUTmQ1cmgvWHlQeTVG?=
 =?utf-8?B?a1B0VDFyYjE4TWVRV3JOQ1kwZnhsMHZxWEV1VUs3ZDdHdnVHVFUxRVo3WWhM?=
 =?utf-8?B?TzM3SlBoYWpnaDhMNE5BK25STFROamttNmR5UGFqQVB1SzE0TlQyYUlBZjJz?=
 =?utf-8?B?MElNUU0zdkcrdGQ2d3R5U0EzeVUxTGh1V1FWQXBkZXAwWjVRT1FkaENqUktN?=
 =?utf-8?B?c1owSThIQW5yYjllSFM4K3p0YzM3ZGpUSEJIaUlYNUhQZVFzMGpCOE1LTGxX?=
 =?utf-8?B?U3JSdTl0d3dkMDgyZklzMmhydVVabHRjeG5WQmVTSU9GSURRNGVLSXlXd3h2?=
 =?utf-8?B?cXhkWFp3UmxJcnJDL3BDYWFQTFpkNVdqTmlXenRTcStSV08ydkxicUoyaEs1?=
 =?utf-8?B?VEpLS0kzdGc5YVNEODdTRExhbEVReXQzRmNwUVdyNldENTJhZkRNK2JiV2pm?=
 =?utf-8?B?Wnd0bnUwTzNzdzMxbFNjQWdVYUdHR0dNZUJXcGhOMGk4VkJZTVdrM0FUcEtN?=
 =?utf-8?B?L3JLTThPc0hEVEhvNFlybmYvOGt5S3Rua05vSnlMWExZeXdnMms1M2Y4UFYz?=
 =?utf-8?B?KzZJamgwOEVyVlkyMTE3QURhd3RicUwybjJsaStDdzREMlVWN3kzdjU3ei9H?=
 =?utf-8?B?OTc5REFrY3gvZ2VFUlI4QVhINE5MVWpPSldIT1FZMFlKV0RJVENmd3Q5ZzIz?=
 =?utf-8?B?OWhZOWs5Yy9FR09pcDB4c1BudjhPMGpTaXJOUE0xM3ByWnlCeVNoOXM2alN4?=
 =?utf-8?B?Z3ZQRGxiNnhSdEwveENhRzhLMlRYTTI0cDdTQ21JbU40djE5ajNCQ2ZJOVZN?=
 =?utf-8?B?RUJ5dVl6VU1Ja0NMbnR3Q0x6aURkcEdrQnpqTTNldEFiRkQ3Q2Y1a3BLNFZ1?=
 =?utf-8?B?UXdTeTN2ZFBFY0c2ZUVWaWlWNDltOGV4L1NNY1loNnBXMHBZYUJ3RGx1THZM?=
 =?utf-8?B?dGlyLzVmL1NhM0djNm84Rm9aWDRjb3J1Q3gzeXFsWGd5M2d0NTZqMnphT3hl?=
 =?utf-8?B?RWRGMnNJRHpCWUovbGpzbW5hT211THBpMi9rMEpaaGZueE1XZ0tJWHBYTHJr?=
 =?utf-8?B?ZVlnclVxTlpuNTVsZXJhWDl0Nm5Gb2tnWTZEcFVoMVR0dkJsZzdRZGVVNTVT?=
 =?utf-8?B?V1R4d3hITU9NbE85NzJBVEhqSW9BV2JSUEFiTVlsS09GRzZLaE5hSkgvREhO?=
 =?utf-8?B?dHBpZEozZHFnQWN6OXlTZ05LMjZvcUxGVDBkMmlUQmRMUEZJeDh3UEJiR2Mv?=
 =?utf-8?B?cTUrRDdpd1dTUUtqMXk5eGQ1bFVFbDhSNlJLUGpmdVVOS2pHNWpRdllJU2kr?=
 =?utf-8?B?eUlaLzFPVXlHMVFaQ1Y5azZ1dHNZMVB6YW11RnVCaFJrNVJJNldJU3VQeXVO?=
 =?utf-8?B?YU9GRGFhUWhOenFic0VmQmVkSjFCTGY1SjV3UE9wK2RPSW9NOGdaVStuME1i?=
 =?utf-8?B?cmxSVW5VWlNwMVV5aW80a0t0VHlkNk1DTDZkVHhXbG5GbnZDNU94Z0FQVXV5?=
 =?utf-8?B?Qzc4VmxBK0dvVGdEekd2STM0cXNsZHo2ci9zZGhjS2l0RW9Sb3REVC90QWE0?=
 =?utf-8?B?TGo1dVBTY0RXVkYwVHVkZ2FkUHZxMFJVRVo5bURXK0RwMlJyMkVINk9udCs0?=
 =?utf-8?B?U216anVzNGxDc1JQQTFtcms2cTNMMGZCcXhPblB3RnhmWDVoQlFsaUtPbnJp?=
 =?utf-8?B?Nkd6UXZTVEtaa1VDSStXbmE0YzYweDFRTnMxcFBPMnRwN3AvL085VGxqZEJL?=
 =?utf-8?B?QUV2RHQ2VGNTZit4Rld4aDIyTWtBdVRLZGt3Z3hxSGtGbTF4bGYyMmNwSWth?=
 =?utf-8?B?SEw2WHg4RGtSdmdVVDJNbnMyV1M5cTc2SVZKVWRRRWdRY3dwcnk0akdObmJ3?=
 =?utf-8?B?cUI0K05VRTFzdkRuSS9wc2c0OWpZVkl1LzZYTm5jSzZEZVJLbUdZdkdpeXdQ?=
 =?utf-8?B?ZTJhanRISDZNL0hPQWg3MlFZRi9tWWhlbXFRRFBNSm0zSVhCV1lsaWFuT2tD?=
 =?utf-8?Q?QTEA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f768c-8e2d-47ee-e4a5-08dc639b3e76
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:42:40.0487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUS/p3ZHnJGoDNuuEEQ+ztbSDRlbAOFvUk8gJmzmNu7WE+jC4de+hiQ2sKTTgWfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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
    <div class="moz-cite-prefix">On 2024-04-23 09:32, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:a7779c0e-124e-4fee-b884-b0cc7075554d@amd.com">Am
      23.04.24 um 15:04 schrieb Philip Yang:
      <br>
      <blockquote type="cite">To test RDMA using dummy driver on the
        system without NIC/RDMA
        <br>
        device, the get/put dma pages pass in null device pointer, skip
        the
        <br>
        dma map/unmap resource and sg table to avoid null pointer
        access.
        <br>
      </blockquote>
      <br>
      Well just to make it clear this patch is really a no-go for
      upstreaming.
      <br>
      <br>
      The RDMA code isn't upstream as far as I know and doing this here
      is really not a good idea even internally.
      <br>
    </blockquote>
    <p>Right, this change is not needed and not related to upstream,
      just to minimize the difference with upstream.</p>
    <p>I will not upstream this patch.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:a7779c0e-124e-4fee-b884-b0cc7075554d@amd.com">
      <br>
      Regards,
      <br>
      Christian.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 33
        +++++++++++---------
        <br>
        &nbsp; 1 file changed, 19 insertions(+), 14 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        index 6c7133bf51d8..101a85263b53 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
        <br>
        @@ -698,12 +698,15 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long size = min(cursor.size,
        MAX_SG_SEGMENT_SIZE);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_addr_t addr;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = dma_map_resource(dev, phys, size, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = dma_mapping_error(dev, addr);
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unmap;
        <br>
        -
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = dma_map_resource(dev, phys, size, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = dma_mapping_error(dev, addr);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_unmap;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr = phys;
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_set_page(sg, NULL, size, 0);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_address(sg) = addr;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_dma_len(sg) = size;
        <br>
        @@ -717,10 +720,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct
        amdgpu_device *adev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sgtable_sg((*sgt), sg, i) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!sg-&gt;length)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;
        <br>
        -
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(*sgt);
        <br>
        &nbsp; @@ -745,10 +748,12 @@ void amdgpu_vram_mgr_free_sgt(struct
        device *dev,
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct scatterlist *sg;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;
        <br>
        &nbsp; -&nbsp;&nbsp;&nbsp; for_each_sgtable_sg(sgt, sg, i)
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp; if (dev) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for_each_sgtable_sg(sgt, sg, i)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_unmap_resource(dev, sg-&gt;dma_address,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg-&gt;length, dir,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DMA_ATTR_SKIP_CPU_SYNC);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sg_free_table(sgt);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sgt);
        <br>
        &nbsp; }
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>
