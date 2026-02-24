Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F714EFB81A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F51F10E51A;
	Tue, 24 Feb 2026 08:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9rGQ8l1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014CC10E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:56:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzGA93/TPRYc7Ucdg5Im27/Y+wvRtQK9EZ/WlUSNlgf9S69tyNTueT4RqguUjyEBGUAhD+EVpfA6fAIRB/1vOAMSkaFERV7/DteLKscIYkrNFSY9cH65elZG07tOsIF31toqMgqYQQ2//59Vl7o4Mx0UM0K0pQLSJSmr64gSxaTI7sF9O6MDYudyX07vD0vQiMJfqJOXvZ/xOSprf1fbtj/Vsg3dHVltBvi0Y5muE3/o3DQAGhlc7JTffYMVGzX5WANGAET4m68T+oYaJLOqUqy4b4lMYOoNMzPZl3N/x32N+gkRgicGVHoG4eiJwbY1W3zVJ4xdnk+SfhW59fdk8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PutatCuIwQ4YehnV9SX/8VSb28XLSgbqLw4or0V1jtU=;
 b=zHm79OfTW5RbB2csQQviByvv+emJfBccESmMU4ZZq0RKx8vveNrHFyMhjE5dguOSgxzONrSamMktA00HMlksAX3OMArHrNNonZfCvnvuWxLYlubVtPSm6M4qjA3jNciPZPdz6WUfACvQhSr8WdutGLGSzoO3khCqV+9wHta9Cn/VhyGBrKu2cv1I9zYK1oXmVBBuemOoQIyoXb1QVp1xbNcKYwNKcWvh8J2LaGlsidbm02aoLVNaaJSFc8MwEJysreITZ/Qqmsuc/xG6e1Q92eP+BD3m/JJxCFVXZkJRP+Gu1F1aXjED32nOL+dHvLT7S9bbQgVXq5m8EM6u36Chhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PutatCuIwQ4YehnV9SX/8VSb28XLSgbqLw4or0V1jtU=;
 b=D9rGQ8l1Kso1YljDJZnRaWPEp7hQoC1PqL1nxGfGCLiOt2S6Q0KJfzmLov5yk/f9ykHVqnJ00ft5C8e0zqmPCj/ZMzg0wie/UNe32UCmrlG5uYdoKospAMRlzfBRvvR0dUw3ztDIqaHfuy4/i1k85NSQAdWlzqtCgzYMT2bjaVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:56:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:56:10 +0000
Message-ID: <98983ad6-fb66-483c-9640-f490ab2527ab@amd.com>
Date: Tue, 24 Feb 2026 09:56:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: add upper bound check on user inputs
 in wait ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <20260224082443.4002292-4-sunil.khatri@amd.com>
 <2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com>
 <ed4ad63e-0e09-4cf7-b3e0-5154053dc7a1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ed4ad63e-0e09-4cf7-b3e0-5154053dc7a1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5d9440-4297-43c0-a2c4-08de73828e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1N4STVjL3d0Z21udVRzajI1M2IveG9Pb3NXeURHTFJzdSs0NkpjU0lpL2g2?=
 =?utf-8?B?eWJ1UDlBck9Udzg2NFlVRk1CeE00Y2l4dFNHNEdDYThxZnpyaHkxcUw5ay8y?=
 =?utf-8?B?U1NHWnlDSEZPRGpLZ2NodHlwNzRSL2JWQm5WVjMyTFpWL3c1OURKT3ZjaStS?=
 =?utf-8?B?d2RidmJDdTFKZk50Z3F0ejdycFRWZmVmWjdQeWlGdEJObDVVaG5ubTJIeWUz?=
 =?utf-8?B?YkMxM2tyQzFPa2xOaXUxbWNRaUhhMCtrdkJ3ekhTN2JlRk5sQjNrbTFrT0wv?=
 =?utf-8?B?aUlCVDZ2RG15NU92RjBXTnlRNy9aNEg0TXRpYmZ2TkEzZmUzQkFSR0MzcnAv?=
 =?utf-8?B?N2lIS3JOZm5hdVQxMEZVbUNpQ29PMEN6QkZDWjZGN0cvV2FvWHREOWNIRXll?=
 =?utf-8?B?OTNDVUVjdG0yQlZUVnk3ak1rOFJhRVY4VXQwUHpKbGwzU0JuaDdyWFBqTHpv?=
 =?utf-8?B?cEcvVDkxc3VRZ0xkRFh5N25EMlVRR2tQbTJHSVhnU2VJVC9NeHdpSWZiREUw?=
 =?utf-8?B?djA4QUFZT0NQbnpkR256elVzRE5ybUVqNjFGWEZ4S2tzVG01aERTN29lV0t4?=
 =?utf-8?B?cVhYNmgyRFJ1ODVDWG83a3FwMXovVHJCb2FENmE2NFROOStYOXlIaTJxNndQ?=
 =?utf-8?B?RU45NjNHODJueVZ5bG9ic29xQWpnTmYwUmk0V0E5cW0rTDFTSTZQcVlqSlZh?=
 =?utf-8?B?aERObUpvcE9NRXRwMWw5RmRIS3JaYklQb1NVbTNUR1Q5SS9IdFNBVEQrbHRG?=
 =?utf-8?B?R25ockZzZDFvVm41MmFPTTBSaVIzMS9XdElTRXVRL1NMclJWVTZ6SGNsdk9s?=
 =?utf-8?B?RXkyZUMvMVlSeHMrQmRCRkh0VmJxQjRqZGZWWVExenRWSXhkUDBBTTV5WTdw?=
 =?utf-8?B?cHRPdzg0THJwRTRSZFZYVVkrNjNyZjlPTEFpMi9malV5UVdjTkkxTVdUVWpM?=
 =?utf-8?B?SEV1Y1lIYmtYVDN0YU1kbjhjRTV4SmJtaGlIelRrNWFjVkVySm9zTFFSU2U5?=
 =?utf-8?B?YTI2SUlrSmF3aFBuWkNmbzdOVzEvOFZoQnNNRkZHNHZ6YmRGS2VOQkJyUGpH?=
 =?utf-8?B?Uzk0TUdNQnQ0RXg3amszcVJXZk9Cc3lEVS9pVG9INjZXUnIvamt5SWhhdDhS?=
 =?utf-8?B?UHh3MjhsZ0pqZHA5eGpYR2Vka2Y5Uzhibm9OdndJOUdHSHlvTThnSlVrRlpW?=
 =?utf-8?B?Y3Axc1JYczRBRnBZVEZmZVVSS0RCNFJDYms0cDlXYWRPZzN3TXpiYlI0VzlR?=
 =?utf-8?B?dHpxQmQxcVZkaGZ5c2Zwc0RWV3hMOXVrMGlYajlqN0pEcG5qNkVpTWMrZ3RJ?=
 =?utf-8?B?VmM0a01MQ1BnaTlaVnM1b1BoMVhRV2FQMGk0cGVxZFhuUkdPZVE3bElUT3BZ?=
 =?utf-8?B?V1hOZkpnNmdHTHRQcDA1UGRBQ0c4RUtDdVZOOWtOa1cwWnp1L3hoek9MV2ht?=
 =?utf-8?B?cUtYbkFEZCtrYTAzL1cveUZzRU1waWV6RTlnU0RYbnhOUXhGUm8xNEtmNVRK?=
 =?utf-8?B?dlQrSnkrMlBUdEhCNnNacEw5UUFLY25MN0pjUEIrcEVWRTNMM0pQL3NheUIx?=
 =?utf-8?B?QlhXS21FYTVHaGtrQVdhWGFaRS8xczVTbnIzVUJ5eSs2eVFLQWRLN0FlcG1z?=
 =?utf-8?B?VjdYWlYrbU1UNXRyZWpENlBsQ0VmbUtoOUpmdmFvQUNDU1pDOHdKWkVuUk5r?=
 =?utf-8?B?UVArTS93VUZ6SFplOXFxU01vbmxxbWs3OUZHdWJ6WkQyNnY4UUR0bTMvUDNS?=
 =?utf-8?B?S0NIaFIxL2hyZ291d0U4UXJoaUtWWk9Nb1I1ZVBOZGhGRVJFNy9KYllKYndq?=
 =?utf-8?B?VWw0SER5ZGpMUlVVOEdsckcvR1FrMk1vZlMxZE5rNWRzRktrUDJiMVF3UmE1?=
 =?utf-8?B?YjJmT1NhVXNXVmUvQjFmTGdjdmhBNWNQZDVuSlFFbGdEYXJLcS9hSnpheTJ6?=
 =?utf-8?B?aEVkWXZ4Slg4VnNwcmY1bHNqTWw4R1dBeHNkSTJZTmlmYkgzMWtURkpvN0dT?=
 =?utf-8?B?eDY1QzZsa3poM0wrNWpCRHhxaGlxajhCTWVnMTMwRkdhaU1mQTNXWFFlYmU1?=
 =?utf-8?B?MmxJMlpNV2RaZGFBZ2xrVitKR2FJSkFXWjE3dkhCbHQwTGxSRjJZRE5sbk9H?=
 =?utf-8?Q?Zsws=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE1kQWFDZCtkcGxmZzIwbnZ4SDQxMXdqS0lDVDFiU0JxalRXSytySUo4RGly?=
 =?utf-8?B?am1lVDIwdU80YkluZHc3cGxWNGNiN29NdkRsVUFpZCtYYmNXUVZqdThsQWF1?=
 =?utf-8?B?Ti9Ma3AvODFGUXNOR3d0aWUyOUowbStIaHdYUDY4dUNvT3RJNDdOWEJYT0N2?=
 =?utf-8?B?TVlZVllhTlI5QzRoNmhuMWNtOElQbkpqbHgvRXRtZlBWcUZ5dlI3WXpOdmEw?=
 =?utf-8?B?bjFOTndJZHZlRXp4Tm5SbmxzVUhjZ2VSSEVlK3dnWXE4eldPSSt6c2xUNVlr?=
 =?utf-8?B?Z0tSS0M5azJHQ2d0cVdEWFA3dVJtS1FEOHlmeHd0Q1RTSHB4ZFVsU0REL2lj?=
 =?utf-8?B?NktPeTloTkZ1eHRna1U3NEYrSGdqWjlPSllkQW5YVUF4RnBvMk1saTJKU1BG?=
 =?utf-8?B?UVpKUC8yWTVKOVNYczU4b3FmcytpUzJSNjVwTTExZ2NLWXhCWVFoVHpQbEVI?=
 =?utf-8?B?NFJSeXh0TW81Zm9rbGZZRGlCanRYQVhhNm1nZGpDSDMrMVpuOVZGOGQzL0M3?=
 =?utf-8?B?RTE0Z1BYOEtZaVczMnh3WlN1YVBUY0JsWnpXK1NBaUF2SXArV0hzdnludTBL?=
 =?utf-8?B?SXZKMXNGQjVoWG5qMzVPZGhKZXNPcjBXTlE3N1lqd29yYzd1bXpDRHZEeFo5?=
 =?utf-8?B?ZW9VVVV0TVR0M0NvZkg1K2l6V3JKL3ppUEVPMXExZWltWkpkRVg2amdCUERP?=
 =?utf-8?B?aGx6b1ZCVFVnaWhvM3gwV3B2MlZIMStuZ2orRWpVTjB3K010b2JnZVgwYWVH?=
 =?utf-8?B?REcrUS9DZHJ5aXlZOW9WUmJjYU44aElpaWFMV3ZCa1AwT2NGN2JQaDJEQzUv?=
 =?utf-8?B?UVJFSE90T29ObWFKamZQbTkwem9nM0ZRTnRtdmROTTg4V28zV3lTNHpzTGhn?=
 =?utf-8?B?TU1XZEViSVExTytaTWJHMk1kemdSTmdzZkE0WVhub1cwSkVUSmJ2RFVvL0hU?=
 =?utf-8?B?dkdab0YzY2k0RVk0MENNMjJ1Ky9PVlJtV3lzRC9yOFhUMENPMGtGOVdCTkJS?=
 =?utf-8?B?bE5Rc2VXUk5Ydlg2UVhnd1ozdWMvN1lXZ0o0alpUVjJqcjJId09Mc2RvTlVZ?=
 =?utf-8?B?K3hBcGF6a2I1STNjRzFKRSs3aENqdW00RVlqQXpaZmx6N3dncTQwdTIzTzls?=
 =?utf-8?B?RTJYYUUwSmNQQWI5MmNNWlZBYy85dE9KRFZCOXVkWkN2aXEwU1VNQm16K0ho?=
 =?utf-8?B?anBZc01jQTJyUDF6VU9FZE1GQjg0Wm5NMGNNR0dUT2NyNmxrTEozelRNcWhG?=
 =?utf-8?B?YUNNSmJVVS9DUytuTmZuejBxbE9uRHdCRko5TjVaS2hrTzVpZ1EwSXpwc2Jx?=
 =?utf-8?B?NVlrc0JKMHE5OEtqS3U0QXpOMkU5M2lkRDdtNElTVVg5dkdQbFRjMWpIMExG?=
 =?utf-8?B?L2xVQTVsVXovemJLWkYrNUxwNzkvZVZRb0hwM2s4SnpYOTgyVVhnNHVFUWo2?=
 =?utf-8?B?elRWVU05RWhPTG9yWTQvNFdMemU2Tm83RjhvNUtnWHZzeUFpTW4vQ2c3My81?=
 =?utf-8?B?UytDNC9BT25TSHlzU1RMaEx0SVRyR05PeUJEMWpFTjBHMGRtSzNvSWptUGZO?=
 =?utf-8?B?QmlsbHF6MndJbHROVVo3TFp0UnRmbS9EMVVkejdJcVFmNkxlNUNYandXbWtD?=
 =?utf-8?B?L2tjNGcrbnRYSTRzd1pLZ0JTRFIzYzAzVUk5bkh3eXRNVkYyZ2l1UGEwdnRv?=
 =?utf-8?B?cTJSZHM4aHJOK1B1WEYzS2ZCdGp3Zzl6eDVwa2VqVlEyVGdSMlNSWGhMaGJv?=
 =?utf-8?B?K21aNlVRNkY1cGh4V1JMNHB2MmFSQ1lnek82bTZWUFdFV1ZQMTVZTk1tOWdW?=
 =?utf-8?B?aUxqM09LMGkzSFhLeWxZVG5qSyt5ZmMwV1M3UkFxYzhqcnZzb3VxR0UzbXRS?=
 =?utf-8?B?aWppcVpBV1gzOXB2dmRVaEZ0N09jR0hLU3VWelBCT2JBZ0NNODRLNktoVkgx?=
 =?utf-8?B?ZkdnR1B5Unh2bThWcHZENUkwVEhndUprR2F5a0cvcTdVc1ZNbFRhSzZEaDMv?=
 =?utf-8?B?V1ZiMklrQ1VCNTdoY3d0N2g4RzRoWlgzZlR1TFE3ZytPZnptaEw1SjNFRTAw?=
 =?utf-8?B?Wmt4c0xOSTF5dERDbFZma0w2bU9GTklCUUxvUTFYbjFxdVh0TUhRcGpWaGJY?=
 =?utf-8?B?WlRSVzN3bVFZNVBGQmpGUmpGdVFhaHIwbHRBeHN3ZnMyWFZQMk83SFR2ZFVp?=
 =?utf-8?B?MThMVmQzNFBTOUt3YkJSMzFpNjhLMUhoTnZaQ2tpMjVFR093dnk5VXh5Z1dY?=
 =?utf-8?B?M2pKYXFGSHpSMDBOSDdqSjhBK0FRdkt2Um1Ma0x0amJuWU9GTFJtSmx2cUR1?=
 =?utf-8?Q?hyxX6TQiioHQrLck0o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d9440-4297-43c0-a2c4-08de73828e3c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:56:10.3848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RImqkwDXMb6pEBfM2aJTB9iFN1FRhiPhKcBDYUEPQjfrNJr5Nt/2KuILXDRJzMO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014
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

On 2/24/26 09:54, Khatri, Sunil wrote:
> 
> On 24-02-2026 02:15 pm, Christian König wrote:
>> On 2/24/26 09:24, Sunil Khatri wrote:
>>> Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
>>> could be exploited.
>>>
>>> So check these input value against AMDGPU_USERQ_MAX_HANDLES
>>> which is big enough value for genuine use cases and could
>>> potentially avoid OOM.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> index 4f9386677c47..c2435ddfbd49 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>> @@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>  	if (!amdgpu_userq_enabled(dev))
>>>  		return -ENOTSUPP;
>>>  
>>> +	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>> +	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>> +	    wait_info->syncobj_timeline_points > AMDGPU_USERQ_MAX_HANDLES ||
>> That here is wrong, syncobj_timeline_points is a 64bit VA pointer.
> Right, but do we want to set the value to be much bigger value for this ? 

No, this is not a number but only a VA.

>> The number of timeline points is always the same as the number of timeline syncobj handles.
> 
> So should i check only for num_syncobj_timeline_handles, or its ok to check for both ?

Checking only num_syncobj_timeline_handles is sufficient, syncobj_timeline_points should not be checked.

Regards,
Christian.

> 
> Regards Sunil khatri
> 
>> Regards,
>> Christian.
>>
>>> +	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>> +		return -EINVAL;
>>> +
>>>  	num_syncobj = wait_info->num_syncobj_handles;
>>>  	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>>  					    num_syncobj, sizeof(u32));

