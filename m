Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9FAEA4FD7
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 09:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5B610E538;
	Tue, 24 Feb 2026 09:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qNLcKAS+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B92B10E530
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 09:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rqCQkBB5jU+PK3a82v8blToiISH8/8Y5//4lYBvooLymPEJvzYbrsjastlAxatpR071DP/08p3vwrPMwLprCI7duNEDdIi1jHzCAwBemAxVQ0KNHGDTgcDo2mjSxo4pK9zBv5UBizQ0baPQdGr/v0MC5kjuxfxCWLAfhb9+MwceiDe5wFbtQhzAxLngGF3wdCnw/bUhaoVlQ9uNWEzPau0So097jwMCakxlYqdh7aTvEEHaqTPzL9HqDozjeP6BlH+VLyLjntARL/G/sC4Ts7mOYtaifYOxRGn6rHe8ITsWIMqo36No38MB3GXjd2w8nn3GhXvGSKINgoAOIXgMa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuB1K1xAP+uKIpz+9A0yvx2IktdoKe6cCLNDAZu/1AQ=;
 b=AW/VVt5NyQFYhngcTeXI/ZjT6eJQxO8e3mKFEEOuoZofVXczNzYLmcBlY/Xsjf4tR3JDdGJLJ56Y66JOuP/ib3iKBUu+Y/+pjWm9OfHAMSLDxPJR3cukaw2AofqmIpWDK4yePEaWm8iAw7hDZuytMrA/2Vs2SjJV+ZSgtf6qKBJsb+DkhfWA1S043Dr+dVqKsE7Ers9hOYDXvuZJQyS+Jkpq+ZmLLx0+01F+b1lfZSOi3ytgOtfDitymnhAGrqpWLU9lJ5c91ijGNIBGYGBe6tHylOn7Uaenm91sLkWIYnGjwJFw396nx1WX6hObm2mdNYCjgI5dMmzcHb7K33+Sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuB1K1xAP+uKIpz+9A0yvx2IktdoKe6cCLNDAZu/1AQ=;
 b=qNLcKAS+aNggHPI+ipnX9gqhLefmOFyzJdD4cQ8BQgYQ3yRN1uxakx/fMEKrPNI1lQluKjWwe+K9XWm2Qh1aHzYpCHqpVcXEVlZGt02tnT0ggrn/Eg6oZq4sK4KfLjpKvDVaOC5/qumJfD78zIBU+p9W90SI8I1qlTd3zEe43Rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 09:28:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:28:57 +0000
Message-ID: <062ce56e-5d80-47c6-88e7-c45f5f72dec9@amd.com>
Date: Tue, 24 Feb 2026 10:28:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] drm/amdgpu/userq: initialize gobj_read/write in
 amdgpu_userq_signal_ioctl
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224091118.4017760-1-sunil.khatri@amd.com>
 <20260224091118.4017760-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260224091118.4017760-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d1e1bd-1d33-4435-0ac4-08de738722ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0QxN2xLdEFBaUk2ckJSU1JwU1FnbmUzaGYrM2h5Qzh0eXJQZDZQVTRDNDBL?=
 =?utf-8?B?Zmg4M0lENDB3VWpYWjFSRUpmWXM4S2RHdFQ4VW5IRHhCRmd1Z2RFbG03TXZm?=
 =?utf-8?B?QXRiOXBtVlN3Zk5aalFuRGw1SXdiS3pGTzFScVdZRUFtSTJxTS9HdW1kSUN4?=
 =?utf-8?B?ZVNuU1VvUzJzckVldHZJS0MzMVBwSVpOSTllbG9iSDVKWDFrOUVxekY5Ny9z?=
 =?utf-8?B?QzZRUER5UTVwenZTNXVBT01rNEpwTlcwYnZnaFByQmlacmdVWFJBZ2ZDd0FH?=
 =?utf-8?B?MXprT25Hdmdoa0NoU1dmUDRDL042U1lsUU1Ic1VUdEt4R3EzOTBNOFhPL2VH?=
 =?utf-8?B?L0F5WTF6Y2p1MGlycTNHUHFXWk5PRERXZDhJelJwb0hPU1ZaK1g4MUh4V2ZJ?=
 =?utf-8?B?RGYyTEN2dWgybmpSbk0vWlRVTVBVajFuTVB5dFIyQldMY2xJRytIL1U4V2p1?=
 =?utf-8?B?ak1HTEdPdjZ0QVFRc1lkQzF6a25Bb2RCRExWUjhpQzRyMHMvNU5hZnM4Q2Jw?=
 =?utf-8?B?U2plT1dVRVQzbW55eWh0ckc1MFR4N1JGeEYxQTJWWUJQZmxpR29IODVtcnFu?=
 =?utf-8?B?TmdWU0NYV3hHWjIyKzVYeFhUMi9tOE85QlZEMlFpeUEwdit1bDRqeUR1VTBB?=
 =?utf-8?B?UzNlMjRsOE5nb0E1Wk5MWkt4dzU4cmRReFJiYk1hSWo5eU4rd3ZoZVNJU1RM?=
 =?utf-8?B?SUpvNVpwUFM1Zml4Z1pnS0JCSStzQTA1cENZTStEUlpOdEdienhzNjlpbmxn?=
 =?utf-8?B?bUxqRWhvSEpudHc1R042VlVaamFjZFcrMy9ZcmNFeGFkR3RJMW1kUXRkS3JV?=
 =?utf-8?B?bExYbitBMnVNcjk1K1pad1BkN2gxZHhkblkvRlE1T09lK3JQZXRPODhWcll2?=
 =?utf-8?B?MUtsQzdldFRlNCtRVldQblBZaFZXZ0VXL3JKVWNNMi8vYXJ3QWViWVZ0aVN4?=
 =?utf-8?B?amxBaTYzNm5YbERHMGYxMUZraFdubFg4RG9wcm4rT0lRcjZiS29FQkl0cWp4?=
 =?utf-8?B?blZSOXBscWVFUnhkVEp1UzA0RHZUdzBjRDZBUnhEb2RXSzk0anh5b1lXVS9Z?=
 =?utf-8?B?QVA4bkN4RXdkbHpDZzhXbHZ3bkxBTngxdUdybmNKelVEM1o5RjdESnkvY2RH?=
 =?utf-8?B?amwyQVJrWmlEcU0wVC96cjU5QWxVclh1UjN5dXNldjRIbkM4UkF1L3BIenN4?=
 =?utf-8?B?VFFtTHkyclFobDRpZ0p4dDlCdHByR1ZzbXRTQUVXaURQc3RlMmtPY2JNZHU3?=
 =?utf-8?B?Slo3YXN6NFdSYkdsTTVWcjQwdmdaNjRsM0wyVi8vZGozbkFtcVQzTFZUL0M2?=
 =?utf-8?B?UjJvMzlBQ3NsV1I2NTJhSWx0enJ1OFB2MEpCdXR3cTNNMDRLZTEwdzFlUi9O?=
 =?utf-8?B?aFNISHdRQUMwREpwSVNjeU9oN2pqdzkyNVNuN2VacERCYVhOZjVnbXhIeGdO?=
 =?utf-8?B?M0o5NGRzWmc2LzdjLy9lUU9VYVVPN1JBT0FKRUxObU1UVUZ4eTQ5NlMvRWdj?=
 =?utf-8?B?WlFKNGtscVh4MlVMdjZRK3g1eVYrbzE1WTJyeFBFanB3MTNZaUZ0VzF1UUlJ?=
 =?utf-8?B?S1hnb2tRUFlBMnJERGhjc1lxZDJISFU5S1RVRk1sajZJOTNKQVgxUnhtbFVE?=
 =?utf-8?B?QXhPaG9kS01ubjFwb0owM3dZNjQ3OU0xeVh3TTBMVGtuUmxVRUxrSERGK0dk?=
 =?utf-8?B?R3J0bWZWYWRlR0RxcGorVkJTeUYxYTV5eDRzUkJaTDFPOTZMWXoyMFRzS0V6?=
 =?utf-8?B?TFJMSGFXcGNGc1A1MTlkY1dGU0RGaGxLR28wTkwwMEFwdjBpN2krYm1JSlM4?=
 =?utf-8?B?TUdzc3JsYitBQlV1aThXVFdKcU91bE1GSlhjV3hPQVVFN0tDM0o2RWR1TEd3?=
 =?utf-8?B?UHZWVFh3VlVTM3FBU3djbkFaWkhsSU5jSHA1S1ZSMTRmbzEvTTUxaHU4YWFy?=
 =?utf-8?B?c0pQNzlkOWc1R2NOZlVMUCtPVWpRNU5uT2JpUkw1ZGRoamg4UVlOQ0ZlaTdP?=
 =?utf-8?B?YkVQeG4xWXJ3aFAxVnlSS291cjdSTmxZdFl3dUhtbTJ6RjhmWDVSRHdQOSsz?=
 =?utf-8?B?U3NTTFlKdnh5QTZ6azJlVVVwSFVGbE92V0hhdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGIxckZJUG51S3BjZTBNZmVFcFJoeGxDR3RHaFRWa1FGTnNIbGpMTmVicjZS?=
 =?utf-8?B?R0h1WWowQWZlYlVCb3orSFdQOEk2TXdKYzRsZFk5QjVNRzJQbzllZVhRZlhQ?=
 =?utf-8?B?U1lYdEtBYUZSamE5QTJYVzJWRUpNVGdvSVFvd1dxeWd1V3VNN1dOaU0vWHp3?=
 =?utf-8?B?N0RQZDJwME1ibjJyRmlaUmd0c1FGMTlOcXhGTzRBOU9jSE9zNWM2aGllQ1dp?=
 =?utf-8?B?KzZVMVFZNi9Kd1pCRzRqeUhRdUc0QlU3T0l1UEltNThvY0t0TjhDc0pYVUwr?=
 =?utf-8?B?UUJPcnFObGp1WmdKSVFHSWRncUxZTkluRy9MZ3lTWVY5SWo5dDJ3UDRCcnhn?=
 =?utf-8?B?UGFVNWsweEdUejlOWmZsTkxwSG1VWnhzbFBrRlllQzZmQ0J6c0JpR0p0bWkz?=
 =?utf-8?B?L3cySHYwSEpHUTJ3bER3MHlNM3RGWlhMMVIweUNCUU5IZ1B3VitPUE5xTFZT?=
 =?utf-8?B?UmN6MTJ1MkRveTROZEljeUE1cUFDNU5NbjNtSXRmbFEzQkxaVDQrbTRKYUpV?=
 =?utf-8?B?SVk1YXpoNC82S2VabnBlQW5JTE1VdU5xSWJTZjZpNTcrekhYVGRtdHNNY0sx?=
 =?utf-8?B?MllXWDN3dHVPUDdxMXRZZE40d3F1L0hkSGNkOG1yUUs0TmNhbDJrQzlwQW0y?=
 =?utf-8?B?VENaQlBJNlQ0eUcxM210Uzh2S0dDRGVRMnY4ZjFvWTlCTmkrczY1bG5mdmFu?=
 =?utf-8?B?V1dxTFRQMnRtYXVmc2hIWCtVb0I5RDZIZkZzVy9pK0dSU2JnUG1Kc1A3L05h?=
 =?utf-8?B?TDNMMkZ6eWlMSXYrQWM3NE9ydUpRN01sZTV2RFNLWHplSmV6VmJyYldDeEpx?=
 =?utf-8?B?OHJzeDdCSGJCemh0VFZJTThUWjY4TmtDTTJ4UVRtNW9mcnhOYjI2Z0l1d1hy?=
 =?utf-8?B?UHR4aHpBTWZXVXdxZEFXMFJTU3VvZjBVTmZMa1V4QjNYeVZpWUhGRVA1VHgz?=
 =?utf-8?B?OWVxYXN5eU1QUStHcmUvWGEvQi9icGFxZ3ZVZjlDakpHTnBUVHpYRVk1WHFM?=
 =?utf-8?B?SWlVMVJldzRGNVJCZWhDR1o5enMzYlgxMGpaUnFLbk9LWUZWaWNaOGV4RUxK?=
 =?utf-8?B?Y0tpY0RuYTk0b2dkcjZsNkowZzhndjNVeFZtc2FLS21ZRWdqMzFseUh1TnZ4?=
 =?utf-8?B?Smw3ei9hZ256MDFXS25Kd3ZKcEovUXJQWVdsS2lYUFUyR21aTXFWY3dBRlll?=
 =?utf-8?B?VXludFpheU1WSmZ2cGlIdkFBbnpsSThtNVVBYkQvTXJMNThSRkJHSEYvTjVj?=
 =?utf-8?B?TUxXZys5NHpkTTExRzB1blBEdnZHbGZPeDhqdlZWckhGTUFpOStmR1I0Qm1I?=
 =?utf-8?B?WG1peExaWkxEbzA3SjVTWER6b2VGYStLTDkwT1hKanRucndoRloxaW03UzZa?=
 =?utf-8?B?V0poKy9DRlY0Q1Y4NDVvWElpNVZzdFNVb2ZVZFdOLzRmNHk4THpjOGw4S09n?=
 =?utf-8?B?VTNyU1lDdnIrUmxDR0U5ejNsZmh5WlJYNGI2QWJNYkN1OFJyT091V1RPR0RV?=
 =?utf-8?B?UDZKR0V3aGJURGYybi9KNjN1ekNnUE0vellSbUdGblNxZU15Njlwbmg0ZE5W?=
 =?utf-8?B?RS9OZGdjcHAyOWxaZ05zTjN5ZE5aYXhSbVd5N1VBVC9mbkN6ZHhhTldRVzVn?=
 =?utf-8?B?UjhvSTBKNUxCZ3MwQ0FKMGYzZnVtWTBSbUdrc1VWQ3JYaDNrU1pZUnE4ZG9a?=
 =?utf-8?B?bEZMZC9MN0Vxb0tsZHQrODB2Q083NkRmZDV5RU5VcmFCODZkN2RBM3VnTnh2?=
 =?utf-8?B?d1RHaWE3TTZCZ05oVjZaSUtIempIVlFYVDh3RXNpQnhsbmtEc2s4b3J2ckZx?=
 =?utf-8?B?ZU9Sb0gzdUhIZkNPUmdpekdkV0RUVVFTN2ZRYTFBRmR6b0g3RDFWUG1aMS9Z?=
 =?utf-8?B?a2YyWWdwOU1LTUoxUkZ0Ulh1N0RJWkZvb0J4ZDFuVW4xajgwZkhDZUMybWVw?=
 =?utf-8?B?SjBWL3huOWg1dkpXZytCNHljUndSdzFQU1JtTXNjTnRqVTlWcEg3VmVOZ3dp?=
 =?utf-8?B?bWFuTTh6ekd4bDJ6a1U1bjhKUk4wNkRQMUhaSld0bDBnbEJuV2lGaW0wMERU?=
 =?utf-8?B?czlQbW9xd3dvbDBjMXBlcFpFSDROd2VXZzJGbkMrbkltdVpaRlpNQ0ZXOGxL?=
 =?utf-8?B?S1l4cFBRSjVsQjlmYUJmUUVLajRqK3R5WUl0Um1DM3ZOeTN6cFFJQ25wdEJ5?=
 =?utf-8?B?NXBHME9QY042L2hrdlRSYmZ5YWJVMUtRNjN1ZGNoRkVzekROQ0h2aElJd1VH?=
 =?utf-8?B?MC9qZXdQTmhSRzdIczJ5aGtsV3hxeldhOEpScEpGQXkrZzZPWHlmWDZLbGFY?=
 =?utf-8?Q?a5p/eojuqrKDp8BTKe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d1e1bd-1d33-4435-0ac4-08de738722ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:28:57.7477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOwyo6eY6goBICBRBvFPj8I+G3p4Kc0VLgTYXBTGFb4Eg0Kd1Ifl0Nbe3DzWuKOo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
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

On 2/24/26 10:11, Sunil Khatri wrote:
> In case num_read_bo_handles or num_write_bo_handles is zero the ptrs
> remain uninitialized and during free cause a fault. So to handle such
> cases we better set the gobj_read and gobj_write to NULL.

Yeah that still doesn't looks like a good idea to me.

We intentionally avoid nationalizations like that if they aren't necessary because that allows the compiler to complain about it.

Christian.

> 
> Fixes: 3cf117572294 ("drm/amdgpu/userq: Use drm_gem_objects_lookup in amdgpu_userq_signal_ioctl")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 18e77b61b201..e53e14e3bf2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -465,7 +465,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>  	const unsigned int num_read_bo_handles = args->num_bo_read_handles;
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
> -	struct drm_gem_object **gobj_write, **gobj_read;
> +	struct drm_gem_object **gobj_write = NULL, **gobj_read = NULL;
>  	u32 *syncobj_handles, num_syncobj_handles;
>  	struct amdgpu_userq_fence *userq_fence;
>  	struct amdgpu_usermode_queue *queue;

