Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A9BD73EB7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4540010E900;
	Fri, 30 Jan 2026 05:53:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zYZu240S";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012054.outbound.protection.outlook.com
 [40.93.195.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C3310E900
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw/5diHUdRbbEoe0tzMSeegDbrdzmqFj35fcEKc7L8FZo+rxLFNRXriB9ud/igH6vULj0cFaYRdTplG4Axd65fC+3k8265G/lKH1QrKRAngluefNsGIaWwGZGEdi3bIRQK0ovtzoQOTS+9Hmnm0uGj1WQMpdAFAu5mCsVIsMtUJA/mCrm+WmABKRHwvrdQPeG/dtAYph7WPL8nUkB+IIHvjzQ5bnwCxcfI1MUrcSNHhqyE1MTvKcNXZ4IUEWReDKtZxuTTlHaa9mWW43ae/gPHKf3UKu7nKpkXABJt6FVKBalkpHHclNAzZ0qAxv2mCcg8LNOQK20tmH7w9OaaBRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/eadsYC/7WmD39ltQp+2ZT8yCz1+aDEf2iUyPc2en0=;
 b=dS1KlyCJKFMqsqu0Wo1jAbSdq1gXicrbx2g+Aq2E9UBdzfScy+VayObR0SosmHxIiU7h4fg8qTJ8EbMvrgFnnnVbIFdzZcHjJOr0bgg2a0/hTokQ+WQZmrSS/J0xiD7auZuJulQL0IXzeoyHs+BTaSU1ztglZ0sIPnerupPNLo64bjhOIBRgW9AW6t1+EYqH/Rio/fnGmRzyyq8KQmFVKTKwSNs7VekNOIDVgdxUDyPpVmrAR8bc0VvwhO46VcEsj5KxSCUrJmy1vUVXRS4KvQsuCe3IqyABbAtZELvto5MSb9sBj9DPcy+BOZlzx6+qvPHxPaTjw0v4Gvwh98wuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/eadsYC/7WmD39ltQp+2ZT8yCz1+aDEf2iUyPc2en0=;
 b=zYZu240SJc+qYJK3yJmtrBvlsMb7JjZipzlmI9mAbPXyYAZ6KMPFA+nykLMbJB1JJgWrtXeE8HZMk2wIgko6ye4Qk298cE/Hqb4VGetl9qEpE4GYTSt9tgql/rVNkM2ySPDz0GC5CUnuf6UmE4NTsL6c8wDVKM/iC2bw2LOZQEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 05:53:07 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:53:07 +0000
Message-ID: <1736c022-9078-4577-b423-503559c49f46@amd.com>
Date: Fri, 30 Jan 2026 11:23:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] drm/amd/ras: add append func for pmfw eeprom
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-8-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-8-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0128.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b1::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 29b79f90-23c2-4b56-6de8-08de5fc3d74a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUErUDJSSzZRWUVxcDJ3Uk9Ka0I5RGhlNWVxdk1xcjdzUURMSnlSK3VHb1ZI?=
 =?utf-8?B?SE14WmMyRzljQXVDNFFOeUN0RXllT0toTm9WdzdYSno4bjJ6YUVPbWJrSzQv?=
 =?utf-8?B?K042TVV3U0lCbVZQUm5SaUlDellXTWpqZlhCOTkxWGFIWUVUZHdNRndSRlFZ?=
 =?utf-8?B?SUh4NE95YVJjRWQrdDczVEJwS0hjQlhZdEZubndzbmdDa3l3Y1c0RmI4dG9S?=
 =?utf-8?B?NllNTGNVbUJjOTNHUnVyM2lsbU5NT3dIc1pHQ204eVRsVnFJellDdEd6WE11?=
 =?utf-8?B?OWE5eUhaeUx1QWJnWEJTNytkMW1YSTM5SDhjeUVoSVdtaUlFNUo5bUFvQjB6?=
 =?utf-8?B?OWxHYjBMc1Q5cTVCME9tdS9mOWV4M0laOGJRTFFyK00rNzhNVjJvL3RtcEcx?=
 =?utf-8?B?ZXVTdG50OUc4anNnTDBjeE9lcmpLcHd4b3BXaXhaUlRpc29tM0Fid1V5NVdH?=
 =?utf-8?B?VytQSW5FbHdtYW8xakRyVXRaTXJnVVhQUEUvNHNCbWdKTTV6dm5EcmNwb1VH?=
 =?utf-8?B?alY2UklPZ21IMlNXUWpwR1hxZEpmSkJvQzN4MzZlbUJ1d2ZxNDZFKzlzdmUz?=
 =?utf-8?B?aG5DZ0YyaUlvTVE3elpLOE9XSjlBbkl2VjZlZEgzc1JJUWZBbUZyQ01ONVV0?=
 =?utf-8?B?MDl5R0pFaVZwaFFzN0hocjU2R2ZmbTRua2hiREJSK3l4WlQyZ2FPQWFPRmxN?=
 =?utf-8?B?N3RqUkcxWTJONG83NUw2T2FRZnZSN2dDb2FwbWRwYUtXdUFSNXVqZDlQSHph?=
 =?utf-8?B?R3NsbE9ENEtzWHRid3lHWU9JS2Fsb05jSVJpWGE0RjZ6Nm8waXJUMnVOZW9q?=
 =?utf-8?B?bVdVWWlzeEpZWExjS0QvL3VYUkdnWnZjRWw4NWk2dWtnMDRKUjIwTE5aQWRW?=
 =?utf-8?B?WUFub3Q3NkVwbmRwczdhQTBhVU5LRmRXUTNzR3JEMU5ZY01sS3dtSU9ZU240?=
 =?utf-8?B?V1dJcStteXFWTHNFTjAvc3JsY0J0OTcyOERDZTgyemIzWGoydllYamIzTjUx?=
 =?utf-8?B?TlVYNWoyRkJwWmhoMVRkUndUYmJlVzlMd0JOVlovRjR4Y2d5MSt4NWFvRnFE?=
 =?utf-8?B?N2V3QlRFMFgxS0xPS05sL1dOL3duWm5obnNzNUU1T09naDU2RXUraFlEWFk4?=
 =?utf-8?B?b1diZTZvSHdFeFlLQ0x4alR5eDNMdjFtODYzNU1Ed1lMbm42MjhWOHNFWStz?=
 =?utf-8?B?THpGaWlNd1poVXFHVzJzdjRreTFaemxrUWxxb3lGdkFrU3NpOEwybGZENElj?=
 =?utf-8?B?elpGbkVmcWh4emhIWkY0UXRpL3UyZVNGeEpKRGJ2aW9hNlZkbXZVWnBXZXEx?=
 =?utf-8?B?aExVZU5qYWtVdGlLZDQ0RmptYWhPd1lGY0JKcTBiUjdMeThoaStYR2l0L3ZH?=
 =?utf-8?B?dFQrTkhmZlhNdDlHRldHNlJYMllMWHdoVGNrYy9sUVBkVU9tNGxQeWJJTWJW?=
 =?utf-8?B?dXMraU5tR3V4MzZHMUlkekM5L2dtYm9hQkljQXc2OFVVZmpnMkExeWlHaTUw?=
 =?utf-8?B?Z2ZpNVRrRU9RbGZlVCs3bnc1b0xLdVZGTHN2VHNOTnZqeDg5YWV2a0lmNTZm?=
 =?utf-8?B?d1MyYkk1VWl0SzZYcFg0TFJ1OGtpdTQ1bGw2bWhnTklwcERGWDNORHdrTktV?=
 =?utf-8?B?NVlqVVQ4bURRcmRMZWFzQmZQYlMvWmdwU1ZIQ1AvNnRXd1hoSGMxUDJGZVdM?=
 =?utf-8?B?dkk5NFFqS2g4Q25RdnFpakZ5cEcvalVhOC80UysxNkY0ajZFOGVCRjczb3Jo?=
 =?utf-8?B?VFhnQTVqT1U0K0VoNmcycGZQZHBOS0JUSkdCMTM0U3FXc3ppYXI0U20vd2tY?=
 =?utf-8?B?a3gxUjdWSm5aOU9xT2dUOXlmNW9tSjFYQmFnTS9EaktqbEtDOHRqWDhERnJP?=
 =?utf-8?B?UUdCRVFyZFV3NXV1aWFHZWlIMlg2REQxTlFZa2VmWllNREpMaXpJZ2FHRVJR?=
 =?utf-8?B?cVJlRXlTd2JhTERTbkJidzNTbUN6SmZhV2pzcUNnOG5NMmR4cEtUWFRMeVJG?=
 =?utf-8?B?QlFXT0JqUWpBL1J3Um50ekV6RjZGVk9rYlUrUWtoR0YxOEZCaGVwZm53Ukcz?=
 =?utf-8?B?QkgyWU5QbnBhM3NCdnFPVjh5ay9pMFJsSU8vYXA5bUJLNWlYVlRkbG5GbkhT?=
 =?utf-8?Q?59tU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU9CMlBtMFVUVkx5MVVueXJ5b3lnNVU3QzVRWGJNK3RpYSswWHByd2xKZzFP?=
 =?utf-8?B?Q0FYT1RvTFkxSWoyTDAyQ29hMjNFMDJURnQvSUIzdGJXRjl0bWN4eno5UzhI?=
 =?utf-8?B?alhtR2M2cFc4b3h0d0FBZlBIQnh0SDIwcVNhMnFrdnozOGNZbHc5VlJTRTF2?=
 =?utf-8?B?eWNKcjIxQ1NKN05pOXVWWFpTVC84Z29vMWRLaVR5dlYyNW5HVXRqSUcyZjdw?=
 =?utf-8?B?amJTcDhoK3BRWFRUb3Q3S1lvRkRFazRTa0dLaDZqd1kyeHhuM2lDWFBxcTBl?=
 =?utf-8?B?OGJBdkNFYzgxUDFSM1I5aGFZeUg4MUlBSUZVS0hNME5IcS9IQnliU3dkQmYy?=
 =?utf-8?B?YUUxTGVxR1BEWTFsSk1LWjdiWWJoT1ZUUC84bFVRWjFnbi9xZUdDUGRLTEw5?=
 =?utf-8?B?RGMxekpIZmRiZE9qS2J6VHFzaGJGODk3NGRsSWFRaWNzdTloeDJWazhPb0du?=
 =?utf-8?B?NXJkUFZ4aXhMNUMxT280VUtYWm13Tk1hY29mQnJLQXpwL3hkVkZOUlg0QWFD?=
 =?utf-8?B?b056NFpPaEJwN2JqaENwTnp3cXJxcHE1YzF5VXJhL2ZmLzNQZ2ZKN203b2l6?=
 =?utf-8?B?UHdmZDZBbFo2M1pOTW0rMTVXTVhSdHdySWd3YWQyVVRWY0NJR3hsRnpRZDVQ?=
 =?utf-8?B?QVNmNUw0aTI5R2NPR0lqQzJYL29RVmpFUXIvOFFxUlkrSkpaNEJLVmZMZFlY?=
 =?utf-8?B?RjVIK2luN2x1OWh6TzlTWmEvT3BJNUo2Ull2MDJ2MEZJeWxFYndnQU1welEy?=
 =?utf-8?B?YUhHbllxYjc2Mjg5QTJCVUpFclVKOGJ2RytXQ28vd0R0UkJyODBxTzFnV01s?=
 =?utf-8?B?eWU5SHh5QUZRTkFyc244L0VBRitRcU9oejlMWGUweW1peTg1ZWJDRmppTXZG?=
 =?utf-8?B?bmxlaXBkdEVrSHQvalowaFd2b0FHQjl2NVRINEFnZGpDdy9qSWRvcDROdEtQ?=
 =?utf-8?B?enBFTmxDR1ZVajVPVW1ncVh3ZEkycTlJZTlaQUJ1SWRCSlpKUHJsRTdUWDNs?=
 =?utf-8?B?bVRKSUFlT05NQW84bFhabnlQL3NxVTJJOVVNbTRLbEFmOW9tWW4zNCswek5Y?=
 =?utf-8?B?ZSs3ZWV6RlZZdSt3U2Fzd2xBU0QzcXZxb0I3KytLdTdWRmdIRklJQy8zbWdn?=
 =?utf-8?B?WXVGMUJMdEVkNVltYmJkdjZERUpuQkVTMzVjWElpTWQybS9DUGtOdHNjcWZS?=
 =?utf-8?B?V21wNTBsRFcxS1hsRHJWaVRQTWJIcDFSODJVZE1VOXhwYW52V3RmWjZUZ0hx?=
 =?utf-8?B?M2YydDhEZS9qOFk0aThTKyt4cGFhVVJxTkxDRHduam5SVThEWmNnb0E1RkVJ?=
 =?utf-8?B?Y2Uwc2pSRjZVUHdLdEJCcm16MWpjTXloUVA1ZFdxc2trRGlQSEVyYllYT200?=
 =?utf-8?B?SXZ6aE9odnZOVVpwNzdZYXJOdDF6ZWh1VUdnVW9oL05wenBHSE9BdkRWcTQ0?=
 =?utf-8?B?RVdqQjdUeHB6UlZ6ZktxclNrd1BmMCt5ejFRRUtjdDU2V3FNOVdUcmN0ZFJ1?=
 =?utf-8?B?bXhqKzFpSjFlc2xtNUFUNGZ3TURhL3BlWXBuZ1VlMFpBWmFGTmFGYnd6NE5v?=
 =?utf-8?B?SStaNU1qRllvdWg2MXFOL1B3aDV2V0hVd0pTZ0psUlR4NWJvZ0crVE9OelQ5?=
 =?utf-8?B?VWNFcWpYblBKNTVYN2QvVzNpSVV6UlgyYlpFL2QzZzdnekhXUXRhQnpxVFNJ?=
 =?utf-8?B?S0NEbys3L1I5UVVybzd6R3prZTBFNllGa2xLNzJjZXYwMlZwOHpXK1NhOGlm?=
 =?utf-8?B?Y1Q3R2o1RUhYVi9lTTl4RUU4SE1ma1BDR1dMeTNWdEMzWUlWdmRzVzlUMW1w?=
 =?utf-8?B?OHRBN2JIOG1XeURaQTZ1NkdBaVFhNk1sT0Z1RVFBblVwUzBKbzAxYVV4d1V1?=
 =?utf-8?B?bGtKRVBOVjkxdzFyTUFWaXV6dVhnQkZLOXY3ZTNGYTRwdnczWWwxc0tZYTY5?=
 =?utf-8?B?emcwcEQ2UFFaRDZrb0hSRGRWT0dzSWdFbTFTeDN1YlU3eU5rT2RHVHJXeURZ?=
 =?utf-8?B?WWZ1dW1Ocm1KZFRvUFJmTGM0c3dVaWFhTE9uMlNTTTQ5NExML1U4NHN0a3Qy?=
 =?utf-8?B?U3hpcG1ndWxFeFc4R0lmc0FEYkk1bllMZkNsRHNlUUdvbnlaTm9oc05CQVpD?=
 =?utf-8?B?QXM2U1pqRFg0YSttWDgxdFRwVGNHVnNpMmI3RGpPa2ZkNXErUHVoNFZHWTJr?=
 =?utf-8?B?L01UY2NjY3lueGpFY2d2VUxCdnJPMVltbkNXZmExSnIzcjg2SlFYbWY4dzdv?=
 =?utf-8?B?ejNEaW1OZ2EwSjhyRUEzSWh4NExDOFEwREZJcnJTenFQWWpYS3pVeHFiMXps?=
 =?utf-8?B?RnJGd1N2aXd4cUNDWnQzK200TzlaWERpZlphUnFDTXIxVk1PdUNGZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b79f90-23c2-4b56-6de8-08de5fc3d74a
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:53:07.2106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbec9/Jzoz1wpK1BlTV0ZCQSuDXugDS0S4aZdLEFN9ygtnJ4r/x0cXcstcjVrAnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add append func for pmfw eeprom
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 39 +++++++++++++++++++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
>   drivers/gpu/drm/amd/ras/rascore/ras_umc.c     | 10 +++--
>   3 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index 34a4161251b3..580dd7b09d00 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -220,3 +220,42 @@ bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
>   
>   	return ret;
>   }
> +
> +int ras_fw_eeprom_append(struct ras_core_context *ras_core,
> +			   struct eeprom_umc_record *record, const u32 num)
> +{
> +	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
> +	int threshold_config = control->record_threshold_config;
> +	int i, bad_page_count;
> +
> +	mutex_lock(&control->ras_tbl_mutex);
> +

Same comment as in earlier patches. All seems to be duplicated just 
because a mutex is added to specific access control. Instead, all of 
that can be kept in common eeprom and only access mechanism can be 
separated.

Thanks,
Lijo

> +	for (i = 0; i < num; i++) {
> +		/* update bad channel bitmap */
> +		if ((record[i].mem_channel < BITS_PER_TYPE(control->bad_channel_bitmap)) &&
> +			!(control->bad_channel_bitmap & (1 << record[i].mem_channel))) {
> +			control->bad_channel_bitmap |= 1 << record[i].mem_channel;
> +			control->update_channel_flag = true;
> +		}
> +	}
> +	control->ras_num_recs += num;
> +
> +	bad_page_count = ras_umc_get_badpage_count(ras_core);
> +
> +	if (threshold_config != 0 &&
> +		bad_page_count > control->record_threshold_count) {
> +		RAS_DEV_WARN(ras_core->dev,
> +			"Saved bad pages %d reaches threshold value %d\n",
> +			bad_page_count, control->record_threshold_count);
> +
> +		if ((threshold_config != WARN_NONSTOP_OVER_THRESHOLD) &&
> +			(threshold_config != NONSTOP_OVER_THRESHOLD))
> +			ras_core->is_rma = true;
> +
> +		/* ignore the -ENOTSUPP return value */
> +		ras_core_event_notify(ras_core, RAS_EVENT_ID__DEVICE_RMA, NULL);
> +	}
> +
> +	mutex_unlock(&control->ras_tbl_mutex);
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index b0d3eade4377..b94d3c9703e3 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -68,5 +68,7 @@ int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
>   				   uint32_t *result);
>   int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
>   bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
> +int ras_fw_eeprom_append(struct ras_core_context *ras_core,
> +			   struct eeprom_umc_record *record, const u32 num);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index 4dae64c424a2..fd427fd59ecf 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -479,9 +479,13 @@ static int ras_umc_save_bad_pages(struct ras_core_context *ras_core)
>   	save_count = data->count - eeprom_record_num;
>   	/* only new entries are saved */
>   	if (save_count > 0) {
> -		if (ras_eeprom_append(ras_core,
> -					   &data->bps[eeprom_record_num],
> -					   save_count)) {
> +		if (ras_fw_eeprom_supported(ras_core))
> +			ret = ras_fw_eeprom_append(ras_core, &data->bps[eeprom_record_num],
> +					save_count);
> +		else
> +			ret = ras_eeprom_append(ras_core, &data->bps[eeprom_record_num],
> +					save_count);
> +		if (ret) {
>   			RAS_DEV_ERR(ras_core->dev, "Failed to save EEPROM table data!");
>   			ret = -EIO;
>   			goto exit;

