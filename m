Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C404EC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 20:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4705410EA87;
	Thu,  6 Mar 2025 20:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L+cdFwsb";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96AEF10EA87
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 20:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzGUEBzebUPdi/wQMsZDzuXp/c5Z5E9I9Tm1/XOVZgzShNvLBcOcF912SxM2iZ4gz4TD+Z7//pKRR4q/7LveayyEvnEz8O5+c03LwIPdlyxr/xXohn1nuCvkJDoTIdZ31xyTqnoLxlSowKyPmMko+VXK4Qdr8/NX4Mmbq6mhfZTqezCfjjf6OGN71LnrCPt8/ukDUFBmGkwTAZiz9QuiFEEpDnLHPqij2vidwXalv818Ggn8/Lxo1e6PyI/IHixJnWHxRAZcZGlpvI64xsBO2iyZXTOZUriKU40Fvc+XBNnkjmN9kwOG3cqcj39cmAzeUcBLylBOh3DX+vCP1xnENw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FGK3iv8J2ffP5y07Roj6y+6Cn7dc3aX4P/tzxta1o8=;
 b=TUuiVEapxZlFH8HeOHXqaASBTOY9O4XfMU+zkOCTm9btdcSgYNow+Q/oiSL7ceMbpvgXI0LZa5fFxkJUO8ct49zwtl2SFOgBN/qrWYEjkfCkFkklZECHCIZ8nKmpz5OKOUk6PVVpkrhKf+IoM4OkPXCZrkK1lT+dCJ3lJhRZMVBFuVMGpPFItK3RItmdoQSK2GzC+RzYCzJrHk21UlISKHFun2q8YncvrQb1sY5bVjNHBpCQ7Y35xGokW2LqOstdpGMw0ZzOMdGjKqXUIBOJiNRmfYA8ChV4rtfVZJ5EiFvqxF+WNBPH5jOavgylRF1RdgL5KKRyElTVBO+fd9f6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FGK3iv8J2ffP5y07Roj6y+6Cn7dc3aX4P/tzxta1o8=;
 b=L+cdFwsbzhclhnmbLmNyHUwFoEIQQLrQ7v8InIqi76Ta5jZG8aesCF6yvrm6P/JUkLKNnXIV6g9qX6k4KM2uFoH0s+VlKndSfGCFMI9yzU2yCOer7OtUwnZVnTn+FCmiJajjDTuws9G/njEeKkE75uIwTQxRp+VhcvLEGHAHCzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 20:51:28 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::39f9:c340:9b03:c651%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 20:51:28 +0000
Content-Type: multipart/alternative;
 boundary="------------akzWSzfCJdPPCTVhohBW7wr3"
Message-ID: <4eb51f83-250f-4a15-a0cc-9f4afecf0c11@amd.com>
Date: Thu, 6 Mar 2025 15:51:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amdkfd: Add support for more per-process flag
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Felix Kuehling <felix.kuehling@amd.com>
References: <20250306195227.32765-1-Harish.Kasiviswanathan@amd.com>
 <20250306195227.32765-3-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <20250306195227.32765-3-Harish.Kasiviswanathan@amd.com>
X-ClientProxiedBy: YQBPR0101CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::42) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: f1114e07-1664-4023-b688-08dd5cf0aa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTd1MlZISXVCWUNmWUpheXhBZ0tEZXU0L3J3eU1nTURhclBoZWVlcjBobity?=
 =?utf-8?B?TVJScHhydXBqaVRvNEdiNERpdG1aUDFoRm81S0tmaWd1TUpKcnFGbUl4bk80?=
 =?utf-8?B?Q0VZdWZxZWplVDQ0d1Via2paSXc5Ky91T09BMVdiTTNHQW4ycE5SdHZXNll2?=
 =?utf-8?B?UkxIUE9tVTNkMXF5K3M5MDRSRU5QNzlVNXFwVXJqUmU4QUlJcEtIOWlMUmtX?=
 =?utf-8?B?NkxDY2UyQitvdUNMZElMVGFmaGErVXlzZUVmcmw3VDZQYlV0T0p0cmFNSWxZ?=
 =?utf-8?B?OTNqTkVzM1pXRlQrb01JdkhzaFZ5Zk80dDRrTnVBellNdG9tTk5xZXBvb1dC?=
 =?utf-8?B?RlJxaW1PbHFUM3lZUnpDeEdpRjlCeU5xVE1zQStlWnMxaWs2L2w3UXBoWkhV?=
 =?utf-8?B?RDhYQkMzSndoaXRqRHlPNmovZVlpTk12LzlEbkdkWSt3Z205a1M2eFozNndM?=
 =?utf-8?B?azFBVmNVdi9kOFRqYkl2QWQvNktjd3BhQmkvZE51T1RKcGpyRDRVZ2ZDQzZ0?=
 =?utf-8?B?VklSSXhUUXVMWDByMzhhQzU4Zk9ydDhQK3BtQmhKREFoZU8xTW5EM2JyczRH?=
 =?utf-8?B?Mkh6Vm9xRjlmS2xRMUROa0UzbDJQUE5MWHBGZnlWSnRUVGw2YVVFbFUrSllk?=
 =?utf-8?B?WVlnSUdINDVUM2ZqSFdmSm5RV2ZoUlplNG03Rk5TWTZVS01XVUVxWUZha2Nn?=
 =?utf-8?B?SzNYbDR2T2VGTUJaRC9yOFZPenVXZEVVQ3dUVUhpQ2ZUQngrRmZSV0xVZHdG?=
 =?utf-8?B?QlBnamhaODJZeXRKY3dGN3dKRHlra0MrMFdtOUw5enpVVVp1ditPMHNYanVq?=
 =?utf-8?B?aWhUVTA4dHFzNEJnc3RVQ2RmUC82YTNBZ3ZFUThSV3hiWUhPREFRRnhjTnhk?=
 =?utf-8?B?NzhuTmxPV0lKazZEVlRxQmhUWlZSNFFQeEFmZXBIcExDZ1dveVI1TXY2N2hl?=
 =?utf-8?B?QnNVYkNlU3VPL24rOUpsMHU2YWhMT2pFaUZsM3k2aFRkSlFTTURjeGZQaERi?=
 =?utf-8?B?R2NLMmo2UUxpZTBUMU85L24yNFpFQnQ0YUUzK3FFUE1IaDdwc1MwcmczaDM1?=
 =?utf-8?B?MVR5WGNoMGxqTXI0Nk50RFc4V0hSWUplMmxpNU14djVrZWZuRkRtWTg3WWZ2?=
 =?utf-8?B?VURNbWpMK2lrU0xkd00rQVdmaVExRjFGbUpyOWphTkhNOVk4YUV2WDBSS3Nu?=
 =?utf-8?B?bWVRVmFhZmhHeDl6QXljcUFzMGxaTUJiM3VuVkp1RkVvL0RqaDFrMUw2d2Uy?=
 =?utf-8?B?NG5wOVc2QWtQZ3FmOGJlSjJlbWZadGpSYU9iYzhjOU80cVFGVzJTYlJ2djly?=
 =?utf-8?B?S0p2VitGMVVmdVV5M2xHTVZZY0N0T1dvSGkxOUlmMFFNVE9oYlV5SUxwQW1r?=
 =?utf-8?B?T2hvQWVvUms3VnUrV1ZSOUJXbGlYdCsrNEFabzB2MnpCNWhvME0vQjY2N2lD?=
 =?utf-8?B?eXIzQU8rOHowMVprbUR4eFhKY0pvc2lzUmJyQVdRcG02QTJOL29EUTRlNEJE?=
 =?utf-8?B?UmR6TEQwdk5PSHcwRjJ6MDhCU3ZXNWNRTDJPNGJhSEhaWHV2dlVFM1BwVVBE?=
 =?utf-8?B?bnNobG9pbEoxK0t4NUFJSEQ2UGFqaTBYSjBpSXAxR3pZbXJVWndOcVltNVh5?=
 =?utf-8?B?MGhmSmFtbmpIcmxEUWJ3RUNnZXVNVXNJMlgwYWQrbW5yRUUvMW42YjE3MDFC?=
 =?utf-8?B?Ymg1S1VLWXdjWFRFTGdBZWtmelp2Q21BYXNDcHZnOFE2RDhIcmdOei8xMEhJ?=
 =?utf-8?B?K3BGMjZLUzJWNWNQMVl6V1BIMUFjbVc3VnlJUE1zaGtTbzBZcHRZU2JaNjVu?=
 =?utf-8?B?SHRqU2tCTUlwdGZpdDhjbGN4bk9mbWVnUmlMTEx0cUx2bEx0L1E3bzJaSlhE?=
 =?utf-8?Q?4qIsL+ZkteS9M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXZqNEFkYVhCQ3pwOEZuSFJiV3J3UjR0TUJxQW00RFFnaTBvQ2JCZ3JnNU5P?=
 =?utf-8?B?Vml6SzhBekh2QnUvMmFjek5DQ29UOCtib2s3ejhibUZJTDVZbW9KYW1qbWJ4?=
 =?utf-8?B?YTJlNnA2RjN0d0R4alh5ME9HVmRqd2M5ZzlFVnJmTzQzKzVUZnU5QnRleFhW?=
 =?utf-8?B?d1Z4ZkphaUtncXJBYWdYdnl0QWNzWURiOHJWQWdzL2h0b1VWUy9xaDRpZEI4?=
 =?utf-8?B?VW5kTXNDTHRlKzd2ZVF4Mkl2L1hrUm90SWl3REdHME5JTkRKam9YZVk5UlBW?=
 =?utf-8?B?c3FxU2xLdlR6WEdoaitLRlMwMmZlREhjQWpMZUZLRVk3OWpYKzBDc09JMkVz?=
 =?utf-8?B?WTJCWXZyL25JQnJGVDQxa2Jwa2dLMnNQMkxobkxpMkZycWUzdUhaY3RLTUJ3?=
 =?utf-8?B?M0ZXQzh6U0k4b0kxSnV4Sjl5TjA0RThsZHVnWUlmT2l5czdLL1JOZjZ6ZlZ0?=
 =?utf-8?B?R2h6NFZ2S2tzU01uSWd5dHFUczB2TWl3YTBkVlBhZ09ORHRrSGtMc2I1VDA1?=
 =?utf-8?B?Ukk2UktEa3d0UlJkRnhqSWdXRmp4MXN3ZFI2YXJ4YW42a1V5a3lVS09hTWdE?=
 =?utf-8?B?OFArRllWdTFEaWh2eFY3OWdXQyt3ZTJsWVhHZTdOQVh5TGJ6dDdxT1g2dHlV?=
 =?utf-8?B?WTJOYVpmdzZ4a1dNTm9WNE4rdjFuWlBLRThQQ0NWNytpcDVVNDI2SVdXbkZM?=
 =?utf-8?B?ZXRCcG1RZVdlZS9ySkNoVnJBcG1tOVFaSzVUNHoxSk1jZEc2bFZuS0Z5R2ph?=
 =?utf-8?B?MWFVRW5HUmxVc3ova1dqczdML3BVSmkwNDNncFhXWGw4YmhYZXJoNWlQdW1r?=
 =?utf-8?B?ZG40Uk9DdW5YQ05DYS9kWnBWOUQ2MWwwZkFuTDhneFB0UHU5cFBjcXpZR3Fx?=
 =?utf-8?B?dzh5QWRkR1JBRWdkTG9OWGgySGIzdWFaQitrRzR4eERnb1FPRVpNWW1oVm9I?=
 =?utf-8?B?YklPTVkza1g1bUpLbUJQaGRaTW1adEhDazRoQzNDQkdsT3gvaUJIYnJLMGxy?=
 =?utf-8?B?YUJNdGpNSld4WVhpdGRGQWwzbkM0REpXQ0kwcHovNGNiRFJWTkFqMXAzQlNp?=
 =?utf-8?B?NEdxWE5PTi9neURaQkZEaG1XR2hYS1J3UFRseWlZZjQvMmhQQWRNZ285NFNT?=
 =?utf-8?B?Qlh2ekRLM3h6aEJLYU5VRlZ1TG9zYnRKeWNqeHJROXBLSHdpazV6T2tDOS9u?=
 =?utf-8?B?eXRabldKRjNXdnE2ZFB2YUxPU0ZvRmdkWEFYWkcyYzlTb3kvdFdLbmx4cFVI?=
 =?utf-8?B?QUUxenhmeXZPcGw5WEk0TE5NbGg1V1V5eExGREcwU0tGUGppbmhNcWc5dVR6?=
 =?utf-8?B?VlNsWUFKZ1g4UUk4WjRmYWNZTkR6ODREckdGRndYeFN6UmpBUStxeXM5NSt2?=
 =?utf-8?B?N05tS3c0VHhKNWxITWgrLy9yNFJDS0YrWm9RUGJpNldyWithYWN4MjdIUDhG?=
 =?utf-8?B?RVJ1L2dJeFZ2c1UyMkFRMEs3ZnY2c3ZJVjd4aWN4L0N6RnNkUUlac3ZoTlNz?=
 =?utf-8?B?WWFzYlVxYUFuZkwrSndVd0RYeVlvRzM4MFdvaHUzRkFFa1JKT1Zocis0NURr?=
 =?utf-8?B?V3N6cDlncFYrK1FSYkVjYzlncWtOYXRLWHpyUnNKc2lyb1UxL3VOdjhYL3lv?=
 =?utf-8?B?aGRRakc3Q3NxK09MbGxJUFNFQzRhNUZ6QTduOENzOWVpQVVxclNOTGdTT1lE?=
 =?utf-8?B?a0VleEEzMjZKdmFzR2R4SCtvTkNrWUJvWkdjS2xEWElGc0c0bzRRTGYvUFUz?=
 =?utf-8?B?UzF4TTF4N1hxbzJDOWxsVFZTdUVvN2tCanBVRVNHQmlnMk4zemJrU3A3ZG12?=
 =?utf-8?B?ZC9oaG1qM2tkSUhUbGQ0b0ZPV0laOSsyN2F0ZlZYYU9IcVNPckRUSURualc5?=
 =?utf-8?B?Ris2eXBuQ1hpUVhOSFBhcXMxOFNnTHNLRUpCU3UyU1dIUkRlendVd2JvbHVJ?=
 =?utf-8?B?WHVtVzJxZGErMVBza1JPRlFKa0xrTjB1c096ZmJ1WHFTUXRFaCt2Y2hMWm1v?=
 =?utf-8?B?dFpYVURseG5kbmRoWWZYRDFaMnVtZks4eWN1WHM2eW5tM0tFTVVtZzB1YVJz?=
 =?utf-8?B?a200VlVHRUs2K1YwRXlzcUpEdU1EdGRnWXhheldSRXVqRmV4aCs1dXIraFZp?=
 =?utf-8?Q?9K7XpFKDPu4JwF6Ht0A1hR8di?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1114e07-1664-4023-b688-08dd5cf0aa80
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 20:51:28.0182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo2kNvawXefRk5eUUPxxJto5G1VztasWyGXj2fNKaD1zmRYuHsOTyhbbEWfg2XfY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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

--------------akzWSzfCJdPPCTVhohBW7wr3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Amber Lin <Amber.Lin@amd.com>

Regards,
Amber

On 3/6/25 14:52, Harish Kasiviswanathan wrote:
>                                                                    0x9

--------------akzWSzfCJdPPCTVhohBW7wr3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Reviewed-by: Amber Lin <a class="moz-txt-link-rfc2396E" href="mailto:Amber.Lin@amd.com">&lt;Amber.Lin@amd.com&gt;</a>
    <pre class="moz-signature" cols="72">Regards,
Amber</pre>
    <div class="moz-cite-prefix">On 3/6/25 14:52, Harish Kasiviswanathan
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250306195227.32765-3-Harish.Kasiviswanathan@amd.com">
      <pre>                                                                  0x9</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------akzWSzfCJdPPCTVhohBW7wr3--
