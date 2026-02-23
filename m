Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FF1EF5862
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 05:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C6C410E219;
	Mon, 23 Feb 2026 05:15:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zfyG79zi";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A338410E219
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Feb 2026 05:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cy5Qzund5tU75uM2jlkvtNxhW+6xHXyKX05k6JD4foxqkOex+qMl4v8VVgX0PhgShwvhKGUm8VH+SVza1b/8SGsOj22qy/0ZNTL8k+GkX4f1h0gkSwwW2e/YHm1NCySBTcdcdXlVfk0RM4Phosw8V44cbtt1DchqbJz3fpdfdayq/lj/7KH2oM2sFih+sc75n2EYu4v9VarHUEYdtDQtaKmL5BhJvQdMKL6eITvKrnZTjXI16o/IP6nakozXcjCF4/Gk5YFUKhI/k8jYdxOkoy3uiHQFncV9MzTMLfDLI7KsgPxHCsCdy5tVOw9dfYQwUxxOkwU5Av5xni5sKCGBzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQXgM879yb39Qc7TLAHnv+uUGcD4WBtxtRbKeORJp9Q=;
 b=pUJYr+CZYWMvritPGEClIUUJEK/eQfBr0f0EEoXFbNgQ+OXXruO20g6ZK7ebPU/T0F6kC9SnhNMjOPi6wJyIBHUATFm00qj8ELcFTb3dNkXHgFErlhQKAdWibnhT410ln/rNg274uMwwiqFpERsSmMkPgo9QszpXuYj/8XTsm8HNoEJxNuMs15vr2UH9NN2SlORitvIOFNFxpss9QUzLnojw/0P4pwb9MMiNj+7kqSWp1j6PQJ/G3yq96VYtDeDEHGyTr8/FiwIop5WqaViikeRldOEsxapcXKPVYtrYXf8rJaVWQrIcvaiy4BDvWNJFMRX7VcdlZNvAKA0aF9wRGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQXgM879yb39Qc7TLAHnv+uUGcD4WBtxtRbKeORJp9Q=;
 b=zfyG79zibLmjoIaNW10VQPC0ETFF3DjbgvhU64M9plJmGATUlg3K0anf9oINwv/eH51GM8mS+OCZahNAnaNiuFwqvtXvbqs5t4jLJJJjsi0eiNsMVJeuQJ7r94c6tflBK+ZC6dwJ7PGpMeKcq3XUdSvJvxrH8sFEybbiAkY/740=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ5PPF000ACABD1.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::984) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Mon, 23 Feb
 2026 05:15:19 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 05:15:19 +0000
Message-ID: <916c5d95-5826-4242-8a8e-71b786596488@amd.com>
Date: Mon, 23 Feb 2026 10:45:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: add upper bound check on user inputs
 in signal/wait ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260220082840.2192325-1-sunil.khatri@amd.com>
 <20260220082840.2192325-2-sunil.khatri@amd.com>
 <3c77adc0-d624-45a9-8ed9-6e137968bdae@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <3c77adc0-d624-45a9-8ed9-6e137968bdae@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0027.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::16) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: a3616d0a-6a8c-4c3d-c647-08de729a8942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGRWVlZLWHZZK3FweS9ZVGFRUmhHTXZlTHh3emRmUUNQV2FnSU00VFFvNFQ0?=
 =?utf-8?B?czZxL1gvUU9OUVgrNUhNOWVlclBnYXFncnNpNE5uZmlFdXMxcXNFalpwVVhz?=
 =?utf-8?B?UmdKdVZkOGNoQ3I1Ymp4VElSK2JNMDMxbml5K0dlRHZZM2VPclBKalRHRFJH?=
 =?utf-8?B?R25GcUdZT2RuM1RMam1zNXpNMmhUZm5qZUVlcm5LYVMzcUJvNUlsNWpLeEps?=
 =?utf-8?B?MmNTc0g2OG5IT0hQS0tZZzZIekJSN1JVUHd4MzY5YnBkOCtMMGRKeFp6ZjRa?=
 =?utf-8?B?Z3hHRHZaL0p5aHpoNkgybWRxTlAzdUhlYnpVS3QxOWRrcURMbGYyd0pBMXdT?=
 =?utf-8?B?b1VQWEttU2RkSENFUS9KNlZNWm1mN3VvemlFb0hCd1VnbW4rb1psMHU1akp3?=
 =?utf-8?B?NVNNenp2cXNML2FyTDRyMDNZbG1HK2xEL0N4V2hLRlpYTWwwNVpEVFNJdGsv?=
 =?utf-8?B?MTlkSUtibE56b0d1NlhPdjU0eERVTEZGMmQ3RjZKeDhKMW1qbHVMRGJEZWhI?=
 =?utf-8?B?eGdnYndWYjhXQlhGazRmRFlSNGZNOXFJczJoSFlnc3dlVld0bHBtWWV6VHFL?=
 =?utf-8?B?ZGtyTXV5VFJ5NldpYVppV0N3WWs0Q0syV2Zod09VeDJnaUtxZU15NEFDT1V2?=
 =?utf-8?B?bURJa2k0QS9ITVR2aUowWFltSkRRaGE2am1CcDljVEVEbTNyQ0N2NU5nODZH?=
 =?utf-8?B?VnkyZGtIVU9nMW04WU9vb2JzNTM4QzljeHF6SGFkakhqQ0VqWm4vN2FnL2c4?=
 =?utf-8?B?d0hCQ1JTVVAyYVhrWkUySHM0eUU4WEtGaUVSOFJPTXBxWmxvQmxuQmphdGdm?=
 =?utf-8?B?UW55Tm9GWmprMHdsKzR1TWRjV1I0dUJYUm5GbE0xNHB1ckdzc2JTdXUrMERV?=
 =?utf-8?B?TEF1VW9qRVRkYnlLeStXeDU2ZlRRZTB1MW9rTGZhVEQ0UW8wWmkvL3pJTEdU?=
 =?utf-8?B?dStXSURYRm14S1JITy96UVpWQjRwdlV3d0tCamtDN3JGM2FOLzMxMlB0ZVhS?=
 =?utf-8?B?eUdPazd2emZTRUs0M01iZy91bjdwUnpMQ2p4alBIaFQrWUY0ZlgybU9BMnRo?=
 =?utf-8?B?RGZDK1VHNUsyK0MrazhHMklnZ09ndUtMRzJHcEJjTzZVVkNHb1p6Z3JLU3F1?=
 =?utf-8?B?VDIyamo3UmxlVEJPRGFXdndNekFWQ3V0MzVvSHkwWkxpUGhPSkxldGo3QWFG?=
 =?utf-8?B?OU5oME50RlIzSFg0NXpqZk91UVM5bHo0VGxyaGZvQ1hiaTZBQkx5UTJyR2pG?=
 =?utf-8?B?cUpQdGVCOE9zQkZXNS93RHhlNE1CMjZXbWdQTmhhaG5acm5UNlRDWEdBMUpF?=
 =?utf-8?B?M2lXNFp1UzRDeFJwMWhLRCtLRlB5QlpnTThwbVpadURWNENveWhtVFNYMXp0?=
 =?utf-8?B?NUJwSEc2eVNMWGNCaDJEQ2R6ZWFXWTZzelRZNE13bHZZQkczQ1h6S1VBdVlG?=
 =?utf-8?B?OGVsWnZvZEtCUjJhNTBid0UyMXl6TXQ3ejkxZjM4SlpYWVRDdzBIK2hVZXZ0?=
 =?utf-8?B?MmFCREF0bTh1Zm1SYU55ajBHR29HSEVhOUQxUW9MMjM0MnA2YzFJd0lYMzZG?=
 =?utf-8?B?Q1E5QjBTT2NUZXRLMUlYb0V5c0FRZEs5NnFDYVFmWDEwOFpWeEpRNHYvNitH?=
 =?utf-8?B?cjM5U3M3VnVHNCtHM1czdGNSK0xZcGhaS1ZCWWNQSDFxYWZ6L1pRSGlEQTgw?=
 =?utf-8?B?SzduQjJVS1RVQ0hJc2RKRWRyYmVYbHJGUHFrc29QemxVckM0NXRPaWlxKytB?=
 =?utf-8?B?Z2F1RXoyOGJteTdSa1ZzSzJOZklmeFJvM25TM3lBdEtkZ3h2d3YzZVFCUTh1?=
 =?utf-8?B?ckQ1aWozZjJGQWpFUzdFUnpnMWJXSHZFTHk0eUZNVHVvL3BQMU91Y1RFL1JS?=
 =?utf-8?B?N0pqN0YzN1duQy8zZWQvMkMwR3NZK3RGQlBOcXJxNWhnQlp5NDdYdWE5MnVh?=
 =?utf-8?B?WHExTlRvejFXTE1kZjBydnpWbndIYU4yOG9FS3VZb0R4R0J1N2pzbGZKdStQ?=
 =?utf-8?B?WkRrelBxMXlDaVVVNVBMbUxsakEvaTVSOXBMSTNTMnczVTd3U21FbmhZMitW?=
 =?utf-8?B?MVM1N1RMMjdBM1o2QmFhc2ZXTWFqMUJNUzJvWno2a1Q0ckc3VUF4bVFUZFps?=
 =?utf-8?Q?8U30=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHlsMUxackE5Q0hFSW85S0xsZXU4d0hkY3BJblUwM2xaL0RzTnk5Qmp2TkNn?=
 =?utf-8?B?NDNuL2o2L1hWK3lGL2czVHNZa3U2WVEwYTZ6bU5CZm9LOE8ySExiUnVxczVp?=
 =?utf-8?B?aTBYNm9aMFhFRnBKa1o1Y2owMVZibWhmdndGQTRlczJtNmpXRnUxNVd2Mits?=
 =?utf-8?B?MHBKWS9QZGI5WVFYMW55VXpGdWlvWWhkdHgyS2RlUVJUcisraXFxeTVzM2FV?=
 =?utf-8?B?TU5rVk9FaFo2SUdDZ2UrSHZlZ1lIMHpyN2IrMm0rMUdhenlGWDlmWXcwdmlK?=
 =?utf-8?B?WloxRDgzb2QrSUZac0lWUWNZbGZDRlNFVXZSekpEWTM4Q2pKSEQzUXZOdllq?=
 =?utf-8?B?SHdhV3hSQmFuVm1kNDNzWlpXZFhMLzlmRmt2U2UvQ1lDN3M0dW5vR1JpSWI1?=
 =?utf-8?B?ZXFVN2c0b2pMTHE3TU5wajFKMXpoTDlQc3hDTktlT0g3TnhLNmhTbjZpcVdF?=
 =?utf-8?B?OWtabmlTSDBHaUp2ZE1LeDdSSTVmN3JnUUFYaXdMdmhzOTZJMXJldm1OcDFx?=
 =?utf-8?B?bjdhK0dXLzNkbmptZWQ2eUJqUmtScXU4cVNrZi9OTklSQWRDdUhiSVVlMEt2?=
 =?utf-8?B?RDRTcDlIeTlsemVLbEdSR1RDd2ZJWm9hem1UT2ZiSTVvZ1d5YVJoYmtoOFdp?=
 =?utf-8?B?Y0c0YlM3NHRqc08wRElvMFhaSzV2YXRkam5PRmcxbXRZZlVHbkszR0RHd3BU?=
 =?utf-8?B?WkxhY2lYR2p5VzB5OEk2L0U1SlNPRGxETzNXVkVON3JMWG5IeElpOFpqOUgv?=
 =?utf-8?B?bWorV1YyY3c1TFdCUmNTcUN3RC95ajNXci91RjRTUkRheGJwUTN6UTlaNUhp?=
 =?utf-8?B?L09aYjNjRDRLeVJjUVZna2Z4Znkwajd3NS9ES3VoUmVaRWJqVWRZRnVkOG9R?=
 =?utf-8?B?bW1Ndmx5WmlUZ3RScUgyQUpwc2YzWGVqdDRFeUdacG5PdmhNL2xaWnI2cS9t?=
 =?utf-8?B?c0Q5MUdCdUx4NnQwamd6QXVsVll0SHJobndjVWtwdURpc0NaUlBSZGZmM2ls?=
 =?utf-8?B?enp5UFJHNlQ5MXlTbUlZa3E0cTNaUUVySGZpK08yK3FJQXYzbFlOSVlXblBB?=
 =?utf-8?B?MVZnZVdkU05aNjU4MzVPZms4L09saENOQjkzUHdIckczNS9YQTF0VzhmUEpl?=
 =?utf-8?B?Vm9QeGs2aGptUmgydGxGakNIaWxoaGtIY1ZZYmhQWDNQSTUyQmR2OXU2b0lX?=
 =?utf-8?B?dVRVSjdrKzJteGZYQzRMdjlETEY0TlBkTU43ZzBnbWtMODJSS05TYllFMWdY?=
 =?utf-8?B?RDVPWWRkd0o0TDQ1L2dCWjV6enpGKzR4NDc1Q2cvVkxXNW9xQTcwbWg1cjJG?=
 =?utf-8?B?cTIvL3NBUzlINFF1RTV4c1QzUU1xWCsvakRGMEJDcXNqalpWbzgzR3A2TTg4?=
 =?utf-8?B?SWlvYXdJVGxTbFpkeFNSeDB1aklUbUR1NHlPdUx4Rjd1Z3dZS0x2MldtT0dZ?=
 =?utf-8?B?QUFsRi9sTGpQTHpHVzhnN09SU3VrK0x2VCs5UDMyZWVicHllamt5bzErZk1z?=
 =?utf-8?B?UmdoMlBwMzJzTy90ejZQMTFYSVg3Tkh0QUNtZ245elJMQ2ZlWG9HbkZWVVpw?=
 =?utf-8?B?M3NSaWdjZFhmbXd1UzdiQUNXa0VHN3JPZFl6V3BqRFZvRklRblpJT1FESUpu?=
 =?utf-8?B?YmJXY0RpWHNKbjB6WUZ5a0dYTFVUOUVlMGhMV0lRRDNNeUk1MHBhc0h2VHNB?=
 =?utf-8?B?RmJHODNYbEdnNjJleCtPbWVpdkl5SGQ2Y3c2bVlneFBNbjJRVy92MHVvUlNY?=
 =?utf-8?B?TTMxUlFxS1dYSkZCRzdrRE5jNnZtV29JQTlnWlZ3Y1k5cklLR0hxQW93RXpL?=
 =?utf-8?B?UC9oK2RMMVpYYjZmWDRDMTZGU2xFVVJCNmxYK2lNY3hPUmZqejVOYmdkTXZK?=
 =?utf-8?B?a0ZDcElhK09WeWZ5bTNDMU9JcHJST0p4V1F5dlQrUjI1aGFnU1czNE1ZSXVK?=
 =?utf-8?B?c3NzMlBxNzlHRVB5eFVYejVWR0lKMVhMajRyb3lUR3NhWFBVTHR2bXNPVXB5?=
 =?utf-8?B?NmladzdBTGZFaVM2bmtYakpEQWc5UEl1NXlPSW9NOFlzUEt4bFFsMXdFVFpN?=
 =?utf-8?B?Vm13TnljWTRRTzJhcWZFU0FVcTdKUEdVV01CajRkZzgrRlJlcnB3cTkyNms4?=
 =?utf-8?B?UFgrR0cza2ovaDgzYWRtRHdiRFdma2pPa05VVGVvTkdIdE9uZUdXL09OeVNu?=
 =?utf-8?B?ZkJ4OFVybURva3pBMzR2ZVZKeGtyeThiKzE2clozbThqaU80NytnL3YyV28x?=
 =?utf-8?B?TGtmdC8wL2lZSUFqZVI4YlZxcDhidm9JYXkvaUpNUmRYZE9KL2lmUEFHWi9v?=
 =?utf-8?B?M0lDOFZ4QkJlS0VmOXI5RE4vNllhOWhSUEtycExPNUEzRXpNT21yZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3616d0a-6a8c-4c3d-c647-08de729a8942
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 05:15:18.9733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7i+HA6CoMOwA6f8Z47I1Dzq5iDowOlETIigdDDFO/RAWkwWuOfb2dNcGRrlKwJQzjnd/tlB24LjV7sFGqUYD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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


On 20-02-2026 07:21 pm, Christian König wrote:
> On 2/20/26 09:28, Sunil Khatri wrote:
>> There are various input arguments set by user in the signal/wait
>> ioctl which could be a huge value eventually leading to a OOM
>> condition and system crash and could be exploited.
>>
>> So check these input value against AMDGPU_USERQ_MAX_HANDLES
>> which is big enough value and also to avoid out of memory
>> condition.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index a6eb703b62c4..b9810313c5ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -35,6 +35,8 @@
>>   static const struct dma_fence_ops amdgpu_userq_fence_ops;
>>   static struct kmem_cache *amdgpu_userq_fence_slab;
>>   
>> +#define AMDGPU_USERQ_MAX_HANDLES	(1U << 16)
>> +
>>   int amdgpu_userq_fence_slab_init(void)
>>   {
>>   	amdgpu_userq_fence_slab = kmem_cache_create("amdgpu_userq_fence",
>> @@ -480,6 +482,9 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   		return -ENOTSUPP;
>>   
>>   	num_syncobj_handles = args->num_syncobj_handles;
>> +	if (num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES)
>> +		return -EINVAL;
>> +
>>   	syncobj_handles = memdup_array_user(u64_to_user_ptr(args->syncobj_handles),
>>   					    num_syncobj_handles, sizeof(u32));
> There is actually the helper function drm_syncobj_array_find() which should handle all of that.
>
> If it doesn't we need to improve that function.

i checked the above function and i dont see them handling the maximum 
limit on the no of the objects in that
we are doing the same thing in that function i.e based on the count we 
allocating memory and copying objects from user.

If we want to limit on no of objects a user can send that we need this 
change as per my understanding.

Regards
Sunil Khatri

>
>>   	if (IS_ERR(syncobj_handles))
>> @@ -501,6 +506,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	num_read_bo_handles = args->num_bo_read_handles;
>> +	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto free_syncobj;
>> +	}
>> +
> Same here, we already have a helper for that. I started using those helpers in my patch.
>
> Maybe just extract that change and apply it separately.
>
> Regards,
> Christian.
>
>>   	bo_handles_read = memdup_array_user(u64_to_user_ptr(args->bo_read_handles),
>>   					    num_read_bo_handles, sizeof(u32));
>>   	if (IS_ERR(bo_handles_read)) {
>> @@ -524,6 +534,11 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	num_write_bo_handles = args->num_bo_write_handles;
>> +	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto put_gobj_read;
>> +	}
>> +
>>   	bo_handles_write = memdup_array_user(u64_to_user_ptr(args->bo_write_handles),
>>   					     num_write_bo_handles, sizeof(u32));
>>   	if (IS_ERR(bo_handles_write)) {
>> @@ -666,12 +681,20 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   		return -ENOTSUPP;
>>   
>>   	num_read_bo_handles = wait_info->num_bo_read_handles;
>> +	if (num_read_bo_handles > AMDGPU_USERQ_MAX_HANDLES)
>> +		return -EINVAL;
>> +
>>   	bo_handles_read = memdup_array_user(u64_to_user_ptr(wait_info->bo_read_handles),
>>   					    num_read_bo_handles, sizeof(u32));
>>   	if (IS_ERR(bo_handles_read))
>>   		return PTR_ERR(bo_handles_read);
>>   
>>   	num_write_bo_handles = wait_info->num_bo_write_handles;
>> +	if (num_write_bo_handles > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto free_bo_handles_read;
>> +	}
>> +
>>   	bo_handles_write = memdup_array_user(u64_to_user_ptr(wait_info->bo_write_handles),
>>   					     num_write_bo_handles, sizeof(u32));
>>   	if (IS_ERR(bo_handles_write)) {
>> @@ -680,6 +703,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	num_syncobj = wait_info->num_syncobj_handles;
>> +	if (num_syncobj > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto free_bo_handles_write;
>> +	}
>> +
>>   	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>   					    num_syncobj, sizeof(u32));
>>   	if (IS_ERR(syncobj_handles)) {
>> @@ -688,6 +716,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   	}
>>   
>>   	num_points = wait_info->num_syncobj_timeline_handles;
>> +	if (num_points > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto free_syncobj_handles;
>> +	}
>>   	timeline_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
>>   					     num_points, sizeof(u32));
>>   	if (IS_ERR(timeline_handles)) {
>> @@ -750,6 +782,11 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   		}
>>   	}
>>   
>> +	if (wait_info->num_fences > AMDGPU_USERQ_MAX_HANDLES) {
>> +		r = -EINVAL;
>> +		goto exec_fini;
>> +	}
>> +
>>   	if (!wait_info->num_fences) {
>>   		if (num_points) {
>>   			struct dma_fence_unwrap iter;
