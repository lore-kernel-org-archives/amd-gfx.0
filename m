Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87D2E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 20:44:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E17C10E32A;
	Tue,  7 Jan 2025 20:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O3gSE+OD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F2610E79B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 20:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdKLl5oin/IPD3T+aQZgcyynDmXKML+yxNE5FkTd5PZqQODN8TP2XoYBBDdMpPjKfpmSYl5kaVNeYQNIps/Z6wos6m6xBtdh52yN54VKdZD/nahxT1EAL3lln2JncfGkM9uVZ2GV1GfplOK9C5O23boegeaxj0FfWWiQQhUyrvE2Fp1fELkvyiKFMvDrwcWSpuXVOfCDDgwTTw43mvzXDvnrmkm8Cg3rpVyHFXb9SnhtSMNNj3ks6Jb10AWDDtusUvD1lzh0I2xmNIrINh786GFjUHhvKqJx8cY7IayrvzH3MKUdkgFmFYtSG13qjBE5bdFnajVQ5o9FGIRZNXCq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMSLS/yF5rg9zOnNTaPy3qeKGZZsuVQg9aiNFHXzUDY=;
 b=iilaPorHzGj3g4n+bs4OQdtXMrCKcZJSBkG6HrFBazHt+5Sd9QZS0IvncwRuWgkJs9TOY8wnk6pt12iGkjMcRiWmP/R7AcAn0/yLWPNyFYwnujju21WPPakW43B1988/ra4C7ttyoIYYZ6aUURjr8S9ORrDU80dBuivtUAlwIQ+pClyekPgnxQI/Em9BRlRzppThSiUZQeT24fpajaln/+4slu/oZthruf4dLU52nqm4jZpfahgO9rM/9iyuEddZVF2oFW/xzB0p6EYjORUgn2Fyv09c2GfTv2tXUNEr8mFi49EDynEZ8ye7lOjTJ2Kx0uUCjZZ6SPUv4ISelquyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMSLS/yF5rg9zOnNTaPy3qeKGZZsuVQg9aiNFHXzUDY=;
 b=O3gSE+ODX6hGavh/vBD/orZdJd3xumCb09uJsOk2HLyLNn3f36ngbJigMQHN+s8PxZDMFBZcAP1VXeaagAjaVMLlRM9/kHh0/oAED1AJb5FLV4x3kpyV+dT+Ng+NC1XkzSOqKTEtKss81oZRwpwQ4gkJ2cktcwi3Ba81Drj9uO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 20:44:06 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 20:44:06 +0000
Message-ID: <64af2e0d-c3ee-9a51-70aa-215bc128a55d@amd.com>
Date: Tue, 7 Jan 2025 15:44:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250103000644.1398643-1-Emily.Deng@amd.com>
 <40e6b31e-c77b-4d89-a051-215eb4ddff46@amd.com>
 <PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0063.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::17) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 646cfec6-87d2-4078-36c2-08dd2f5c0754
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW5QZXVWQkg1bWh1bjBpdnpWam9ReWNRWXdSY2cxV0xzSWptd0paSzJtU05O?=
 =?utf-8?B?MnppMUNQS3MrWmhINDdDN0t5SVdHaWxva0ZRZWhxYTJ6Qm1lZjhQRXBLWEVJ?=
 =?utf-8?B?YXZnMzV5NkxKVSs0VDRJUldRK2tNM3d4LzFlTERVb2FNOWFzZW9nZkc5R2Vo?=
 =?utf-8?B?YjZVVUgxcElLZ1pJNEx4RmJrbUlEZDR6V0lySS9BcWV2S2JsdXI5RlgwZ1Jy?=
 =?utf-8?B?OGZwNFlBdFFOSEVzUGpoMlVJSWlKalR3cUdER004eUx3dTQzd05Mclp6eFZD?=
 =?utf-8?B?Tzl2Skp3MnNRbWg3THBBMVQ0RzZJWnNDQmpwblh0NWhRUWRveUVndC9SVlVn?=
 =?utf-8?B?MDRXcHRuSU9Bc2hVa3FXL0Z3N2NPTXN1RnFCRmRKYm83NjJReDU2TnlQNEF1?=
 =?utf-8?B?ZEV0Z0V1eU44ZDBLZlFlZDluckt2QmVOZVlTNndZU25zdTBMVTNTK1V1ekhk?=
 =?utf-8?B?VkVpR2NyTEhPeW1aUDlRRzVYY3UzVmVwZVJDWE5ZVTN3QWlCVWQwdTUxWTFh?=
 =?utf-8?B?T2VFVEkwK2I2NFR0a3dLMG1TQUNBam1JeFlYM0RVSFNtNFJERzRlTHpIZTVQ?=
 =?utf-8?B?U0tCQzFNS1RpalpxNFl5VXQwMGk5bmxpR3MxczM4R1cwZ3VBV2dCbkZvTFNi?=
 =?utf-8?B?R2o1UmhIVFloKzlud0I1aHpIZUloVWU0cjB0QXBqMEoxWW0ybHE5YTlpNDQ2?=
 =?utf-8?B?b0lGR1hZRDZzZGZpREQvK3kySStzSkh2UUU3Z1JTV042TTJ2UFZWRGhURnVG?=
 =?utf-8?B?L3IzckM1UVZqVWk0WkRkQytJMXBOS1RuRjVTR2QySkREM0gwR0h0Q3Rvdjh2?=
 =?utf-8?B?bkFtRU5QOHJ3dm5KNUoxSFZDMXZHSVpWSkRvaTlkL0ZkMzhLbTZWdmdHcFpS?=
 =?utf-8?B?ZE43U2pWTnA0bEpGTWFOeFVZS3h0bmlRU24wL3U1OEJqWkwwN1hKcHRsT3VR?=
 =?utf-8?B?Y1FiRVAwclFMZURkWXpHbTkySmZqQVpwQ1FBcWI3SURaVC9PbHNGbXpnMjIx?=
 =?utf-8?B?ejVXcTV2dFpna0JTSk96bGR2WG1kcXZ3MjJkcitZcjFYMk1adGpNTUJsc1lq?=
 =?utf-8?B?NVJhbVBoeXhPR1hUU1hrbTR5WHhLN2p1bDY1b0FKbVlUVHQ1dlI5NThlOWlX?=
 =?utf-8?B?aFNhcnpZOHdsK3BJSm4wVkY3eElhdW5ST2RJT1JHQWRqSXJGSGI1T3VYWW9n?=
 =?utf-8?B?T0FUSXBCSEMxSk01blhRazB3VTVoa1lFL1J5UWk1YVhRVVFheThXc2NpWWRQ?=
 =?utf-8?B?ekV4dVc4bmpqbmFVNmZ4WC8xbG0yazJqVi9Xak1YUEZKaGRYaVAyQ2FRcmo2?=
 =?utf-8?B?MWN1QXdZb1lITXE1a1RYaGFXU0xYRlZ0M2J1NjZ0UGZxcll4UjNkZEVvZlVm?=
 =?utf-8?B?MFFFNmhEZnM5dzE2M29PT1o3WVcwSHNjQXhUSmN6NTJGbkhYTS9vWks1K2lt?=
 =?utf-8?B?NFJwNSt4VWlpUFhRN1YwMXhKcHh2cllZcW5WMTduaytPNWh5b0JGd0pjQmgv?=
 =?utf-8?B?Y2hFZWc5cUMvMFJlc2F4Nkd2R2o4RitqUllvd2l5dUpOT0pndDFkUTgveHVB?=
 =?utf-8?B?K1dOMW5aemZ4Rjl2MXRxbEtQYk9DNnJUOFI5ejYyb0lFRHZTdExyNytORU9C?=
 =?utf-8?B?ZEVvR3JvWGc0SnA0T2dVS1VEeFUxQ3ljN1BkS2VXS05kR2V1ellGWW9DcFcv?=
 =?utf-8?B?RG8vTmNKMmpSOGpEdGdQV0s2dmRkQWhlTUlxcks4VG54ZzhGalRuM1AxVUJS?=
 =?utf-8?B?ZEcyUis2bzl0V2pFQWlUVDkwSHNQWGdTcVlqS0prVmpBL01hRWhwN2VHKzND?=
 =?utf-8?B?N3lUei95MFliZHB4RXZhRnRBU1BsWWVjbWNOeFkvczBRNVpvQTBYVkI1T2lj?=
 =?utf-8?Q?SMHLqzNZBpSWH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0JqU0UzTG5DQ3Baam9FWHZWZzk4MXFOVFNoY3JncEk5ZGR0QVBkVVlpanlP?=
 =?utf-8?B?SmhLMFQxMlBUclJnTTVuSi9INjNtR2V0YW9wVS9mRE8rQ3AwcXlYcnNlMmxn?=
 =?utf-8?B?TUEyelBKZDQ5ZFBPc3ROMHFNS1BETExtZndRWUVVWXZwc3F1Ky9jY0tHZkNq?=
 =?utf-8?B?aDh5RkdvVk9DbUY1aUdFM01uRktBSUcwK3RVNHZnVVJ3UGgvRldRbVN5VWJR?=
 =?utf-8?B?ZTNvZE1QREtnVTlXaWY2N2svZkRORUtQdnlkR2dBemlTaTBlb01sWEc3Z2ZY?=
 =?utf-8?B?dzk3dndDT2FmSmZvZy81RVdDVkRPQ2ZwbWlLdVZnaTRvUHkvMG41NVdKRlgy?=
 =?utf-8?B?WEF6Q2JoQy92dGpPUENxeXVtcCsvcnFXdExkbVFvSHNNbXJCZlJGQkRyRUNj?=
 =?utf-8?B?bDVMSEFFdHY0TmxXR2xuQWNnRDE3cmxycVNJajl1Z25JMFU4M1hDWngrQmRa?=
 =?utf-8?B?emFiK1J4VWdEcjkyVTdoZlYxSHFOQWhZSmd3eE8xODA4b0lqZkhjMVlzZnZM?=
 =?utf-8?B?VC90ZFZhZkJqM1dPcC8waUZyT3pFVVhDRW1rSlVlN05KYlJxSGw3U2F3cjJX?=
 =?utf-8?B?TE5WT0cvUzcxY01BVzNIanVZN0t0ZWZSYTA5cmpkeHRETnllSjhHVTVHYm5z?=
 =?utf-8?B?ODJtZ2MrejJ4dnZ2S0NObzcyYjJWeU83MzlyQ3Z2TnBLa2JmbmIvc3FXc0M0?=
 =?utf-8?B?NUNyako0cUp0V1M5YmhVMHNoUHR4NDlMZTFsZ1RjSFhvUFVBWDliaTZYenVz?=
 =?utf-8?B?Mk5OYnYwT3J4S05CNDN3UVNwSm1uREZOeWpUVnV6U2ZRbERCYzAwZ1h4b0FF?=
 =?utf-8?B?L2VkdkVKUkFYRkpWaUFLZk5NSXhKQ3V1eWNmdWFBRm51RXdmbm5qcWFMMXNG?=
 =?utf-8?B?M1JZbHNHcHFzdUVrUU92dTZSbVRRTytRM09DeFpBeU44NGFvV0VjWXFBMWRx?=
 =?utf-8?B?amd6cGRKK0tQaElxbGRGSUw1bDZMY0w3TTh3TE1iVHF5TzRXTERlSGhHemx5?=
 =?utf-8?B?Wkx0YWZ4dDE1OUpPcVM4NmFaYkdsUDF6eFE3Wi8ybVpyYVhaaythWXg0emdq?=
 =?utf-8?B?cXE2VXVtL0ZtUHpscGZXNTZoV0RjVUY4K2wzMnJaZkhLMmNNWGNtbWVFUTln?=
 =?utf-8?B?QWlLR0h0bTBuQjdOS3BSZ1lvT21ERGRIUDdJMjB0cFFuSmNndVJodlB5S0ZN?=
 =?utf-8?B?WGpaVVZ4WlR0KzFFZDVFaE9jNysyWGVWL2hHby9YMklZK0lwdjQvTE83cmdr?=
 =?utf-8?B?K1ExZ1U2TkZIS24rY1ZnMUcwVENQVm1lblRCcjl4OXRXS0JDQUVJdEwxK3p6?=
 =?utf-8?B?dzZzUW42STBVaS9OOG9LZWZRR1kzWDhRYVZuT0hVNEZNY21CdllKdnJtUFhP?=
 =?utf-8?B?NDV1NGtxQi9jVG8xV1NIQnRYNFd5QXVPT2xUaVVZcjVIdHJBUnhlOElKSFBY?=
 =?utf-8?B?dndWZ0xBSm1SVG5TYkJGNENVVUR0eVRIL3F6aU1kb0FXTU1zZVptc2tGWVpk?=
 =?utf-8?B?clh4aytablhMUkNPODl3NGFZdTRJNjVBOUNtTjA3czdmOHJMdkxoNWdQNTV6?=
 =?utf-8?B?VWExZzhjMXRLcU5kVWZST05OT2RsaC9rOU5mZkJjbzV3T3p2Y0R4YWprVHVY?=
 =?utf-8?B?UHNibmNlNm9MSUJKcnNISDA5VTEzYWxOMzhCTTlxZnVDM0VPOXMwdGh0Znln?=
 =?utf-8?B?V0pyT0ZWTlV4WDNrSHJnK3NWb3J5MmxrY29Cek5ITkk1aFlLQjJoWUVpNFg5?=
 =?utf-8?B?Y0xSd2RHek5WUUdSb0U4SVE0OWhDNGhseG55M1ZmaTkzV01Dc1ZXbG1PQUgx?=
 =?utf-8?B?UE9DMWh1ci9NekNlUUFNK0tSTTd5by85QnFxM0I0WHhXS0xqTjhTcGlSTkVE?=
 =?utf-8?B?TEVSREJTdzVZTWs0RGU5OHhYd1M4TzM4WC8rcVlWRFJ0bTY3V1J6RWRmYmZH?=
 =?utf-8?B?Y2ZnS1ViRG1oTWhxVzgxMmRGMW9PMksyTGhFNCtVS1FZZmZWcXA5bHh6Z1Nq?=
 =?utf-8?B?TnpsRUo2ZlpUcit4R0thanFzWUNFTEUvWDBCbEtYRHhoV0xlNnNpZVZWQlg0?=
 =?utf-8?B?Sm9Vam5kUU1oaHNOa3piT2hoVFRiMy9RZjVJVzk3RnZ4ak5vZEQxQUJ1RWI4?=
 =?utf-8?Q?+g6QU5ICXLBZxN3xsfW4Hd3j0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646cfec6-87d2-4078-36c2-08dd2f5c0754
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 20:44:06.5040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsimksoNBppZBtONkA6DFmGbOzUojiybiZ/oS8gVPDrN2Gorr8X22rP49Pw6sVSG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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
    <div class="moz-cite-prefix">On 2025-01-07 10:50, Chen, Xiaogang
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
      
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 1/6/2025 8:02 PM, Deng, Emily
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
        <meta name="Generator" content="Microsoft Word 15 (filtered
          medium)">
        <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:Aptos;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
        <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left"> [AMD Official Use Only - AMD Internal
          Distribution Only]<br>
        </p>
        <br>
        <div>
          <div class="WordSection1">
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <p class="MsoNormal"><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
            <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
              <div>
                <div style="border:none;border-top:solid #E1E1E1
                  1.0pt;padding:3.0pt 0in 0in 0in">
                  <p class="MsoNormal"><b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                      Chen, Xiaogang <a class="moz-txt-link-rfc2396E" href="mailto:Xiaogang.Chen@amd.com" moz-do-not-send="true">&lt;Xiaogang.Chen@amd.com&gt;</a>
                      <br>
                      <b>Sent:</b> Monday, January 6, 2025 11:27 PM<br>
                      <b>To:</b> Deng, Emily <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a>;
                      <a class="moz-txt-link-abbreviated
                        moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                      <b>Subject:</b> Re: [PATCH] drm/amdkfd: Fix
                      partial migrate issue<o:p></o:p></span></p>
                </div>
              </div>
              <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
              <p><o:p>&nbsp;</o:p></p>
              <div>
                <p class="MsoNormal">On 1/2/2025 6:06 PM, Emily Deng
                  wrote:<o:p></o:p></p>
              </div>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre>For partial migrate from ram to vram, the migrate-&gt;cpages is not<o:p></o:p></pre>
                <pre>equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed<o:p></o:p></pre>
                <pre>migrate pages which could be copied or not.<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>And only need to set those pages could be migrated to migrate-&gt;dst[i], or<o:p></o:p></pre>
                <pre>the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>Signed-off-by: Emily Deng <a href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">&lt;Emily.Deng@amd.com&gt;</a><o:p></o:p></pre>
                <pre>---<o:p></o:p></pre>
                <pre> drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 8 ++++----<o:p></o:p></pre>
                <pre> 1 file changed, 4 insertions(+), 4 deletions(-)<o:p></o:p></pre>
                <pre><o:p>&nbsp;</o:p></pre>
                <pre>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                <pre>index 4b275937d05e..5c96c2d425e3 100644<o:p></o:p></pre>
                <pre>--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                <pre>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c<o:p></o:p></pre>
                <pre>@@ -278,7 +278,7 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;struct migrate_vma *migrate, struct dma_fence **mfence,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;dma_addr_t *scratch, uint64_t ttm_res_offset)<o:p></o:p></pre>
                <pre> {<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;cpages;<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t npages = migrate-&gt;npages;<o:p></o:p></pre>
              </blockquote>
              <p class="MsoNormal">I agree this part.<br>
                <br>
                <o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = node-&gt;adev;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev = adev-&gt;dev;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_res_cursor cursor;<o:p></o:p></pre>
                <pre>@@ -299,9 +299,6 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct page *spage;<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                <pre>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spage = migrate_pfn_to_page(migrate-&gt;src[i]);<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (spage &amp;&amp; !is_zone_device_page(spage)) {<o:p></o:p></pre>
                <pre>@@ -345,6 +342,9 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j++;<o:p></o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);<o:p></o:p></pre>
                <pre>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);<o:p></o:p></pre>
              </blockquote>
              <p>I think what current code misses here is that
                migrate-&gt;dst[i] should match migrate-&gt;src[i]:
                migrate-&gt;dst[i](vram page) got set for page that will
                be migrated from system ram, otherwise
                migrate-&gt;dst[i] should be zero. Your change makes
                migrates-&gt;dst[i] not set though its page has been
                migrated by svm_migrate_copy_memory_gart for the case
                that cpages != npages, because you set
                migrate-&gt;dst[i] at end of loop and use 'continue'
                after migration.<o:p></o:p></p>
              <p>The page migration happens at
                svm_migrate_copy_memory_gart, not migrate_vma_pages that
                migrates struct page meta-data from source struct page
                to destination struct page and has mmu notification.<o:p></o:p></p>
              <p>Regards<o:p></o:p></p>
              <p>Xiaogang<o:p></o:p></p>
              <p><span style="font-size:11.0pt;font-family:&quot;Arial&quot;,sans-serif">The
                </span>migrate-&gt;dst[i] default value is 0. The
                purpose of the change is to match the migrate-&gt;dst[i]
                and migrate-&gt;src[i]. And for
                svm_migrate_copy_to_vram, it only will call
                svm_migrate_copy_memory_gart to copy those pages which
                need to be migrated, for those don’t need migrate pages,
                it won’t call svm_migrate_copy_memory_gart.</p>
            </div>
          </div>
        </div>
      </blockquote>
      <p>Yes, the issue here is we need match migrate-&gt;dst[i] and
        migrate-&gt;src[i]: migrate-&gt;dst[i] need be set only when its
        correspondent migrate-&gt;src[i] page will be migrated or the
        src page has dma address setup by dma_map_page. Then why not set
        migrate-&gt;dst[i] at same time when have dma_map_page for src
        page?</p>
    </blockquote>
    yes, agree, I will reply the v2 patch with this change.<br>
    <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
      <p> That way will simplify the logic and not need use
        amdgpu_res_next to jump vram cursor. <br>
      </p>
    </blockquote>
    <p>if spage is not contiguous or dst is the last page of cursor
      (vram address is not contiguous), we need setup sdma copy and then
      call amdgpu_res_next to update cursor-&gt;start.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:19fac85c-0110-4a3d-a3ee-c539afd518c5@amd.com">
      <p> </p>
      <p>Regards</p>
      <p>Xiaogang<br>
      </p>
      <blockquote type="cite" cite="mid:PH0PR12MB5417A0CED996D52E33D234B98F112@PH0PR12MB5417.namprd12.prod.outlook.com">
        <div>
          <div class="WordSection1">
            <div style="border:none;border-left:solid blue
              1.5pt;padding:0in 0in 0in 4.0pt">
              <p><o:p></o:p></p>
              <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
                <pre><o:p>&nbsp;</o:p></pre>
                <pre> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></pre>
                <pre> <o:p></o:p></pre>
                <pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r = svm_migrate_copy_memory_gart(adev, src + i - j, dst + i - j, j,<o:p></o:p></pre>
              </blockquote>
            </div>
          </div>
        </div>
      </blockquote>
    </blockquote>
  </body>
</html>
