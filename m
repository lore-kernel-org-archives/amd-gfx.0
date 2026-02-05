Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CB1EC1EBE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A726410E8D4;
	Thu,  5 Feb 2026 14:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JmszfRxw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5044410E8D4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIdT4/cZepKn+lXWuEBbL7ObToizFiJ4bY0Gi6y5FDc70LhlNNLYZjzI0Jae9SzFLqSUr8y6WjxguQ1+/kaUvDDq0uzzHxxTZcYmnFjeCWb2pHsMxQD7RQFO2H6hQOd26i18rS2Qjhdc9Snuj7erQRsYVDjhhzp+X5Q81WlO7ndygGmZIb+Jf3pXgz0Twoi90b3SD68t6CpAXg13bqcxOBIH3hkD0vfzNlyfyMdJNdYiTYdWgCdhirAEPsMpAU4tRcSCjO7/IhwHAkJq3ioXd7Vxd73lEWp/0IUGBsarv0601WxSihuyX6dkKLUmuEg6ti54QGQVnIFKkwNK5/WlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0iIZ+Xj5/QYbDw3APSod5wzDCbqG+jCHVTWDiap398=;
 b=l/X6XpY+RgzSLRw5lu3jR3Hq8ZX/1tj9wGnwTaIw6BS/a27Ib8DLRw9nEy4rsxh803ieWkPGbjPpLBbq8aisStf5wbaEPY3IH7SpJsHSutOegZp/fEcJ85M4BEa/1mgDY73EOTpAbvuoI8IIF50q73gLF5ViStfRcP9ByMKjZYX81Qwe7uiR4gQ3TAEnTrNZ/n5fBAhPScY1Q0lrcuJ2gWRpSsqjMmQUeEg8XRattIfmaEV/mqqwOkRwRjde/JqbBH+WuEdz0JFS8tFqldn0pFwE+jd7JP9DGjnJdEno/BiyuTm0OOwwI+PoXQPCyucnhTrUstvphJ7tlRAcUjLrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0iIZ+Xj5/QYbDw3APSod5wzDCbqG+jCHVTWDiap398=;
 b=JmszfRxwaMj0tStsFzg0wAMLit01tej1Icjrqyqdg/HZvOJVVcrct5EWum+YK0c9YO5prQFltM5p4ZGJuEta3I6bQrGSznv0dT40yhNt/LIoq/3ULvNgi1Llz4fCh+A53OHiCdPfSxhoizcq7jTAx35k5riDO2CbkJBsLxkVjMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9683.namprd12.prod.outlook.com (2603:10b6:8:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 14:04:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:04:15 +0000
Message-ID: <03db2904-1711-4726-bad6-7c22d2883df2@amd.com>
Date: Thu, 5 Feb 2026 15:04:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/gem: Make drm_gem_objects_lookup() self-cleaning
 on failure v3
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tursulin@ursulin.net>
References: <20260205135617.288153-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260205135617.288153-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9683:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e85346a-2b1b-4b9e-71d9-08de64bf7286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGVkOEltUWNObS96M2RjOGRYQ3FQZ09sQ1dSak1WZncxelc1aE5YMlJZb2pl?=
 =?utf-8?B?K1BwWjlHL3cvOTJGb044NE9NMXJTemwrZUd4MHNCZkRsN0daazh0K1ZPRUZw?=
 =?utf-8?B?YTdhdVhBd3NhRXJCbW1FMVR0TVpnV0FWTzFhUnZYSHpPZENWSXRiS0ZRTGdF?=
 =?utf-8?B?TGU1dVBaNG9FMElqa3EvQ3d4SUIyUElDZW96VDNwaU0yME94N2lWcjg3NnpO?=
 =?utf-8?B?Z1pmcXJVaTNvTnIzeXVXTG9Lczd2VkhTQUdZYTY2N0J2MlFFTHE0N1o3YUVt?=
 =?utf-8?B?K1ZlaWpKRDRHQVJxMTlnRms4dldPYUJUS3NrMFFwY0hIdWdrMHdidWpxQ2pL?=
 =?utf-8?B?TmMwd2xycForbDYxTG96eXl2bCt3eDFaNEswZGNoV2gySXlZdXJQK2JXaDN2?=
 =?utf-8?B?NnVHMDJUOVZMZjQ3a2FCdkltR1hSQ3RDZ2ZDaTFiZXNHMlhmaHVCRHBWQW8r?=
 =?utf-8?B?dXJIelhCdWNhZnVmc09TNEdBL1d2Z2VLTER6eVZqTkNVT1NzblVtTnliZ0NX?=
 =?utf-8?B?cjludWU4Q0JGQmdRcjExaVE0THpERGljZmJYLzJTUDRFR0p3eWZjenlsUkow?=
 =?utf-8?B?SnRJMXpOMUxRZE5LL1I0anFudVA1cC9jOGZpS003NzdpWi9wWktaNFFOeDZX?=
 =?utf-8?B?dEdNa2V1Q0JSelhxTUJJelE5QnZUdFkyNzk0SWVDdEZQTUFpdWNaK2pZVEc0?=
 =?utf-8?B?RGtqZWxwZlBTWU9vYVc0VFNaOExRVGpwVmVSdDhZd1RnZGNKMjk3STZ6aEVW?=
 =?utf-8?B?LzRBSnNwa0Erbkl6eDZxQmgzOUxnZ1ZYNmdaa2Izckd3U2Evc2dodlpuVE52?=
 =?utf-8?B?azJJaUdIN1U0MHR4bWRpWWJFTmh6QjV4NzNQd2hpR0ZQVDRIdDNtbVczSnBS?=
 =?utf-8?B?dVdsWm55ZVp5L0p1ZkxuU0pyL0w1TDF5NjhrMFhWc3ZTL01VWHZDZnFYQUxG?=
 =?utf-8?B?bWJ4UVlJU3drYTZsK1VDeTRuTVdORG0wMkFEdjhOY0JSR0gyS1EwaWJpZ2hZ?=
 =?utf-8?B?QzQvajYrdkI1VWxxN21paGYrcmtCNUtGbjJneXh0Z2VUbUIvNHJQNHpNek8w?=
 =?utf-8?B?blhlSGk1dUVibU5tVklPRE5MUkUxb3RmQ1hBYjZ2Sk5YTW1MVi9DL3U3S2Z6?=
 =?utf-8?B?d0R6RUlkZWUrTW1JUXN5dXpza1lLK2ZzWHJCR1ZiRkxhRHMyUmdUQlorTUU4?=
 =?utf-8?B?RXFtVlhsODdyWnl4VWlVMFRrYzYyMDcxREpMcFpwaU15WSsrc0x2TmxQdWR0?=
 =?utf-8?B?MW9OTzI3MUViUmgrUUFHald0M2NVYkxvNnRRSmtsek42Qi9ES3d6cXk0Znky?=
 =?utf-8?B?Y2dIWTU0SWV2TEtEd1dHbExsVkgyRW5nODMyb3p1OVRabnh2MTJWNVF6T1hi?=
 =?utf-8?B?TUNlYjh3OTgwd2c4SWFybDdoa0FVOTZ0K2tJY1dpQkFabXRKSEdJU1BlTEdw?=
 =?utf-8?B?cTRIeFdKSXNnbVo5ZlVNcVdqbk9ua29NbWFxQjhaL29NOVBwWWdEcnlKZGhW?=
 =?utf-8?B?d1FyOUNDSXViRnpaS3RPYzRyNGh5bytlVWNMbXZoQ2ZxRmI3ODJPN0pSNWhn?=
 =?utf-8?B?V2FZMnd6ZEJ2NjE0MlV5REJBY0x1V3NwUUlIMElhN2FCZ0VnVUhtODZ3V0FD?=
 =?utf-8?B?UG9zZ0JvNTJLNGp1NGdjR3ZhWHROV1REc0UzWGVqRWhNYllDR2dySmE5Q3Qx?=
 =?utf-8?B?VFUxaGxhWGpMQVlnMURFbDBGZStyR3NIcGRrRnhpbVhTbVh5TjduSHdZT2hW?=
 =?utf-8?B?TGJJYlJxckFuWkZPd2dGVmhWYXl6WHQ3V3NJektCRC9yMFk3T2NaMU5VT2Nk?=
 =?utf-8?B?V0kzaWs5SFpvbGErZU9DQnJ4a0poWnBPaVhNaUxHRzJndnNSRGllay9paitW?=
 =?utf-8?B?WExqd3dqZStPY1dWbDhSSDVBblpkc0c4eE9jVjVlNjR2a1YxRnQxNkUvL2ps?=
 =?utf-8?B?WjVvcFErSTVaVFowTU8xSUQ1YzZ6MkdOUEFxdjlxR0lyYlpweFVXMzNKWkp4?=
 =?utf-8?B?ZVcxc1BTVHdkK1R0MGt3QVFtN2dQMXlUUGtVMnVHWFd3R2swN0lmM1lLTXVi?=
 =?utf-8?B?bDZpTzA0ZXdmUXIzYmtKTk5tZXhTekNocDFPVWdHYW9nbXRHaTlKQU5sdDJQ?=
 =?utf-8?Q?n09Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWRuVzQyY1JQYVAxYll2cWVpNm9PQ3d6Y1J5enpFNzA2bUpvSXl6eDczYmRZ?=
 =?utf-8?B?ZUtUZzhUd3VJaFlZVTcyZm5sWUZ3cjh1VDhEcTVuZFphcncrcTBZaHpNa3ZS?=
 =?utf-8?B?djVVMGRrVFNtL3FsRHQwRktqanE2Tm4wUmI4QWJwSE5DQlQrdTF4dVZ5S0VY?=
 =?utf-8?B?TnNobUhycUt1cE1XNjl5VGtKMHNIY3ZYS2E4bGhTRUFUK2NLSDRLVU1yYzlP?=
 =?utf-8?B?RVpzWFFOZm51OE9iUHc3b3BBaEo1UW5zNnY1eFNmdldIQmNienU5M2w4bi9s?=
 =?utf-8?B?VVNwWUIyd3R5VmUrT1NWeEcvZjBwZHhVYlU3RkkyOTNJTjEzMEFKNmRLMkd1?=
 =?utf-8?B?Z2dydDZwWVlCWDVpRm9SZEZ5WG5uZzBaU0IyOHBzMVNpbjYwand0cm9Qc2ts?=
 =?utf-8?B?dUsrT09scXhNU1R6RE8zT3VTdWJ2ZjZsbDhuOUtOVk9aY0paTE9QU1dCbU9n?=
 =?utf-8?B?azVmUTJEVGJPNjBZVVdOeVVvdTZTQWJEUTdPM3FCQzBzcEg2ZnNHbGhhVFNX?=
 =?utf-8?B?TVpBZVJLV3AzVnhsdTQ0K0ZtRVZVWFN6VEFPdHcrSWlsU0hnN2RUaEh1YnNu?=
 =?utf-8?B?cmFHOTV6bVREMENLYUw5NG91UnE1djNnUHIvb0ZrdTlwSk1lb2svMVhleGZ0?=
 =?utf-8?B?aUtaL2R6TTUzbStlZ1VJT04rUm80WXVidHVlQ1ZtVTlMN2xmaS9pVjlDT0RO?=
 =?utf-8?B?UVNxLzRQUTVrRkFkRi9lSStDVHpaZ1FKV3BETUFXYVpKa1Q5M3VlUlBkRHNV?=
 =?utf-8?B?cXh2QW5qVGdvS1ZwL2V3VVV0WHBuTGYrZ2FRZGFLakN2eVVxRDB4VDUwNWhm?=
 =?utf-8?B?dzR6cGtqUlg3bTh6QkZ6alJmUlNmRG5kVTY1Mk5Zb0FweEY5SWRicUlObTQ1?=
 =?utf-8?B?Zkg5aHpjL202TDgvaHpoL1hPNFoyKzBxQjRPcS9YQ2pscUZOeFdqTW1WR0kv?=
 =?utf-8?B?VzhJWXVRMWFnblk0OGt6NVZWNVBSOHZmODJBdG4wN2hlSGNSU2M4em15c2tF?=
 =?utf-8?B?OHRvY005QzJaUFZUemh4MVByaTNJakdSZ2REWHJHN05XY0xZUmRDS01Qd1NI?=
 =?utf-8?B?UlBoZzhNL3Z0aVlCQU1SM3dldjYzbGordmhoVmhUUzlXWW1wamdmdTh0USsw?=
 =?utf-8?B?OVFmTG9tQmtJTFp0Q0VKdXgwcExCTnFSVndmRkdISjhqRklGR0pnNjlIdFFn?=
 =?utf-8?B?aFdoODRLdXJKNFV2WFgvcE1pUndDZjhtRVBaUE5oRkhzcGpIc1BickY0ZGV3?=
 =?utf-8?B?bDJtcEVraDF6SDU2ZXdTR3pUNW9kZFY2MEcrS1JFcS84ZnZjaS9VNlFaSmNX?=
 =?utf-8?B?N3lZSTAvc3J1NXFOemd1ck5oWnZwRXpmZDY2Qitielo3OUNjWXJGZVNRcVBN?=
 =?utf-8?B?dlVJRDdEYWdiRWpSSFNXNldUd0M2TU5HTjF4bW1JcDBoTnh1QVkyb1FiVGVC?=
 =?utf-8?B?ZDlYb3BzRzFMbG1DR2tETXoxZVpGSFd1QXR1Zk5Rbm5LbnY5QVd1elFFTjlD?=
 =?utf-8?B?TDJPak94Y3FZNkNrOWFVaDEyaCtBRGRna2VzTFNmdjNqeEVBWTdvWGpUOXUv?=
 =?utf-8?B?dXJIWElNQ09CNk9ROFNiS3hWaFV2emc0OC92QWpweTY4cmdOZ3p4WFl6K1FB?=
 =?utf-8?B?VitVU0tIZkVGejd3c0V2cFY4SmJLcGlrZmNESFZnUVZHM2oxd0JucXR1YkZ2?=
 =?utf-8?B?L0VSK1h2Y1phSHk1MCt5RWVsNDllcW00c0tlR3NubnRsMit4TDBnZnp6K2pO?=
 =?utf-8?B?dHBZL2hoNGs5c29NYzZKNnlVdXl1RVNKdS9RbEZoa0htaFExRVk2WVBVcjZq?=
 =?utf-8?B?N0JXL1VZVTlhd3dtci90c2xzZTIrS1d3QUNxTEJjNmhYTlRrYzJFdWR4T0sv?=
 =?utf-8?B?T2VwdStsaWU3Vm9PY3pKWTU0M2ZGVWJ6eUJoZUhUSittM1UwQTZBakdudXQr?=
 =?utf-8?B?MVE1Y3ZZbE5QNGZHRHlDNmx2OGQrdGxNNDZibnJhODVpMGs4ak85UkZ6Tnlm?=
 =?utf-8?B?K01Cdm1PM1JiYktka25IQ0hSNUYwV1hyRk9WUXdMNHdOeTIvWVc4dFR2anFi?=
 =?utf-8?B?OTRCSmpDb0hINlpOb1BoRjJCWXFMaTAwaHlJRUt1U0hHVlBQWVJnOVpJK0xm?=
 =?utf-8?B?L09OWFZEdk5QalhLQnlDMDIvWTNGbktCRnc4UWV5VXhxWUo2cklBZjc4V291?=
 =?utf-8?B?c0x4T0ZDaVg3ODJaeGVLM1JHMnh1YTBCcGp6bE1JTCs0cDROcXBwOHdDSjkx?=
 =?utf-8?B?MVFraTQwci9tYTRVWmd3bUJzR3Vka1hSTi9MbnM0VVRjM1RVK21jbklodVZU?=
 =?utf-8?Q?oH2cxFCqJn2EqnUvVO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e85346a-2b1b-4b9e-71d9-08de64bf7286
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:04:15.7837 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzHlUPBYf3M1GsA8RdKqcYsIDfvm7zCjGQuv/bh+noGBjwjA+Thptejj+Cd5fRJc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9683
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

On 2/5/26 14:56, Srinivasan Shanmugam wrote:
> drm_gem_objects_lookup() can allocate the output array and take
> references on GEM objects before it fails.
> 
> If an error happens part-way through, callers previously had to clean up
> partially created results themselves. This relied on subtle and
> undocumented behavior and was easy to get wrong.
> 
> Make drm_gem_objects_lookup() clean up on failure. The function now
> drops any references it already took, frees the array, and sets
> *objs_out to NULL before returning an error.
> 
> On success, behavior is unchanged. Existing callers remain correct and
> their error cleanup paths simply do nothing when *objs_out is NULL.
> 
> v3: Move partial-lookup cleanup into objects_lookup(), perform reference
> dropping outside the lock, and remove reliance on __GFP_ZERO or implicit
> NULL handling. (Christian)
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Suggested-by: Tvrtko Ursulin <tursulin@ursulin.net>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a1a9c828938b..da18e49a8bde 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -759,6 +759,11 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>  	}
>  	spin_unlock(&filp->table_lock);
>  
> +	if (ret) {

Might look better with a "goto error" instead of the break in the loop.

> +		while (--i >= 0)

The usual pattern is to use while(i--), otherwise we rely on that i is unsigned.

> +			drm_gem_object_put(objs[i]);
> +	}
> +
>  	return ret;
>  }
>  
> @@ -775,9 +780,11 @@ static int objects_lookup(struct drm_file *filp, u32 *handle, int count,
>   * For a single handle lookup, use drm_gem_object_lookup().
>   *
>   * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need to be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> + * On success, *@objs_out is set to an allocated array of @count pointers
> + * containing GEM objects. The caller must drop the references with
> + * drm_gem_object_put() and free the array with kvfree().
> + *
> + * On failure, *@objs_out is set to NULL and no further action is required.
>   *
>   */
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
> @@ -785,36 +792,42 @@ int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handles,
>  {
>  	struct drm_device *dev = filp->minor->dev;
>  	struct drm_gem_object **objs;
> -	u32 *handles;
> +	u32 *handles = NULL;
>  	int ret;
>  
> +	*objs_out = NULL;
>  	if (!count)
>  		return 0;
>  
> -	objs = kvmalloc_array(count, sizeof(struct drm_gem_object *),
> -			     GFP_KERNEL | __GFP_ZERO);
> +	objs = kvmalloc_array(count, sizeof(*objs), GFP_KERNEL);
>  	if (!objs)
>  		return -ENOMEM;
>  
> -	*objs_out = objs;
> -
>  	handles = kvmalloc_array(count, sizeof(u32), GFP_KERNEL);
>  	if (!handles) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_free_objs;
>  	}
>  
>  	if (copy_from_user(handles, bo_handles, count * sizeof(u32))) {
>  		ret = -EFAULT;
>  		drm_dbg_core(dev, "Failed to copy in GEM handles\n");
> -		goto out;
> +		goto err_free_handles;
>  	}
>  
>  	ret = objects_lookup(filp, handles, count, objs);
> -out:
>  	kvfree(handles);
> -	return ret;
> +	if (ret)
> +		goto err_free_objs;

Na, make that goto err_free_handles and move the kvfree later.

Both works but I think that's cleaner.

Christian.

>  
> +	*objs_out = objs;
> +	return 0;
> +
> +err_free_handles:
> +	kvfree(handles);
> +err_free_objs:
> +	kvfree(objs);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_gem_objects_lookup);
>  

