Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2436CE7E0BB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 10:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEED10E3BC;
	Mon,  9 Feb 2026 10:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ndx65wQ5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8729410E3BC
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 10:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NK0a3XJM78BB1O7YB3/07NaHTMGATiQlZ8yCkcfBvghUWHuWC7sjwdhFLbTZ/LdgVPs2WnWsB/UIrbGzNBEUz+Wg41gnweojpuq/tSJW98saj3o6nK0CQNPc3SGH2p5w3+Ttzmfm5yNOE9gtrMc5WLTtONj92le1yMohPHn9GhzRW6Os+fbFM6r5yFBjrx3DGVpQDCGqrkFdUrYUU2hI4h9rC4iYMIOyInCCabNM54T7xifFy+uTCrP1Ahqfh6DaWQtinPa+ofSQ+EfAxB/pZx7PHmc8WtzeY3FaljocSrFHKfdrExbtARYVdw5qGELvhuiy3Xp02FB7ilcha5NNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hctjd+fuxFH9xPYcnEJshTDEPD4YfhiYmIOTLqZEBrA=;
 b=lDSCQ/xIvhbEhd94GgRZwgxS0zurPllVZoGn672oGBdClTMNehY/JPof3X+HArfGt1hGShLCgd4GhFBr6ckPyWcFW6awfdoOeXJGuc9IlU/QAi2fVNBEnrO+p00T59nzWcQcAnp07OLWFt+UiFBDi1VIfjg+BXtSI1L3qz5TDt6r6uf3Phc3CwI31KXg9gh8eR2iTz44FTex4tjMUIV6EDIu+jxTgjYG0aEQpcKWy10hVCeSlgnM+5YLnbFwjKzk7T8KbfNovi0GssMsYVt6I6LPItz0YX7ckDtUN3JMqgmRgdhYVqE/0e46NqPqtdYJpiIxm/+ztcNxKkePNg3McQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hctjd+fuxFH9xPYcnEJshTDEPD4YfhiYmIOTLqZEBrA=;
 b=Ndx65wQ5UGW86+F2m3MqKoTp7z+LSB/MwuqR8iLEaLlZEIXqdLhHh+kiq3dFVUbEweuW3zqwammrjCmYa2wEl5kdI3a9DVs8hJvs0sHkJuHM3YjA7b4z00/QbwrStMWAwBE3EuoMkf4vPWifzS+l+cuc5ZNwIh1eG7S0Oymzblo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 10:20:47 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 10:20:47 +0000
Message-ID: <509e0504-4f33-4e0e-aeed-a62db8a84018@amd.com>
Date: Mon, 9 Feb 2026 15:50:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] drm/amdgpu: Fix is_dpm_running
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260209045649.59979-1-Pratik.Vishwakarma@amd.com>
 <20260209045649.59979-6-Pratik.Vishwakarma@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260209045649.59979-6-Pratik.Vishwakarma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: af0b4da1-f56c-4786-a0e2-08de67c4e445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDNBQTRFRkllam5wNTZMcXJ5dFRURVViTkNuaW9nQmF2Q1pEcTh6cGZLeE85?=
 =?utf-8?B?OExmbGJwU2pVcFlLNzBjODVnajEyYWFSZkJ4TGF6bEdDNHBvbnBramh0UGtn?=
 =?utf-8?B?RmMra0hlbXRHWkx0dGpBanpSQ3IzQUxJMm5pRnlLTk5oQmVGNTdnTmxicDBP?=
 =?utf-8?B?OVVFSkdNQThZalB1MG9FVDV4VmdHSVh4SFB6WDFyay9vb1ZQNE83TG1EYXV4?=
 =?utf-8?B?cy9PaElSSTU4Q3VleENTSS94NjhtNHlZZGJ4dldSUnJWazZuZlNDZXdKaVUx?=
 =?utf-8?B?eURSYkVBcE0raFRVdHhLZGpORlQxVjZRWnVhZUE5Yy9BYXF1VnloM2NDNTJS?=
 =?utf-8?B?WW5sR3ZPc09xVFVBcVZBYy8zUzJPV3dqNEVyN1d2L1VHakZWb3B0dzY1YUo2?=
 =?utf-8?B?bkRYVUE0VndnM0cyVlArOWs2MGJMbTJIQzZpdVNXZjVnYTcrUC94TG1tNXUz?=
 =?utf-8?B?Q3p4cmVUZnV1cVJ4RnhmS3dtOUlVMzR5VktyM0lnTUllME1Dc0Q5RXd1cVBE?=
 =?utf-8?B?SWdFallySTl2Rnlhc3hRdWN1YXAyWkEySWpXTlNMZVBaYVRtM1BRbUdwY2JO?=
 =?utf-8?B?bUo3aVA4aCswWW1WN2pLNG55anhvMHZuZWpPMFIwNCt3SXIvZlQ1ZW4rZ0tV?=
 =?utf-8?B?RklyTS9pc1BwdVE1RXlKalNQak9aWXMyRStweVlrNTRvQnluU0VGbkdPdjl3?=
 =?utf-8?B?Z1Z2TnZnMGNad0VWQVJSLzBySTRzVjVkV0VmVzFpWW4yZm5DRlY0eVl0aHhU?=
 =?utf-8?B?UGpFOU1uN24vVXl1T2ZDNDJpdnI5c0FYdDF6dHJoaS9uMzB5bDBXWmZYb2Zm?=
 =?utf-8?B?QjhaZnV2TlVUSHFvU0k3Z2c5cnJMb0dGYlRxSUZXRGpiUlNUVXRZbzYyV3VM?=
 =?utf-8?B?K0J1WlFrNEpxQktnMHNvcUZYU0VmYi8wSFcwSHE2MUtwSTd1OGZUUXdiQlk1?=
 =?utf-8?B?VnpSUEFWM0hBNDhIcWZlYmVlaGlPcFEveWs0a3pJcVhKSjUvTnRwUWVub2Rz?=
 =?utf-8?B?QUtZVG9ITTJHYmZhMTI3TXNPU2VSNmxOL2pydGxKNEczdWJTWU1sMlZLK0hO?=
 =?utf-8?B?OHpBMmZTWTduaDZXcENXcDVBTEdtQk1JUThvRVQ2VFU0OHk4OVZESFgwdFZn?=
 =?utf-8?B?ck5OY0RZNGF5eHM0MUN5RXRuYnE2V3JlOStlVlBjM2cvTFJxUlRtUXV1bzBl?=
 =?utf-8?B?UW9kMzM4cGZ4WFVjMTVtNG1MdU5DdHhKU2ZFSXFNRkVNZUp0elpYQ2NyRVN0?=
 =?utf-8?B?SWxtQ2JDZzNnWlUyOWZIWXBwUXdtdHE5Q29URkRhaHZtU3F1Wm1JQmpzR3Bk?=
 =?utf-8?B?MjRyeFVQYUtRamlSakwxblpXY1FTcDVrSVhKeEdSWVdVcWNyanViTmppTVVV?=
 =?utf-8?B?TnltN0Q4bHNiV0VuL1lEWklhaGJ5bWNWRkRrYkx4anVWT3Fxc1UvczN1Z1RR?=
 =?utf-8?B?b2J2cGN4bjJYT01pc2RyQzZkQ2RJcUd4cmZUR09hbHFIemZuTUJOZ1haNGFj?=
 =?utf-8?B?aytsYVZWVTZzTEhYTEppb3JkdzJBS1dyb01FeFB6dUtmU0J2Njc3ZTFUMEpX?=
 =?utf-8?B?YzYyVG04RHNxQy9jaElteXdGMFFqWE9uaDZuMFFzalpVUUZ2Mkw2Y01mNllt?=
 =?utf-8?B?dGYrTU9PVTRjd3FqUUhLMzlIQStZdUZRNE9tSjA2U1RVV2Z2WVVzc0lLUkto?=
 =?utf-8?B?MG54LzNvRlpNV1ptTXJzRTAwei9pUG93aWo5NTRiWGVZbzFURWROVHZrWkdJ?=
 =?utf-8?B?eFMrZTFJUmhib24xaXhDbXhiekc1ZzdGcVpOUDVmSnU2VEx5dTMxM3ZpeEli?=
 =?utf-8?B?bHJOcjFXWDFJUGhLMWFZS2pWWDYwczVrV3hnOXpNcUFPaG1aOWVMZzYyOUJu?=
 =?utf-8?B?c3NVS1pUSnluUlNEVlp5Y0pzRzBidktTaldVKzB3QzJEaVNPSE5kRGZIVjk2?=
 =?utf-8?B?Z1g2VUJ5MjBGQmpBamxwZGVCVjVHS0JEcmlwbVlYT09aMlNwVGt4NUFaNmRU?=
 =?utf-8?B?Y3d0ZFJqeER5L2RWT2tHOG12emV3cXp3dS81UytQb2xadGpKWTBjenBVWTZW?=
 =?utf-8?B?ZkR6aVBFVWJyVWJRRzhLZXJmWWdUc1ZaK3hWSjc5SnlsSEZyMEVOQTZYVmhu?=
 =?utf-8?Q?0nww=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJjSnJKaWlCQVRQNXlwSlBWb1g5QXhwZlpsSENTSWY4UkxYSW5VZWdBSEF2?=
 =?utf-8?B?WEcxaFl6bE1GTEFXaVlFOFNPOTBlU2Y1aU05cVN2T3FOeERSTUV6ZjY2Uy9i?=
 =?utf-8?B?UlpUemtQMFJHbWxzaXNPMldZNElqU01GZ05mY1hBRkxQZC85c1dGRFcvMFJH?=
 =?utf-8?B?aFdTQldOUlMwVTB6QmNjbThCemxDcXZlc21ORjdGVjhGTmlESlFSb1JGYXVP?=
 =?utf-8?B?YkpJUkFDNWg1OHZGNXdtWVVjajJJakliNDlJVGhLN2JzbHAxU3RqR1F5MHBM?=
 =?utf-8?B?K3dnOFdsanp0MGVjaEJxWExLckxHMHRxdWNzSjRxODBQQjRuNEVLWTdXMnBC?=
 =?utf-8?B?cVRNT3Y4dTgramNIT3dxUjRKQ3hPVzhZeHBveXJGWWxlQUFkM28rTWQ4WjdO?=
 =?utf-8?B?VU84QTlibGJqeFpuV1UvSkg1MGpYWFZjaGNyQ2crQm1Qd2xxUnBWR0xTREcw?=
 =?utf-8?B?UTYycXozd1N3STlOa2FqUU5qSWlwcEZoaGNXMDFyNGtlK1VEZ0ovQ3JWaWsz?=
 =?utf-8?B?VUxuSXQrWkFWdFE0K0NpK3UzaVcxVGtzaVM5YnROeUMwcU9nNFdjZXhjWGhu?=
 =?utf-8?B?OGl2WVg1ZHd6TTBaYmE5eG45aEpxemNOUHhFM0ZnT2NSVDh2T0FzTVRJem1y?=
 =?utf-8?B?bVpUV1RqTkMzemZhdTc5VDZUT0FKckMxazJRQ2hLSmlLWUZjbHd5b0pKekNi?=
 =?utf-8?B?dk9OWWRQVlpWZTJSajZZQlVNK3dqRmVTblM2bk5DZ2NSekJwM3NVay9JZGxu?=
 =?utf-8?B?dVhoejFqb09iZnNnTTd6djBycytyN3FKbFB6Q25QNmt5OXltK0xiSDk5ZVpS?=
 =?utf-8?B?dWpKK1JzSWEwL2ZXZG0xeDRiTmdQQlZ6bDVBQllXUUJjWnNGQnAvNlJ3SnhL?=
 =?utf-8?B?RkNidEw3N0o5VlRDYmsrdm9XUmtKS0V2cFpzeFpOYWI2MHZqb2pjVGwvcFBk?=
 =?utf-8?B?bFZ4MnpneUpCYWI1QW1PWkJtV1dydC9qdGVhMDF1bFRSVEgrZTdsYnhWSWZz?=
 =?utf-8?B?WG5oWkN2NmpVVldXUzU4bEdrYzIrQllqTDc2UG5SUFFSNk1yakZPU2ptclhK?=
 =?utf-8?B?MjRpanRlSVU2VGFpRWdRMEpCNk5CWlJwUnBqWTl2NkU4bWNuSWZETlNzY1pL?=
 =?utf-8?B?Mm5LandvYlhWc0dLNHJ3TnY4UlBFUHhYWk04QUlzTklIWS90ckVOb3BoTjVa?=
 =?utf-8?B?TVV4cTVidjJKeEJvSGZrYUxaVzhPOElkeGcyOHZPb2k4cTVLdE9wL0hHc2N3?=
 =?utf-8?B?NEMyQjVvL3Z3dS94czdwRzVkNTlhTVEzMFh0UTBzT21BK3RBQkR4Q01odXpD?=
 =?utf-8?B?b1ZrUUtJNlpYdkFmc2lzSzIvSTVzc3lxc09wZFBnVGRTbmVhUmljQ2doMDhq?=
 =?utf-8?B?L01JTGhSNmEwalVZcjdyNHEvcEVrR1hVSWNzSWJSUS93TzhRQlRYUllKYlFZ?=
 =?utf-8?B?S0UwUmpRS2ZIU1lncGVzWlRaVmpROEVFZitMK1VBMUVHS0w0QzhER2t5Z2ls?=
 =?utf-8?B?S0NZYmRaZEZ1MDBRcThBRVRVSzhLdVhremN4S3N2OWtySU80Rjl0OGlDNWN0?=
 =?utf-8?B?dUVYcW9RNzdpNERjbzZKakJVMFI5T3ByWi9HOTlQYUxJMFkwN0ZEajRtNm9R?=
 =?utf-8?B?ZFBJbVNiMzc3UlJnVXFIbEtsaGdyV3l4aWhUNkVvLzRLRm40YTh6NlBSTEln?=
 =?utf-8?B?bk9oMmhPWk44ZHB1R3p4UUt4Ri9jWGhrMGttN1RDNWhwY2thb3Mzb2RHaDAv?=
 =?utf-8?B?cVN5R0hkR0dJWHV5T2pqSE5LOW1UM3dOL29wb0NvSERxMUNXRXdKclBVVE9t?=
 =?utf-8?B?ak40Snh5V3REQWEraEoyb29VRzhYVXJ5bkNGSDJKcE0za0FvYWRwYWFNR2RN?=
 =?utf-8?B?d2VJNjQwWGN2K1MxQWhMSXNkTzFpYzNJM1NLZFBGWHhuK0tHSjJKR1o2bUts?=
 =?utf-8?B?V29TbVZ5MmJvZ0R1NTZsME5TNGNYdjI4QkNxUE5IUTgybVVnc2ZkYWxSbVZO?=
 =?utf-8?B?dm9BTDNHSlRDR0h1cm9hRTNHbHlaYjR2SU8zWmhxaWtkVWo3L2RRemdiTWJr?=
 =?utf-8?B?U0VHU1A3WWxwNXllamY0WUk4K2xyU1dVTStIQWw3YVpXQnJUaFlQYVFJa2lE?=
 =?utf-8?B?OTA0cTZhSzl2TDF3MVVuL2lOa0FLOG5nR0tENENodE90blYzbE5QU2treDNE?=
 =?utf-8?B?T2lra1JFZ0dOQ0krZnpMWjZabHllVWpYUW5FWlNHS3BOOXJrZDh0dlM5c1JH?=
 =?utf-8?B?dFVYMmJCQTU1eUFIYjk2cTlDTXJHSWNUY3VyZkJrVGQvYXNmT09zYVBtQllz?=
 =?utf-8?B?M25uL0wxU0R2ZkpqVzkzMmdYRzZJQStFc3o3WkVyV1RubVVXemZiQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af0b4da1-f56c-4786-a0e2-08de67c4e445
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 10:20:47.7578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92q7yaDINht5JNntEdD9P8+1RGltacF1HIRm7X3Z0sgEYxBgUKObYEQP66snaS03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
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



On 09-Feb-26 10:26 AM, Pratik Vishwakarma wrote:
> Use multi args for get_enabled_mask to fix is_dpm_running
> 
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 28 +++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index b42d56f7e621..c1ce603fcdd1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -479,12 +479,36 @@ static int smu_v15_0_0_read_sensor(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int smu_v15_0_0_get_enabled_mask(struct smu_context *smu,
> +					struct smu_feature_bits *feature_mask)
> +{
> +	int ret;
> +	struct smu_msg_ctl *ctl = &smu->msg_ctl;
> +
> +	if (!feature_mask)
> +		return -EINVAL;
> +
> +	struct smu_msg_args args = {
> +		.msg = SMU_MSG_GetEnabledSmuFeatures,
> +		.num_args = 0,
> +		.num_out_args = 2,
> +	};
> +
> +	ret = ctl->ops->send_msg(ctl, &args);
> +
> +	if (!ret)
> +		smu_feature_bits_from_arr32(feature_mask, args.out_args,
> +					    SMU_FEATURE_NUM_DEFAULT);
> +
> +	return ret;
> +}
> +
>   static bool smu_v15_0_0_is_dpm_running(struct smu_context *smu)
>   {
>   	int ret = 0;
>   	struct smu_feature_bits feature_enabled;
>   
> -	ret = smu_cmn_get_enabled_mask(smu, &feature_enabled);
> +	ret = smu_v15_0_0_get_enabled_mask(smu, &feature_enabled);
>   
>   	if (ret)
>   		return false;
> @@ -1356,7 +1380,7 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
>   	.is_dpm_running = smu_v15_0_0_is_dpm_running,
>   	.set_watermarks_table = smu_v15_0_0_set_watermarks_table,
>   	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
> -	.get_enabled_mask = smu_cmn_get_enabled_mask,
> +	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
>   	.set_driver_table_location = smu_v15_0_set_driver_table_location,
>   	.gfx_off_control = smu_v15_0_gfx_off_control,

