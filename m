Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF1BC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 21:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365FE60FE4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 21:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365FE60FE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6DA06EE99;
	Wed, 19 May 2021 21:01:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C062E6EE96
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 21:01:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idecFzdgh+H+ib2IfHaXadMDDzwBXBpXDBLmG2k3HGulmmRDnNeDv0l+wFJLOwc1XT9KQCHmowmdn9Zkscy9vSrSLdh3/fKNKhFEtArw9/v0U0P4caYZtarUVE46TBsrEb9kNhsx/mQ6hpEFB7ltd1ASC7volc+/PlDOECmbfSL30BdH8KJbvWAXfzm44aOVM6oIOnm52LnPpHOiWupOACkTfg/dhZGQud3k3LZE1FcU5QC8LM9oO49qYsuHavDO8fvM1FX4i3OOO8gzD41mBpGI0Js8IUtH2Ni5f5L1aBAPiou0G7rRSkO161q6GNQAjFA/jERBPf7ijnnf1F7XYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMmXBHy79MRshXJSPGwtkpuiG3C5KaIlchU4pX2S9Jg=;
 b=M35sFhjQXYM164ShRAHPsOvd/G0hSRtdLZylSMOUUqMSv5ONhF87EVm4mI+SLv3erabOsf+7IUMDEuRPZqvyMk1DvDMyH6jwgOqezDn0TAU/tY+RkQmF5Qey22PMGeDkct/eAzjmwnlo2tC+WUcee2CVDJRi8m6FWGcxkDU1NpUqJZn5tEgQ5Ferm7OruWTeZQs6hBzOZQLOL8h3bnroCihR9vEYTyOVO4yktxsaZMCe6lSKXZXGHtSkOfB/NVxgMlqXgm3LNbLGw77QK9POQhhS5fjhOdOZo1kdYNbFzMrJdbKgemW8NVMi9G7YJjGNRXsafBw8bzuazGpHWRcKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMmXBHy79MRshXJSPGwtkpuiG3C5KaIlchU4pX2S9Jg=;
 b=w8+I9Od5OuTnIzuxuSwQnLpVWGad7q3DRusqS8OHic7kRkZLZ0ibroUnumnlo8S0cbFpmkCbfsqB7zJ41vAbq6H8OrUkEPRtEOxP8iFT0rzwfzT9lkro/+/6cBVlJduOvrPb10V9Q41g/eBEYpjselqW6xY0nOuBW+6NIITTNS0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by CH0PR12MB5122.namprd12.prod.outlook.com (2603:10b6:610:bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 21:01:54 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1ddc:e4:8412:642d]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::1ddc:e4:8412:642d%6]) with mapi id 15.20.4129.034; Wed, 19 May 2021
 21:01:54 +0000
Subject: Re: [PATCH] drm/amd/display: take dc_lock in short pulse handler only
To: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210519205505.622626-1-aurabindo.pillai@amd.com>
 <099e5aa6-dded-1d9b-a542-25524c5c6ebb@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <48eb29dc-4be4-4307-e59d-a97fd590a99e@amd.com>
Date: Wed, 19 May 2021 17:01:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <099e5aa6-dded-1d9b-a542-25524c5c6ebb@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0460.namprd03.prod.outlook.com
 (2603:10b6:408:139::15) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.40.134] (165.204.84.11) by
 BN9PR03CA0460.namprd03.prod.outlook.com (2603:10b6:408:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.32 via Frontend
 Transport; Wed, 19 May 2021 21:01:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1c1944f-ca56-4f97-8344-08d91b0954be
X-MS-TrafficTypeDiagnostic: CH0PR12MB5122:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5122D80C0A45F5F95362E8C88B2B9@CH0PR12MB5122.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQs3rNqSKltW9y8Ps3aPN98HLeHgsQLR/il3S6AH7PsKlthkH5i8mV9CtMXZU1KyxMs4nGHksOuFpueyzKtivLoYMau98AYVb8kF0QmU3OrygKOLAGw06bgXNu/dDmSZVJa0jbu2eeRf19uo+OIkoVkrEL9JWgjHs8O5+QN8NRlzEapuHDXuy9VXJzeFHf8xovw6vvIjyUTEgoCu6FTD3vLLQdnp4DY5E8bULpNLoHYdDi0P8+Ax0B578DCPxT9mCaYvr8Tk9oB8xYd7a6pkPDvNcXteABjmOR2tmS2QkVUPrqDcv3q1xrizafPLOLIq4qveJv3soYgR+OfeHdAGzrgZisZODDMcchaDYM0ohemAeotUpGE9b2DCoWtUrVNjzU0uX8YYyWWP+t5fW2zodZ8sA0LQktVerFYwHsOFmYcXfX2uCaVaUfhe48VT2iiPTUDmvQvbguTIHB9wy7wv2ZSMYZIcTKWxDKlg7yjQN59WJ4RK7EyDpPlq9jS/s0IpSp47DcTUP85i1zXzRlIJud11RbRX2PTr7w1ENHRc5jqA3OD8F6+/sFG/f8MuFYHwJGg0rsly1edVFm9kRnkPlOR1GSk/N5ma8Ybd7KWszw7Jpv4U0TbE9CxISMoSa5HfK08P7o4Cb0FI12FnrzyXVn6reV+mAY+dzxTBDNCb1yPSk9qOyaeCI3heKg6JfUqcAUEnghgAxcKb4WU7gS2k5yX7ehqvh5pQDh54Q2+0Umg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(36756003)(53546011)(478600001)(83380400001)(8676002)(31686004)(5660300002)(31696002)(186003)(16526019)(8936002)(2616005)(44832011)(956004)(38350700002)(38100700002)(16576012)(6486002)(2906002)(26005)(316002)(52116002)(86362001)(66476007)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?REdXVXdBWGpybXFlVjBQUUlUdGRteEIzWGNxVUNGYlhVZU11RUlLZkpFeUxU?=
 =?utf-8?B?R1BvMkQ5amFVSjJKUm1pRTBtT0dod09NLzFyRWFOaWlnU2V6aHJLeVFMaWda?=
 =?utf-8?B?Wi8vamszcnlLWkV2aGJVZkJ2ZUJCU1FxVk80T3N3dEJsRmF2VlR2L21CbXpB?=
 =?utf-8?B?QUVCeVZsMTI3ajROcFNtU3lUenRsUWIyTE9mOEJMc2JRK1piTFN5L3BRcVMw?=
 =?utf-8?B?czNyMytoTWRsckM3YnVXd0tISzFodWdvS3o0eW5rNnpwN2RUUFNXZEdqR2NS?=
 =?utf-8?B?QllmM1ovWEtETjlXODN6bWJldFZXT2xFZWFDMkFMeWJxNHRteWpabTlQQ3px?=
 =?utf-8?B?RFBzckhsSTV1WVRYREtlRVRoMTlPazM1anBYMDNLeG5naThFNVVodkk1THd2?=
 =?utf-8?B?Qzl4R3A0UW1JMkZnWmtPUVNPSU1EOERublpLUlgreFhzcUFQNkRoNlM3TEgz?=
 =?utf-8?B?emN3RjEvS0dYNGlIL3YvT1JOeXp4cmNjRHgvNW1FTkpXM3hhMCs3dzRhY21M?=
 =?utf-8?B?MmpLb3E2OEVTT200U0FXU3Rnc3dCbVdjMkRJSWdlZzZmU1hUV2tUWmkzamhr?=
 =?utf-8?B?MFRvSVArVlF0Unl2OFAvK1ZyR1JYNWlMUGJyc3lTWG1zdEdxU2lScE5rUzRH?=
 =?utf-8?B?WkpYQ1l2ZnR3a0xJM1J6N2dNVittd2pLbzBSaEJVcDR1WDRDa0FMbzZNbFNz?=
 =?utf-8?B?VXZkZzQrVEhhbU5pQkRndDhjcVI1aFdiaGVwRlhqSCtRcndMcEM1eDBIUTdP?=
 =?utf-8?B?amNRaFdBWWFEREgxaWNqUjJQeDhyQkZGbW1IZGIvOTF3d1J6MmpLRkk0Ni85?=
 =?utf-8?B?R3hGbmVoMHduaEFXQWhydmIvN1J3QWNwQ3d6enNwdE9HbFlReit5MU9PUjQ4?=
 =?utf-8?B?WVV4UUNSSUdmMUtzNWtqRVE1WklwTGhaUkJycndIM3ZUaytyaWlwbXBlVnlQ?=
 =?utf-8?B?OG9BQjllVEJ4Q0dEK2dnak5MUVVNSFFiNkZyNzJaaWJpUnMrcmE5LzhUYzJj?=
 =?utf-8?B?M1lrTi93ajg4a3FLbWRScU80anZ6SzZhb2ozNi9mWUUyZ2djN1UxTzZJdXo2?=
 =?utf-8?B?d1YramMvSkxreGtVbjVrTHhtZTlPK3I1VGtETklHN0ZZYTA4SGhINStLaDZ2?=
 =?utf-8?B?TzRqRHJsMWN4T3EyZFdPSVlPT2l1WVdjZW8weHdlWDc4aTAraXRZdTR1V0R0?=
 =?utf-8?B?am5uN2YzNEVJN2dHcTlkNGZ5ZEJXRTFONHpQV3ZQWFNRT2tVeHZhTFF6QmlR?=
 =?utf-8?B?UWNuWFRPSStCbHZTcVhaN056WTVpVTlHUGxzMDVpUWF2SGRKMDRsWHlaYWwv?=
 =?utf-8?B?bUpQMlVxSUxHWDMvRW9hRk5qRjFJbXJKQXBMS2FxS2UySXBJMmVOeTg0enlv?=
 =?utf-8?B?eVJ5My9Nb2JESEJLaVEyaTVBNEh3OVZSMlJSaEh2SHQ2MFZndmp5VnI0eVdE?=
 =?utf-8?B?d2JNMzgrT1VBNnRmd0NrRkQ4cXdKUDJYM1ZMVS9nOG1wK3F6M2NYWkh0SFVJ?=
 =?utf-8?B?M0xYOVFHZDU1Z2lxdXRlaVBVNXFXRS85bXFCb25kS3dLdU5kTzBJQ05wY201?=
 =?utf-8?B?Q2VEZzBCY2FEUEFHRk12Y1ZyNFF2ZkJVY21PT1BPOGlobGVVMzM5M21QcXA2?=
 =?utf-8?B?V3dBL2ZFT3lSeHNDUUZic0RIZFpBN0E0eUVtZ3ErZG9GVnZXQUVXVHVZSFRC?=
 =?utf-8?B?YTQxUjFaN2hiV1JxN0ZrSzJyazBXWmFrUHdDNUhHNVY4Z0NNSHg4UXZTdms1?=
 =?utf-8?Q?0WOaER6Ymse7ccPsWnFVV0uGHER4NF5nDat16Um?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c1944f-ca56-4f97-8344-08d91b0954be
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 21:01:54.1327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UA4qORHXOumwOatgN3pFuBqYAi+MYzibTpzGb1nfarLr0PF8eWuqyqIa8JU2htnYqChJ6K9ymb63PBgr+pIS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5122
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiAyMDIxLTA1LTE5IDQ6NTkgcC5tLiwgS2F6bGF1c2thcywgTmljaG9sYXMgd3JvdGU6Cj4g
T24gMjAyMS0wNS0xOSA0OjU1IHAubS4sIEF1cmFiaW5kbyBQaWxsYWkgd3JvdGU6Cj4+IFtXaHld
Cj4+IENvbmRpdGlvbnMgdGhhdCBlbmQgdXAgbW9kaWZ5aW5nIHRoZSBnbG9iYWwgZGMgc3RhdGUg
bXVzdCBiZSBsb2NrZWQuCj4+IEhvd2V2ZXIsIGR1cmluZyBtc3QgYWxsb2NhdGUgcGF5bG9hZCBz
ZXF1ZW5jZSwgbG9jayBpcyBhbHJlYWR5IHRha2VuLgo+PiBXaXRoIFN0YXJUZWNoIDEuMiBEUCBo
dWIsIHdlIGdldCBhbiBIUEQgUlggaW50ZXJydXB0IGZvciBhIHJlYXNvbiBvdGhlcgo+PiB0aGFu
IHRvIGluZGljYXRlIGRvd24gcmVwbHkgYXZhaWxhYmlsaXR5IHJpZ2h0IGFmdGVyIHNlbmRpbmcg
cGF5bG9hZAo+PiBhbGxvY2F0aW9uLiBUaGUgaGFuZGxlciBhZ2FpbiB0YWtlcyBkYyBsb2NrIGJl
Zm9yZSBjYWxsaW5nIHRoZQo+PiBkYydzIEhQRCBSWCBoYW5kbGVyLiBEdWUgdG8gdGhpcyBjb250
ZW50aW9uLCB0aGUgRFJNIHRocmVhZCB3aGljaCB3YWl0cwo+PiBmb3IgTVNUIGRvd24gcmVwbHkg
bmV2ZXIgZ2V0cyBhIGNoYW5jZSB0byBmaW5pc2ggaXRzIHdhaXRpbmcKPj4gc3VjY2Vzc2Z1bGx5
IGFuZCBlbmRzIHVwIHRpbWluZyBvdXQuIE9uY2UgdGhlIGxvY2sgaXMgcmVsZWFzZWQsIHRoZSBo
cGQKPj4gcnggaGFuZGxlciBmaXJlcyBhbmQgZ29lcyBhaGVhZCB0byByZWFkIGZyb20gdGhlIE1T
VCBIVUIsIGJ1dCBub3cgaXRzCj4+IHRvbyBsYXRlIGFuZCB0aGUgSFVCIGRvZXNudCBsaWdodHVw
IGFsbCBkaXNwbGF5cyBzaW5jZSBEUk0gbGFja3MgZXJyb3IKPj4gaGFuZGxpbmcgd2hlbiBwYXls
b2FkIGFsbG9jYXRpb24gZmFpbHMuCj4+Cj4+IFtIb3ddCj4+IFRha2UgbG9jayBvbmx5IGlmIHRo
ZXJlIGlzIGEgY2hhbmdlIGluIGxpbmsgc3RhdHVzIG9yIGlmIGF1dG9tYXRlZCB0ZXN0Cj4+IHBh
dHRlcm4gYml0IGlzIHNldC4gVGhlIGxhdHRlciBmaXhlcyB0aGUgbnVsbCBwb2ludGVyIGRlcmVm
ZXJlbmNlIHdoZW4KPj4gcnVubmluZyBjZXJ0YWluIERQIExpbmsgTGF5ZXIgQ29tcGxpYW5jZSB0
ZXN0Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBBdXJhYmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGls
bGFpQGFtZC5jb20+Cj4gCj4gRGlzY3Vzc2VkIHRoaXMgYSBiaXQgb2ZmbGluZSBhbmQgSSdkICpy
ZWFsbHkqIGxpa2UgdGhlIHByb3BlciBpbnRlcmZhY2UgaW4gc29vbmVyIHJhdGhlciB0aGFuIGxh
dGVyLgo+IAo+IENvbmRpdGlvbmFsIGxvY2tpbmcgaXMgYWxtb3N0IGFsd2F5cyBhIHNpZ24gb2Yg
YSBidWcsIGluIHRoaXMgY2FzZSB3ZSBrbm93IGl0J3MgT0sgYnV0IHNvbWVvbmUgY2FuIAo+IGNo
YW5nZSB0aGUgZnVuY3Rpb24gdW5kZXJuZWF0aCBsYXRlciB3aXRob3V0IHVuZGVyc3RhbmRpbmcg
dGhhdCB3ZSdyZSBkdXBsaWNhdGluZyBzb21lIG9mIHRoZSAKPiBjaGVja2luZyBsb2dpYyBpbiB0
aGUgdXBwZXIgbGF5ZXIuCj4gCj4gSSBkb24ndCB0aGluayB0aGUgY29kZSBjaGFuZ2VzIGVub3Vn
aCBpbiB0aGlzIGFyZWEgZm9yIHRoaXMgdG8gaGFwcGVuIChhcyBpdCdzIHNwZWMgYmFzZWQpLCBi
dXQgCj4gcGxlYXNlIGJlIG1pbmRmdWwgYW5kIGNvbnNpZGVyIHNwbGl0dGluZyB0aGUgY2hlY2tp
bmcgbG9naWMgKHdoaWNoIGlzIHRocmVhZCBzYWZlKSBvdXQgd2l0aCB0aGUgbGluayAKPiBsb3Nz
IGxvZ2ljICh0aGUgZnVuY3Rpb25hbCBiaXQsIHRoYXQgaXNuJ3QgdGhyZWFkIHNhZmUpLgo+IAo+
IFJldmlld2VkLWJ5OiBOaWNob2xhcyBLYXpsYXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFt
ZC5jb20+CgpUaGFua3MgZm9yIHRoZSByZXZpZXchIEknbGwgZ2V0IGJhY2sgdG8gZml4aW5nIHRo
aXMgcHJvcGVybHkgaW4gYSBmZXcgd2Vla3MuCj4gCj4gUmVnYXJkcywKPiBOaWNob2xhcyBLYXps
YXVza2FzCj4gCj4+IC0tLQo+PiDCoCAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMgfCAxOSArKysrKysrKysrKysrKysrKy0tCj4+IMKgIC4uLi9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jwqAgfMKgIDIgKy0KPj4gwqAgLi4uL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2RjX2xpbmtfZHAuaMKgwqAgfMKgIDQgKysrKwo+PiDCoCAz
IGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+Cj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9k
bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2Rt
LmMKPj4gaW5kZXggZTc5OTEwY2MxNzljLi4yYzlkMDk5YWRmYzIgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+PiBAQCAt
MjgsNiArMjgsNyBAQAo+PiDCoCAjaW5jbHVkZSAiZG1fc2VydmljZXNfdHlwZXMuaCIKPj4gwqAg
I2luY2x1ZGUgImRjLmgiCj4+ICsjaW5jbHVkZSAiZGNfbGlua19kcC5oIgo+PiDCoCAjaW5jbHVk
ZSAiZGMvaW5jL2NvcmVfdHlwZXMuaCIKPj4gwqAgI2luY2x1ZGUgImRhbF9hc2ljX2lkLmgiCj4+
IMKgICNpbmNsdWRlICJkbXViL2RtdWJfc3J2LmgiCj4+IEBAIC0yNzQwLDYgKzI3NDEsNyBAQCBz
dGF0aWMgdm9pZCBoYW5kbGVfaHBkX3J4X2lycSh2b2lkICpwYXJhbSkKPj4gwqDCoMKgwqDCoCBl
bnVtIGRjX2Nvbm5lY3Rpb25fdHlwZSBuZXdfY29ubmVjdGlvbl90eXBlID0gZGNfY29ubmVjdGlv
bl9ub25lOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gZHJtX3Rv
X2FkZXYoZGV2KTsKPj4gwqDCoMKgwqDCoCB1bmlvbiBocGRfaXJxX2RhdGEgaHBkX2lycV9kYXRh
Owo+PiArwqDCoMKgIGJvb2wgbG9ja19mbGFnID0gMDsKPj4gwqDCoMKgwqDCoCBtZW1zZXQoJmhw
ZF9pcnFfZGF0YSwgMCwgc2l6ZW9mKGhwZF9pcnFfZGF0YSkpOwo+PiBAQCAtMjc2OSwxNSArMjc3
MSwyOCBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfaHBkX3J4X2lycSh2b2lkICpwYXJhbSkKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqDCoCB9Cj4+IC3CoMKgwqAgaWYgKCFhbWRncHVf
aW5fcmVzZXQoYWRldikpIHsKPj4gK8KgwqDCoCAvKgo+PiArwqDCoMKgwqAgKiBUT0RPOiBXZSBu
ZWVkIHRoZSBsb2NrIHRvIGF2b2lkIHRvdWNoaW5nIERDIHN0YXRlIHdoaWxlIGl0J3MgYmVpbmcK
Pj4gK8KgwqDCoMKgICogbW9kaWZpZWQgZHVyaW5nIGF1dG9tYXRlZCBjb21wbGlhbmNlIHRlc3Rp
bmcsIG9yIHdoZW4gbGluayBsb3NzCj4+ICvCoMKgwqDCoCAqIGhhcHBlbnMuIFdoaWxlIHRoaXMg
c2hvdWxkIGJlIHNwbGl0IGludG8gc3ViaGFuZGxlcnMgYW5kIHByb3Blcgo+PiArwqDCoMKgwqAg
KiBpbnRlcmZhY2VzIHRvIGF2b2lkIGhhdmluZyB0byBjb25kaXRpb25hbGx5IGxvY2sgbGlrZSB0
aGlzIGluIHRoZQo+PiArwqDCoMKgwqAgKiBvdXRlciBsYXllciwgd2UgbmVlZCB0aGlzIHdvcmth
cm91bmQgdGVtcG9yYXJpbHkgdG8gYWxsb3cgTVNUCj4+ICvCoMKgwqDCoCAqIGxpZ2h0dXAgaW4g
c29tZSBzY2VuYXJpb3MgdG8gYXZvaWQgdGltZW91dC4KPj4gK8KgwqDCoMKgICovCj4+ICvCoMKg
wqAgaWYgKCFhbWRncHVfaW5fcmVzZXQoYWRldikgJiYKPj4gK8KgwqDCoMKgwqDCoMKgIChocGRf
cnhfaXJxX2NoZWNrX2xpbmtfbG9zc19zdGF0dXMoZGNfbGluaywgJmhwZF9pcnFfZGF0YSkgfHwK
Pj4gK8KgwqDCoMKgwqDCoMKgwqAgaHBkX2lycV9kYXRhLmJ5dGVzLmRldmljZV9zZXJ2aWNlX2ly
cS5iaXRzLkFVVE9NQVRFRF9URVNUKSkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9j
aygmYWRldi0+ZG0uZGNfbG9jayk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBsb2NrX2ZsYWcgPSAxOwo+
PiArwqDCoMKgIH0KPj4gKwo+PiDCoCAjaWZkZWYgQ09ORklHX0RSTV9BTURfRENfSERDUAo+PiDC
oMKgwqDCoMKgIHJlc3VsdCA9IGRjX2xpbmtfaGFuZGxlX2hwZF9yeF9pcnEoZGNfbGluaywgJmhw
ZF9pcnFfZGF0YSwgTlVMTCk7Cj4+IMKgICNlbHNlCj4+IMKgwqDCoMKgwqAgcmVzdWx0ID0gZGNf
bGlua19oYW5kbGVfaHBkX3J4X2lycShkY19saW5rLCBOVUxMLCBOVUxMKTsKPj4gwqAgI2VuZGlm
Cj4+ICvCoMKgwqAgaWYgKCFhbWRncHVfaW5fcmVzZXQoYWRldikgJiYgbG9ja19mbGFnKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5kbS5kY19sb2NrKTsKPj4gLcKg
wqDCoCB9Cj4+IMKgIG91dDoKPj4gwqDCoMKgwqDCoCBpZiAocmVzdWx0ICYmICFpc19tc3Rfcm9v
dF9jb25uZWN0b3IpIHsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jb3JlL2RjX2xpbmtfZHAuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY29yZS9kY19saW5rX2RwLmMKPj4gaW5kZXggOWUwODQxMGJmZGZkLi4zMmZiOWNkYmQ5ODAg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xp
bmtfZHAuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19s
aW5rX2RwLmMKPj4gQEAgLTIwNzAsNyArMjA3MCw3IEBAIGVudW0gZGNfc3RhdHVzIHJlYWRfaHBk
X3J4X2lycV9kYXRhKAo+PiDCoMKgwqDCoMKgIHJldHVybiByZXR2YWw7Cj4+IMKgIH0KPj4gLXN0
YXRpYyBib29sIGhwZF9yeF9pcnFfY2hlY2tfbGlua19sb3NzX3N0YXR1cygKPj4gK2Jvb2wgaHBk
X3J4X2lycV9jaGVja19saW5rX2xvc3Nfc3RhdHVzKAo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkY19s
aW5rICpsaW5rLAo+PiDCoMKgwqDCoMKgIHVuaW9uIGhwZF9pcnFfZGF0YSAqaHBkX2lycV9kcGNk
X2RhdGEpCj4+IMKgIHsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9pbmMvZGNfbGlua19kcC5oIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9pbmMvZGNfbGlua19kcC5oCj4+IGluZGV4IGZmYzNmMmM2M2RiOC4uN2RkOGJjYTU0MmI5IDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2RjX2xpbmtf
ZHAuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvaW5jL2RjX2xpbmtf
ZHAuaAo+PiBAQCAtNjgsNiArNjgsMTAgQEAgYm9vbCBwZXJmb3JtX2xpbmtfdHJhaW5pbmdfd2l0
aF9yZXRyaWVzKAo+PiDCoMKgwqDCoMKgIGVudW0gc2lnbmFsX3R5cGUgc2lnbmFsLAo+PiDCoMKg
wqDCoMKgIGJvb2wgZG9fZmFsbGJhY2spOwo+PiArYm9vbCBocGRfcnhfaXJxX2NoZWNrX2xpbmtf
bG9zc19zdGF0dXMoCj4+ICvCoMKgwqAgc3RydWN0IGRjX2xpbmsgKmxpbmssCj4+ICvCoMKgwqAg
dW5pb24gaHBkX2lycV9kYXRhICpocGRfaXJxX2RwY2RfZGF0YSk7Cj4+ICsKPj4gwqAgYm9vbCBp
c19tc3Rfc3VwcG9ydGVkKHN0cnVjdCBkY19saW5rICpsaW5rKTsKPj4gwqAgYm9vbCBkZXRlY3Rf
ZHBfc2lua19jYXBzKHN0cnVjdCBkY19saW5rICpsaW5rKTsKPj4KPiAKCi0tIApSZWdhcmRzLApB
dXJhYmluZG8gUGlsbGFpCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
