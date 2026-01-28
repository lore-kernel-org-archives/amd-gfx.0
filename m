Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D34DD35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB8F210E64E;
	Wed, 28 Jan 2026 10:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p3NHozqO";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011010.outbound.protection.outlook.com [40.107.208.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564C410E645
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hs50ntY/eyibI1v71zIO6zlZHN4V8HKYmZRo3VUjBNvdPe8Jj57HuJ3OZ+XAVp/OJiEQTbTjr/qGlLVHpkwkMQzTc9xRDDUmO+rHnGh6OWX/bZV8beplAhRgaAjD1qRMTqtNrprPn4Pp7pVChZKV4qTqFpR315cA8qRmsGi8dCG1LnaMSxKdj7EzFMEoKaoSuzPTrRufDJouj+iprVSZ51dIK2kxmj/rmoZNH/UzG0fagzjv5CKcjOixa0XDTVhGLq+0SlgOF+Cl4Y0gbzyBJfoB8m5cs9T+M30LmMHYuqwfpA9saCBP9JyuFUbBWjNsTvDZAb+Z0lK7XPFlzlwycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdbdB4ke2YuSDn/SI5v2Yg9ZEywWyGu53P7f368+dvE=;
 b=XI78YNaTyW4OBl5kS22VziGDPCqPIsmxCQOgQuMw5WggNnKgcCGohuVTVjJisW/chtjNxxrAvG4kehKSzJkas+FVYq1nERIsxh/tYrI1oCzFV3C41K9/RJ4sXObc+LN5gBfwWGz5jmAmvz7rsTRf3C5ethKypX+NOFzveiCqrniHAatmImnWOJhLa93FI04+uB63Re9MxZj/PEdDGj5xrKG0yaEvhI5kLjEoGj/dRAd15d4Bv+tBMIT18QNF2tlcjeXg5/uEJ8fNVGLlBn5pn+fyxkPDx4mdzvgSGhph34gAjOZ05FM8DvC2nh2oUy4w7P220GXZ3qUqvqr8WXvLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gdbdB4ke2YuSDn/SI5v2Yg9ZEywWyGu53P7f368+dvE=;
 b=p3NHozqOxqFr9zZjH1NnemzXd7MG2AxpNC04wFX8ymLTdkcVzccaNQ8iYZLJ9JOYSX2kDs3Gbl6yzbukliQbszyePutaXoZGJEfrxBMjalYKRBsmx8OTgRtX5l2sB/Puyn6ZsJIV43OnIcMHliP517r4rj1bhRIdeAXjxqgKCVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by CH2PR12MB4069.namprd12.prod.outlook.com (2603:10b6:610:ac::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 10:54:23 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 10:54:23 +0000
Message-ID: <1f678577-181d-4476-8bc5-f066e04f74f5@amd.com>
Date: Wed, 28 Jan 2026 10:54:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: gfx12.1 trap handler instruction fixup for
 VOP3PX
To: Jay Cornwall <jay.cornwall@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Vladimir Indic <vladimir.indic@amd.com>,
 Shweta Khatri <shweta.khatri@amd.com>
References: <20260122150405.647464-1-jay.cornwall@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <20260122150405.647464-1-jay.cornwall@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|CH2PR12MB4069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b761287-6e8c-4ded-5b1d-08de5e5b9881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEF2a29WWTloN3RnTzY1THVpd0Q3N2V3Q2xLeENjNENTSytWcEExeDRROWc3?=
 =?utf-8?B?enpEMDYwWTJmNGtSeGZVcWJkTkdBUC95d2hnNmdiV3J0dklNbTgrbDF5Ym5o?=
 =?utf-8?B?RkFHZHEzVGZYUGxoL0JIZUpPQnJmUmdPMVhyYXhPR0MvNWd2Yk1Pc1hKeVZK?=
 =?utf-8?B?b29ET21RemVZY3FPVjJRWFloZUNEZ2RhUERNdWFvVDlZekxTY210YU93MkRK?=
 =?utf-8?B?d1VlSm1XT0xXZVdGd3R1em05Q3QzOWFkeWd1bFpNMTg1MHl5Vk1nTWI4bE5k?=
 =?utf-8?B?L0dMS1h0RlZZSHByUk5Ga1FjK1hTMnFWWm9HSXhEaldhaG9lcW5yazRNSnht?=
 =?utf-8?B?UWNadTF5TnN6UHNlYVVuR3NGbW1mRVFVZnVHVUVBZzdnUVgzdzdQZlNJQ2VN?=
 =?utf-8?B?dGRHeGx4WkFnQ2dselBpMjhFRUpjSFRKTE9VTG4zL2dQNlYzNHBqYkF6dUpD?=
 =?utf-8?B?bFpEZUhYQzVFSFRCU3liRndjNVJrZ1NxYTdpbjM5MWFGS1oyc3RiMEJiT0t5?=
 =?utf-8?B?a1hEaWpsc3N1aTI1aVhIay90amxiU2VkV2NYYTdNeWNTaDQrVFB1ZndOVVhv?=
 =?utf-8?B?cmhxdmp6UmJ2cG53MG9JM3lBTHNIRmhaL3JVcXJmMDRvak1odk91Rm1GU2dt?=
 =?utf-8?B?UDB2WFkvNmt6Ni9zVndRQVRWZ2h4Uk5OcytuMUhWRnk5RGJ3VlppZkFLWUIv?=
 =?utf-8?B?cDZ0TWc1bm56SVpJVWhUc2pwd3p1b2ptYXRXUGw5V2paak5XUk9TaDdsT3Q2?=
 =?utf-8?B?SlB5VEh6UzV0ejhSa2NZZXRRS1U4S3dKMm14SmZZN0hxbk5JMlc5M09MTmxt?=
 =?utf-8?B?K3pJK1lEZlQzTXdkVExZWGV1eGphdUtkZWRTZ1l0TmJ1VERsQWdvVG11bVFr?=
 =?utf-8?B?N1FaL3JKS1Z1QjBYQlcvaTNuUUdoUk1xYVoyakN1MjZEanFIQmRqNDdMcmg4?=
 =?utf-8?B?Q2VhVW1GaDl2NkpBRmJncEh3dE1OUHdlczJnUVkvdEhJSWIrcjlFZTlwSmdQ?=
 =?utf-8?B?Qk4wd1NPbGYvUm1uRTFzMFVZSU9heFF3clo2MGlTNXJWOGtNbmRkTE8raDdn?=
 =?utf-8?B?b2JuUlA4WjRKdTl2L3g5eGxHRDBDL21JaG1tcm9HUjRzTnROU3V3ZXBubUlO?=
 =?utf-8?B?ZFFjSzFSZ0tmMWdIOG9TR1pmOHUxUFR6Y1lCUWExdDZhTE1CTyt4QzhtRTZ4?=
 =?utf-8?B?QStDR3UxNDFHSWhzRDlwKzFoU1phZy9TRTVSUmZkaUMvR3V1MVFsTnNSQzd1?=
 =?utf-8?B?M2FwTXJYNmJ3N0tVWXFTS1k0ZjhCcEZkQ0xkUFNkSGxDbFFiSEhaRHFUbFdi?=
 =?utf-8?B?bU91YVZSYktJNWwrNXBBaGtvaldwdzUrMjRJbWpYVDdZV1krd1hnU1ZhOVdU?=
 =?utf-8?B?a1NuQmhMNVZ3TXNYWDIzSlVHRFhRK01qS2p3RkVnbUQ4cnc1QzhpOXpvVE03?=
 =?utf-8?B?VlBJT1VWUWNMYlJDWW5DUVBMYTdHd21IdDdteURESUJiVHdXWTNwSkQvZURK?=
 =?utf-8?B?MVI4d2ZXamMxRWd6R3Y3akhzUTl3dk1ZRzRac29KRlBnT0JhZmt0QnhSL1Fn?=
 =?utf-8?B?MnZaN0RtMDJ4d1d1YVIxK3FhKzdtVUdUcVhheDVyUXlkdEJmTUhYNml1RW80?=
 =?utf-8?B?L1JLK0RWS2lpNWk1V0d3ZG8xL3hqUXJxbWh3M2xieHgwaDhFUWZsN3I4RDE4?=
 =?utf-8?B?MnIxR2hXaHpjQ1Z3dWtZRzJoZzk2OHIzeFhqa1dEWFg4T2crTHpZU2tIYklr?=
 =?utf-8?B?aFZaK2NkMFhxem15bCtiUW16b3FkTmRWL3RVQUdUU3FQU1FPWjl0d0dBOE1q?=
 =?utf-8?B?T0pjaVZheXlUSzFqQlhzNDNERXVITzJWUmxzd1BKZEo2MDM0ZVU2VFpnSTc3?=
 =?utf-8?B?ektTcmdtUHFmL0xTUnN0c055SmtQMGptL2l1akx6ZlQ4SXppWVlQZ3BJb2dN?=
 =?utf-8?B?QTJuSjZ1RThTcE5objhCVVQybkRXZFBxTUU0dUxLRytqZVNoVVpYUnMwK29j?=
 =?utf-8?B?cXpDb2dwak1QckU0SGtVTElVTi9Xc2Y0U3pRWjVpaGdyU0czZDRTWkh3aC9V?=
 =?utf-8?B?YWRsYlNaaEJDZk9oT2pMbmJTditpUHNOWlZ4ZElkU2J5bXVDbnF5VEl2dkNV?=
 =?utf-8?Q?36iY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtKRDg0TVhhdDVLTFdsdlZ5ODdwcG5Od0x0bDZja0Q5TXVxUmVJa3lpRnZK?=
 =?utf-8?B?QTNTOGNPcUYvUzhnMFBxUkdUbU9ocUtTSUtHVWRkT1FrWlljRExDOUVOQzJS?=
 =?utf-8?B?a3lmTmhkMzhHZlVsYkVNNkZKbU9kVmc4OWwrRFI1Mlp4a2YwSkdZamNxU0pa?=
 =?utf-8?B?dzhCdXFCbmxNcHpxd3JQR2RpUllyZytRc1lBK2JuMjhtcW1vNjUwcDhzTW5k?=
 =?utf-8?B?WVRHb2pwdTVUb0RRZDd4cDZTb3k5dHkvWlZ2YnZuYm1oRFlnZTRvRWFIRk4z?=
 =?utf-8?B?TFREMldjV0M4TmtnZ1o0ZTJPUGtHdWFVaE02dGl1VEtncDhaNm9EekdxN2NY?=
 =?utf-8?B?RzhMZnZKTExnZ1BUcnJIR1NUWkQ5SGNWSmdPTThLZHBoSktKMW1EcmJEb2Q0?=
 =?utf-8?B?TkNTbDZxN1NlWDRlRmlrWk5mampvK2QwWjdqZjhPNEtSZjEydDJ3WStVeFVl?=
 =?utf-8?B?aU1NN2tOb2RIOFZITkhrZ2M0MEpZVmhqdkM0TUkvaXp0bFJBWEZrRkg0NGE3?=
 =?utf-8?B?VjZNTDV2Y2VYcGgxV0pCdEhobExXRGlRdk1YWlM0Vi90bEFWYU84WmFmZzlT?=
 =?utf-8?B?eWNHNjZiZTY5c1owaG9uN25pYnFzSTZaZjJIbkNWNkRKM3RuODRDVVdoNGlW?=
 =?utf-8?B?dlVudFZJNStNRzI3NjVqMmk2V0NVd3BxYkcvYThRS0ZzWTlwTU1KSlB4Y202?=
 =?utf-8?B?dFZnRUpoQ1JYbU1CZ2JkdzVaS3BZeE9jdjlLTzVuUGNrbVhGU1Z4TkE5SlFX?=
 =?utf-8?B?STR5c3gxdTBmMXpMY2d2UU9zalhEYzRFVVVNcS9TNEkrQ1JKOFVONGV5NHlJ?=
 =?utf-8?B?eHZkNEQvU3dYalBZTHhjRk9RUzduSjBvaDZORDhXdTJtdkFrZXl4VVhvQitr?=
 =?utf-8?B?Z3J5MllsTXgzcjF4SlFFZ0RYQ1NVcDk4RzBsUzZhUzFvUkMzc2xib1FrU2g3?=
 =?utf-8?B?WGk0aFpxd1FLRmRDZElYVmZvZ2plc3YxUUpmZTRiQ0Fqb0V2SXIwSTkzRVFm?=
 =?utf-8?B?bGU2S0pJdisrT0JaTFFQNlNLQlgxd3hnc25OOENVWGpjRGVzUVdYeVhLREln?=
 =?utf-8?B?dS82N20wdC91ZjB5Wm5LbmRZRE5IeGNUVDFSWEh4aW5QeVV6WC85SzE2T2Jt?=
 =?utf-8?B?TUx6M2pJQXhFUDIvT3dSYlhVbWo1M3JBNnBNZ3hjVTBpd3RnZE15OFg0cmxO?=
 =?utf-8?B?UTk1STZZWVJZVDZjSGlaOW9xOTRBQ0tXZUtiSlB0d0RGUENBaVhYNXY4M2JP?=
 =?utf-8?B?dTE4Qy9nSjhWVG9KUFFNRC9nSmNzVlNUQmJIa04rYVZWZkg2MmZ4RDAvcDRu?=
 =?utf-8?B?a2NVNG5GMFZDRlhzNHhvQWFTWVVhSWZCL3BjZEJhUWk0ekwvT2tOV1d5dSts?=
 =?utf-8?B?ZEdTUit1ZXZtQ1Jnd0ZzVm45dFM2eXRHMHhzbGs4MFFpaTRwZjJia01id1B3?=
 =?utf-8?B?T1Jmbmp5YkN5UFVPaEljRGZFRWpHOG9FY3k1WGIzRUhNRWQ2QmxWSXB2Vzcx?=
 =?utf-8?B?V0k3Y01RL08vU3pqejJxSmZUeXFibmJFSGNFbENMSlhEa3hmQ2ovdlI3a1R6?=
 =?utf-8?B?aFFacFgzQVdmek1xTHZ3bXNxQk94RjVEWXVwRVVZT3M4cGpKS0lLNU1PZjVP?=
 =?utf-8?B?eVBabnRzc0wyU0xUVGp1YzY1VGVxUTdsR08zeFh2MGdxNkdNWWFIMDlFc0Fs?=
 =?utf-8?B?NXdWejJ6MXg5RWZ6QmhFalhsZUFaTnNpRnN3OGxIRnJOYjYxUnBPOTF4Q2s2?=
 =?utf-8?B?K3JYUkd0bU5ORzFEVTlnS01weGlFYzFyVVZWNk9lUS9oOWRPZXRINk84cjlF?=
 =?utf-8?B?bklYaC9zZkVQcmtzbXdZTXRXbTMvbEYwZWdJZ01Hc0t1bmJRU1JtRjJneXNQ?=
 =?utf-8?B?WElqdm1ySEFrSFpzQVFTbEVyemZjTUg0UUI5YXBvR0d3cnhqNjM4dllwNmcx?=
 =?utf-8?B?THk5QndCeWpabm55M29WZDdzYUlzMEtodEduNjdXZ3QzSmR2ankyMldBNzBW?=
 =?utf-8?B?UzByV2lMMHVFT0w3M1djT1ZmRmQyaXlDWktrdWNrL25mQXJHM29vbWlBMjZi?=
 =?utf-8?B?ZmFhUUFmTHI5d29JRm5wQk1EZjZTQTdpQnN4YUJRWUxTOXNIcDlCRnNOckJY?=
 =?utf-8?B?N1BpYVpUSFY3dzErZ0dONjlqaVBTS3cra29aSytnelkxVjF4S3VuREhNMWNv?=
 =?utf-8?B?dmc4VzFZcU4wd0J1ZFdLd2VzYlZZTitjbU5CaHJ3RDVQNXRvcXVEUlVxbjh5?=
 =?utf-8?B?clgvbjZFblpDanVOSURSd1pBSngzNWVwa3psNTBJMHBSdHlOWEE5UkV6dkJB?=
 =?utf-8?Q?zx6xqPZnKvO/1lg6oV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b761287-6e8c-4ded-5b1d-08de5e5b9881
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:54:23.0161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhZvLz+Nf6tGGBuyogHpME7k0TRgM9WsOYTJGbLA1ZqujgBfKeqWNqeKyGuMBnawF4L1mFdGgpG1d4OpH7/NWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4069
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

Hi Jay,

On 22/01/2026 15:04, Jay Cornwall wrote:
> A trap may occur in the middle of VOP3PX instruction co-issue.
> The PC would be restored incorrectly if left unmodified.
> 
> Identify this case by examining the instruction opcode and
> rewind the PC 8 bytes if it occurs.
> 
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: Vladimir Indic <vladimir.indic@amd.com>
> Cc: Shweta Khatri <shweta.khatri@amd.com>

This looks good to me, thanks.

Reviewed-by: Lancelot Six <lancelot.six@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 197 +++++++++---------
>   .../amd/amdkfd/cwsr_trap_handler_gfx12.asm    |  25 ++-
>   2 files changed, 121 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> index c33e7660d8f4..d38ff404277b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
> @@ -37,6 +37,7 @@
>   #define HAVE_CLUSTER_BARRIER (ASIC_FAMILY == CHIP_GC_12_0_3)
>   #define CLUSTER_BARRIER_SERIALIZE_WORKAROUND (ASIC_FAMILY == CHIP_GC_12_0_3)
>   #define RELAXED_SCHEDULING_IN_TRAP (ASIC_FAMILY == CHIP_GFX12)
> +#define HAVE_INSTRUCTION_FIXUP (ASIC_FAMILY == CHIP_GC_12_0_3)
>   
>   #define SINGLE_STEP_MISSED_WORKAROUND 1	//workaround for lost TRAP_AFTER_INST exception when SAVECTX raised
>   #define HAVE_VALU_SGPR_HAZARD (ASIC_FAMILY == CHIP_GFX12)
> @@ -372,9 +373,9 @@ L_TRAP_CASE:
>   L_EXIT_TRAP:
>   	s_and_b32	ttmp1, ttmp1, ADDRESS_HI32_MASK
>   
> -#if HAVE_BANKED_VGPRS
> +#if HAVE_INSTRUCTION_FIXUP
>   	s_getreg_b32	s_save_excp_flag_priv, hwreg(HW_REG_WAVE_EXCP_FLAG_PRIV)
> -	fixup_vgpr_bank_selection()
> +	fixup_instruction()
>   #endif
>   
>   #if HAVE_XNACK
> @@ -415,8 +416,8 @@ L_HAVE_VGPRS:
>   	save_and_clear_xnack_state_priv(s_save_tmp)
>   #endif
>   
> -#if HAVE_BANKED_VGPRS
> -	fixup_vgpr_bank_selection()
> +#if HAVE_INSTRUCTION_FIXUP
> +	fixup_instruction()
>   #endif
>   
>   	/* inform SPI the readiness and wait for SPI's go signal */
> @@ -1397,8 +1398,8 @@ L_BARRIER_RESTORE_LOOP:
>   L_BARRIER_RESTORE_DONE:
>   end
>   
> -#if HAVE_BANKED_VGPRS
> -function fixup_vgpr_bank_selection
> +#if HAVE_INSTRUCTION_FIXUP
> +function fixup_instruction
>   	// PC read may fault if memory violation has been asserted.
>   	// In this case no further progress is expected so fixup is not needed.
>   	s_bitcmp1_b32	s_save_excp_flag_priv, SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_SHIFT
> @@ -1477,8 +1478,13 @@ L_FIXUP_NOT_VOP12C:
>   	s_cmp_eq_u32	ttmp10, 0xcf000000					// If 31:24 = 0xcf, this is VOPD3
>   	s_cbranch_scc1	L_FIXUP_THREE_DWORD					// If VOPD3, 3 DWORD inst
>   	// Not VOP1, VOP2, VOPC, VOP3, VOP3SD, VOPD, or VOPD3.
> -	// Might be in VOP3P, but we must ensure we are not VOP3PX2
> +	// Check if we are in the middle of VOP3PX.
>   	s_and_b32	ttmp13, ttmp14, 0xffff0000				// Bits 31:16
> +	s_cmp_eq_u32	ttmp13, 0xcc330000					// If 31:16 = 0xcc33, this is 8 bytes past VOP3PX
> +	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
> +	s_cmp_eq_u32	ttmp13, 0xcc880000					// If 31:16 = 0xcc88, this is 8 bytes past VOP3PX
> +	s_cbranch_scc1	L_FIXUP_VOP3PX_MIDDLE
> +	// Might be in VOP3P, but we must ensure we are not VOP3PX2
>   	s_cmp_eq_u32	ttmp13, 0xcc350000					// If 31:16 = 0xcc35, this is VOP3PX2
>   	s_cbranch_scc1	L_FIXUP_DONE						// If VOP3PX2, no fixup needed
>   	s_cmp_eq_u32	ttmp13, 0xcc3a0000					// If 31:16 = 0xcc3a, this is VOP3PX2
> @@ -1539,6 +1545,11 @@ L_FIXUP_THREE_DWORD:
>   	s_mov_b32	ttmp15, ttmp3						// Move possible S_SET_VGPR_MSB into ttmp15
>   	s_branch	L_FIXUP_ONE_DWORD					// Go to common logic that checks if it is S_SET_VGPR_MSB
>   
> +L_FIXUP_VOP3PX_MIDDLE:
> +	s_sub_co_u32	ttmp0, ttmp0, 8						// Rewind PC 8 bytes to beginning of instruction
> +	s_sub_co_ci_u32	ttmp1, ttmp1, 0
> +	s_branch	L_FIXUP_TWO_DWORD					// 2 DWORD inst (2nd half of a 4 DWORD inst)
> +
>   L_FIXUP_DONE:
>   	s_wait_kmcnt	0							// Ensure load of ttmp2 and ttmp3 is done
>   end

