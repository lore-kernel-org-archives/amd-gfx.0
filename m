Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E72C48BE8
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:41:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9462613B9
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9462613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757526E20E;
	Tue, 15 Jun 2021 08:41:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C3EF6E20E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 08:41:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmCqGiyBjukBloQr+wX9IXgGksv31to81uO5pFxB69TqSt7ynYAwkz/CefS7b2Wj1PU4x+f36NgRj7N/sFmSbYA7b/ArqQJiQAlK5AlHYQTJWG9e8CxbhHqHbjIpEUNsCckA+PVas+i6NjmCohXrmNI/QygqXSnhihIl5JizWrFP5OPcFfkmBGOrm1XFld92dLcp+4yaMhHwND4aQEGBWIiWWOs0PqQzSsYkd6iZrKkQIqXX4VvP7BQWaXjyik3DwvB0aM+vEZXMB6VISWe+3kl6Bs0t0cpOGw4KQYUGGqwgMv5KqBeid0bGrFfHzPMtoOHrumTf1E+zFdAXKNinIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwSQc33isQcF2vLqvEmqzAWu+eC8jR1frd44JznecBo=;
 b=OhElBjvxIAJAM97ewFQVO6Q3N8VXdNeOl77DjFcb0ZdurVo5pSvmjYHFHqNDv8HLxdSgiV3ZcQnaG4r++x/7/UQPrgSlsvNEou319wLKOeN6/krhj/ksgpLQGN4Tds0A4+rfN0NyiiTDYraaqEs8pOS4teg9uwXu6mnpGIWnZ+cRSS1BGjdDaLIsdneoHv4MDwH+9DdxYXCQ5A9668R7T8hqibFtUV3eUnBjHVuIYahBOB+uSgt8xP4gWgfwuXl35CYTocdqEtsadVkgzKSaWVPRrV7JQZ9M7OffQV5U/x+NSpucQTg7QDJes4IEHTWSsvqdXRKEWzUO0qW7+IBfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwSQc33isQcF2vLqvEmqzAWu+eC8jR1frd44JznecBo=;
 b=hOtCB2qwgPTkGVp1GyQMP0KFIlwQyk0Fsf9YaapL9TR/Y1TMc/7qB1kXQkaTpGlfkH0QBV5WrAE79LUc3mKh2D7lRFOd1zFNNrMvENfMOurIyORrvy8rx5Cf/1u225w7ZdhMcxCoySPcGkqJ4cKtSWYVpS+OBUdwb1ogsaJOMHU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 08:41:47 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 08:41:47 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210614192653.18239-1-nirmoy.das@amd.com>
 <66e1a5db-17f7-fb27-5155-29e194556210@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <d7a988b4-e775-5ab6-8b58-3ff4244788b9@amd.com>
Date: Tue, 15 Jun 2021 10:41:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <66e1a5db-17f7-fb27-5155-29e194556210@amd.com>
Content-Language: en-US
X-Originating-IP: [2003:c5:8f25:c00:389e:e320:3bf5:cf96]
X-ClientProxiedBy: PR0P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f25:c00:389e:e320:3bf5:cf96]
 (2003:c5:8f25:c00:389e:e320:3bf5:cf96) by
 PR0P264CA0174.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 08:41:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5cbb14fd-bdf0-4e6d-9751-08d92fd96935
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB507192EA806E777451EFB8BF8B309@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Hkb5id0gl365guu10anlM5QjdUFKoORQmEcG4Zqfq7W7B5iR23DKWpgHtrpFDpNbTUkofw/jWas5z0Lz+hStnNt7WkReGY+8pab1ATgAGiJngg1kmpoj6Q1ZwuuVz8kCYMisAzW+JDwe1FnUmvIVrjXELjlBKey7rtFGymw0JkEBtICZvYSOmQxbj+U0MjWDHtqNgMMf3mAARI1TXOlnj29pkhMoji3OzU9U0Ic+ZDTDVamDJ8bEh4WG4CISggPS0/BUtLyEHpHzMdIrJhKzX1m9y1nLVJMSAmbIZ7ScmcMyjoyIiGBgOT6Acbz7XKWCquQykmFcGM4rZqQKo1aPulp7DCXc7s/KybBSJmWSyBHd0jZBXs9ZJwlZZFErkIuKQVAAGNhWsoPWOptSmyaFH3l9l3Mm5zadNRVy125TCe7oNPr9JvobJ96fenLrSdCGDTIkfijMBDozs3nEFye/GnPRsX+Dl02K3WHNWLqLLt7CfePOw1Dx8omtxue6FT0SuOKgNnSAvf39Yq0x5SqX8KE109c98jAwU8q8NXG0T/D9VMKVKKtUC0XNOMcMzmkXidjllxTwWGt8rapEA8XD+MQsQBtZxW62m4HUJV6GUDquJ2LjPerNQTUYZegltmpiUVKe8GZHo8ujtVBaLg4uqJaSrfbcPRRjTOY2rB9W2Ybmwl8WesGmGzd0vN5eStx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(2906002)(66476007)(66556008)(66946007)(38100700002)(2616005)(6666004)(52116002)(86362001)(66574015)(31686004)(83380400001)(316002)(5660300002)(8676002)(8936002)(36756003)(478600001)(53546011)(31696002)(16526019)(6486002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0E3OWw4TkxGMzhIUG1pQi9wdm8vTmVqT1JqbDlWUXhCSExRbW12YUpObWNr?=
 =?utf-8?B?R2JaSjNlVG5wNjdHeDBnb3VlZ01ibFNVQkNjam8vOWYzN2EzbHE1Q0lWYXNz?=
 =?utf-8?B?UXNhTHNEc0hmMmNpRitiRHlLK0hJWjRLb054Y0swWlRzbDdzNm5HS0k4SWNG?=
 =?utf-8?B?YzQ2SUtPbjVmcmt4WENIVXdWZ1dISWg5TkNyUE1RVFFsNVRENjk3TW8wNG5C?=
 =?utf-8?B?TG5uMG5mTDBzS1VpMGFxTHhNTHB2N2FJUzRPaWRGZ25NUjh2aEtodkxzNXBs?=
 =?utf-8?B?NnJUdlpYem5JUks4Q2xMS3NMa21Dd0lhSkNpQ213VThhcGtKSmlyNzgxdlBJ?=
 =?utf-8?B?WDRkaEc0RWJIMXROUnFYL0IrejVlcEVCTkxraGdJV3liTjM1cjNWQ0haWEVk?=
 =?utf-8?B?dmQ1ZHZTUjFrRFFIaUJYVCt3elNhUTRvSGVsa0dRcUh6a2k2ejE3dVZKVk9R?=
 =?utf-8?B?U1IwOTU4MkFmQm9YYTVUSlU0eExaU1JabStLUGpPcHYvOUxJT1VXbVlObENO?=
 =?utf-8?B?N1lhN09BV25NMWxKdUcwQ1lSWm1XT2RkbW45K3ZGTWl2R095Qm9BSGQ4d280?=
 =?utf-8?B?eUcyT0VuQ08xazNMRlU0dVlSOVJVK2ZNSjE0U3VZRHM5Vyt4Mmp6UVVYTGND?=
 =?utf-8?B?OGhLTCtwYXE5TkxCZHRESFJWTnhLR3pvQmNaQVExaUM2eEtxTnV5M3BtQ0lW?=
 =?utf-8?B?WGJGNWF6QzlqalNJdHJoYS9oTkZCNjdQRkhhanpCb2wxbkpxeTJjYlc5azJZ?=
 =?utf-8?B?TCtDR2hSRkFWWGRoMVhyV1FkbjJUdnROcUJsRHNjaUh5dXdtTENQL2FVS3Q4?=
 =?utf-8?B?QkhnUFVBOHBxcG00T1FFbTg3TXJTTUZVbzZJK2htL2VjaDlvZHc1TDFYaDcv?=
 =?utf-8?B?RUJsaTFZNThmNlZ1MUEzajVMWDIzUkxvelRFd0tBR1M1bTI0d20vK1Q3ZEg3?=
 =?utf-8?B?aUpFRXljNUI4a1ZOMndjMHIvejZuNFBITFZxNGtZYWFSSWc4NjZJak85aVl5?=
 =?utf-8?B?WDdSV3FSdE5Kc2MwbVJnK0NrZXJRL0FhOWZXVjFIYnA3VCtVWHAvb0hjeHZS?=
 =?utf-8?B?M1NhRXRMeUlLTkM4N1NORmkyS0F2MkFZRTVVQnhGQUV2bGwxYy9CZEptTmRu?=
 =?utf-8?B?Q1NaTHhZYThmYUlsVTRjZVhxTm5EMk04eHlXaGd0STltZ1NnQXVUNWxmN0sy?=
 =?utf-8?B?a1o5UVBxWm10ZzJReXVEUWk3U2psREp4enRWNVhML1ZZd256QUJkZGtmUjlQ?=
 =?utf-8?B?TU4zMHRkYzB4Zm1ya2ZqajZDVWUrRkV3S2k5MTV1VGRvTUovL0hvNyszMVBS?=
 =?utf-8?B?c3NwYTJ6R0pMR2dWZ2dFMjBIZVBpWFA4dm83TXVDTS9jYURUNWRiNFNsWWR3?=
 =?utf-8?B?OWQyaWx4SG1kOVBleXJoWkdLdW03L0NldzJGT290QUxGRkt5YUdSYjV5MC9m?=
 =?utf-8?B?akE2Wm80amNkZnp4djc5STlmanAxb0RER2h2cmNWWkhTNFVUbUw4NWRGdGNq?=
 =?utf-8?B?bEtMakRwTEo4bm4ram9EMXZJMDJZMFpsbDAwVUVYZ1RpWUJjTlBXNFVyaTdj?=
 =?utf-8?B?c0E2S0N2MFg4QVpOazNqZ0VNOU9yNEhaN3ZtR25kQ3JSNWpXUGdwNzlacEpm?=
 =?utf-8?B?blRLZTV4emJrcjByLzBobzNrRk5nTzlOdk1LMVVmSzRkTUV3Q21uVnVCV2o1?=
 =?utf-8?B?bHdGQ0ltRmZ6K1pGTnpUMU1reDRWRFJsRlFJNWJrQTJtclQwMU5uZSt1Z2Vs?=
 =?utf-8?B?TjVNVGM5T0U5R0gzWVF3YnNrYmlkdmVlSXp3R0JNSnR4NXA4Sk42OGNyMmI1?=
 =?utf-8?B?Y0pIS3JoVW5IT3JOM0pZbnJac1Q3WmxueUtGODZGSUF1M3g4cDhWem5nd1I0?=
 =?utf-8?Q?XKRf6iPR1tkNY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cbb14fd-bdf0-4e6d-9751-08d92fd96935
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 08:41:47.0608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNLDzmc8Z5kQ3D7Fn2bN6TFOg0gxAieHtEWF9PPQRlucpsKJB0JTrf6vcSoxfg6w0hddqX7PDu1GIt8ZSsr0aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
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

Ck9uIDYvMTUvMjAyMSA4OjUzIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE0LjA2
LjIxIHVtIDIxOjI2IHNjaHJpZWIgTmlybW95IERhczoKPj4gTWFrZSBwcm92aXNpb24gdG8gcGFz
cyBkaWZmZXJlbnQgdHRtIEJPIGRlc3Ryb3kgY2FsbGJhY2sKPj4gd2hpbGUgY3JlYXRpbmcgYSBh
bWRncHVfYm8uCj4+Cj4+IHYyOiBwYXNzIGRlc3Ryb3kgY2FsbGJhY2sgdXNpbmcgYW1kZ3B1X2Jv
X3BhcmFtLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5j
b20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0
LmMgfCA1MiArKysrKysrKysrKysrKysrKy0tLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8wqAgMyArLQo+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDQy
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIAo+PiBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwo+PiBpbmRleCA5MDkyYWMxMmEyNzAuLmY0ZjU3
YTczZDA5NSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X29iamVjdC5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYwo+PiBAQCAtMTIsNyArMTIsNyBAQAo+PiDCoMKgICoKPj4gwqDCoCAqIFRIRSBTT0ZUV0FS
RSBJUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBLSU5ELCAKPj4g
RVhQUkVTUyBPUgo+PiDCoMKgICogSU1QTElFRCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBU
TyBUSEUgV0FSUkFOVElFUyBPRiAKPj4gTUVSQ0hBTlRBQklMSVRZLAo+PiAtICogRklUTkVTUyBG
T1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5PTi1JTkZSSU5HRU1FTlQuIElOIE5PIAo+PiBF
VkVOVCBTSEFMTAo+PiArICogRklUTkVzUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UgQU5EIE5P
Ti1JTkZSSU5HRU1FTlQuIElOIE5PIAo+PiBFVkVOVCBTSEFMTAo+PiDCoMKgICogVEhFIENPUFlS
SUdIVCBIT0xERVJTLCBBVVRIT1JTIEFORC9PUiBJVFMgU1VQUExJRVJTIEJFIExJQUJMRSAKPj4g
Rk9SIEFOWSBDTEFJTSwKPj4gwqDCoCAqIERBTUFHRVMgT1IgT1RIRVIgTElBQklMSVRZLCBXSEVU
SEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgCj4+IFRPUlQgT1IKPj4gwqDCoCAqIE9USEVS
V0lTRSwgQVJJU0lORyBGUk9NLCBPVVQgT0YgT1IgSU4gQ09OTkVDVElPTiBXSVRIIFRIRSAKPj4g
U09GVFdBUkUgT1IgVEhFCj4+IEBAIC03MywxMSArNzMsOSBAQCBzdGF0aWMgdm9pZCBhbWRncHVf
Ym9fc3VidHJhY3RfcGluX3NpemUoc3RydWN0IAo+PiBhbWRncHVfYm8gKmJvKQo+PiDCoMKgwqDC
oMKgIH0KPj4gwqAgfQo+Pgo+PiAtc3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3RydWN0
IHR0bV9idWZmZXJfb2JqZWN0ICp0Ym8pCj4+ICtzdGF0aWMgdm9pZCBhbWRncHVfYm9fZGVzdHJv
eV9iYXNlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqdGJvKQo+PiDCoCB7Cj4+IC3CoMKgwqAg
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRtX2FkZXYodGJvLT5iZGV2KTsK
Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IHR0bV90b19hbWRncHVfYm8odGJv
KTsKPj4gLcKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPj4KPj4gwqDCoMKgwqDC
oCBpZiAoYm8tPnRiby5waW5fY291bnQgPiAwKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1
X2JvX3N1YnRyYWN0X3Bpbl9zaXplKGJvKTsKPj4gQEAgLTg3LDE4ICs4NSw0MCBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfYm9fZGVzdHJveShzdHJ1Y3QgCj4+IHR0bV9idWZmZXJfb2JqZWN0ICp0Ym8p
Cj4+IMKgwqDCoMKgwqAgaWYgKGJvLT50Ym8uYmFzZS5pbXBvcnRfYXR0YWNoKQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgZHJtX3ByaW1lX2dlbV9kZXN0cm95KCZiby0+dGJvLmJhc2UsIGJvLT50Ym8u
c2cpOwo+PiDCoMKgwqDCoMKgIGRybV9nZW1fb2JqZWN0X3JlbGVhc2UoJmJvLT50Ym8uYmFzZSk7
Cj4+ICvCoMKgwqAgYW1kZ3B1X2JvX3VucmVmKCZiby0+cGFyZW50KTsKPj4gK30KPj4gKwo+PiAr
c3RhdGljIHZvaWQgYW1kZ3B1X2JvX2Rlc3Ryb3koc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICp0
Ym8pCj4+ICt7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1
X2JvKHRibyk7Cj4+ICsKPj4gK8KgwqDCoCBhbWRncHVfYm9fZGVzdHJveV9iYXNlKHRibyk7Cj4+
ICvCoMKgwqAga3ZmcmVlKGJvKTsKPj4gK30KPj4gKwo+PiArc3RhdGljIHZvaWQgYW1kZ3B1X2Jv
X3VzZXJfZGVzdHJveShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKnRibykKPj4gK3sKPj4gK8Kg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9IHR0bV90b19hbWRncHVfYm8odGJvKTsKPj4gK8Kg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3VzZXIgKnVibzsKPj4gKwo+PiArwqDCoMKgIGFtZGdwdV9i
b19kZXN0cm95X2Jhc2UodGJvKTsKPj4gK8KgwqDCoCB1Ym8gPSB0b19hbWRncHVfYm9fdXNlcihi
byk7Cj4+ICvCoMKgwqAga2ZyZWUodWJvLT5tZXRhZGF0YSk7Cj4+ICvCoMKgwqAga3ZmcmVlKGJv
KTsKPgo+IFdoeSBub3QgZnJlZWluZyB0aGUgbWV0YWRhdGEgZmlyc3QgYW5kIGhhdmluZyB0aGUg
a3ZmcmVlKCkgaW4gCj4gYW1kZ3B1X2JvX2Rlc3Ryb3koKT8KCgpEaWRuJ3QgdGhpbmsgYWJvdXQg
dGhhdCwgaXQgd291bGQgYmUgbWUgbXVjaCBjbGVhbmVyLgoKClRoYW5rcywKCk5pcm1veQoKPgo+
IEFwYXJ0IGZyb20gdGhhdCBsb29rcyBnb29kIHRvIG1lLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+ICt9
Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIGFtZGdwdV9ib192bV9kZXN0cm95KHN0cnVjdCB0dG1fYnVm
ZmVyX29iamVjdCAqdGJvKQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHRiby0+YmRldik7Cj4+ICvCoMKgwqAgc3RydWN0IGFtZGdw
dV9ibyAqYm8gPSB0dG1fdG9fYW1kZ3B1X2JvKHRibyk7Cj4+ICsKPj4gK8KgwqDCoCBhbWRncHVf
Ym9fZGVzdHJveV9iYXNlKHRibyk7Cj4+IMKgwqDCoMKgwqAgLyogaW4gY2FzZSBhbWRncHVfZGV2
aWNlX3JlY292ZXJfdnJhbSBnb3QgTlVMTCBvZiBiby0+cGFyZW50ICovCj4+IMKgwqDCoMKgwqAg
aWYgKCFsaXN0X2VtcHR5KCZiby0+c2hhZG93X2xpc3QpKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBtdXRleF9sb2NrKCZhZGV2LT5zaGFkb3dfbGlzdF9sb2NrKTsKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGxpc3RfZGVsX2luaXQoJmJvLT5zaGFkb3dfbGlzdCk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBtdXRleF91bmxvY2soJmFkZXYtPnNoYWRvd19saXN0X2xvY2spOwo+PiDCoMKgwqDCoMKgIH0K
Pj4gLcKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmJvLT5wYXJlbnQpOwo+PiAtCj4+IC3CoMKgwqAg
aWYgKGJvLT50Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKPj4gLcKgwqDCoMKgwqDC
oMKgIHVibyA9IHRvX2FtZGdwdV9ib191c2VyKGJvKTsKPj4gLcKgwqDCoMKgwqDCoMKgIGtmcmVl
KHViby0+bWV0YWRhdGEpOwo+PiAtwqDCoMKgIH0KPj4KPj4gwqDCoMKgwqDCoCBrdmZyZWUoYm8p
Owo+PiDCoCB9Cj4+IEBAIC0xMTUsOCArMTM1LDExIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9ib19k
ZXN0cm95KHN0cnVjdCAKPj4gdHRtX2J1ZmZlcl9vYmplY3QgKnRibykKPj4gwqDCoCAqLwo+PiDC
oCBib29sIGFtZGdwdV9ib19pc19hbWRncHVfYm8oc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bykKPj4gwqAgewo+PiAtwqDCoMKgIGlmIChiby0+ZGVzdHJveSA9PSAmYW1kZ3B1X2JvX2Rlc3Ry
b3kpCj4+ICvCoMKgwqAgaWYgKGJvLT5kZXN0cm95ID09ICZhbWRncHVfYm9fZGVzdHJveSB8fAo+
PiArwqDCoMKgwqDCoMKgwqAgYm8tPmRlc3Ryb3kgPT0gJmFtZGdwdV9ib191c2VyX2Rlc3Ryb3kg
fHwKPj4gK8KgwqDCoMKgwqDCoMKgIGJvLT5kZXN0cm95ID09ICZhbWRncHVfYm9fdm1fZGVzdHJv
eSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+PiArCj4+IMKgwqDCoMKgwqAg
cmV0dXJuIGZhbHNlOwo+PiDCoCB9Cj4+Cj4+IEBAIC01OTIsOSArNjE1LDEyIEBAIGludCBhbWRn
cHVfYm9fY3JlYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgIGlm
IChicC0+dHlwZSA9PSB0dG1fYm9fdHlwZV9rZXJuZWwpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBi
by0+dGJvLnByaW9yaXR5ID0gMTsKPj4KPj4gK8KgwqDCoCBpZiAoIWJwLT5kZXN0cm95KQo+PiAr
wqDCoMKgwqDCoMKgwqAgYnAtPmRlc3Ryb3kgPSAmYW1kZ3B1X2JvX2Rlc3Ryb3k7Cj4+ICsKPj4g
wqDCoMKgwqDCoCByID0gdHRtX2JvX2luaXRfcmVzZXJ2ZWQoJmFkZXYtPm1tYW4uYmRldiwgJmJv
LT50Ym8sIHNpemUsIAo+PiBicC0+dHlwZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZiby0+cGxhY2VtZW50LCBwYWdlX2FsaWduLCAmY3R4LCBOVUxMLAo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnAtPnJlc3YsICZhbWRncHVfYm9fZGVzdHJv
eSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicC0+cmVzdiwgYnAtPmRl
c3Ryb3kpOwo+PiDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShyICE9IDApKQo+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHI7Cj4+Cj4+IEBAIC02NTgsNiArNjg0LDcgQEAgaW50IGFtZGdwdV9i
b19jcmVhdGVfdXNlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAKPj4gKmFkZXYsCj4+IMKgwqDCoMKg
wqAgaW50IHI7Cj4+Cj4+IMKgwqDCoMKgwqAgYnAtPmJvX3B0cl9zaXplID0gc2l6ZW9mKHN0cnVj
dCBhbWRncHVfYm9fdXNlcik7Cj4+ICvCoMKgwqAgYnAtPmRlc3Ryb3kgPSAmYW1kZ3B1X2JvX3Vz
ZXJfZGVzdHJveTsKPj4gwqDCoMKgwqDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZShhZGV2LCBicCwg
JmJvX3B0cik7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcjsKPj4gQEAgLTY4OSw2ICs3MTYsNyBAQCBpbnQgYW1kZ3B1X2JvX2NyZWF0ZV92bShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoMKgICogbnVtIG9mIGFtZGdwdV92
bV9wdCBlbnRyaWVzLgo+PiDCoMKgwqDCoMKgwqAgKi8KPj4gwqDCoMKgwqDCoCBCVUdfT04oYnAt
PmJvX3B0cl9zaXplIDwgc2l6ZW9mKHN0cnVjdCBhbWRncHVfYm9fdm0pKTsKPj4gK8KgwqDCoCBi
cC0+ZGVzdHJveSA9ICZhbWRncHVfYm9fdm1fZGVzdHJveTsKPj4gwqDCoMKgwqDCoCByID0gYW1k
Z3B1X2JvX2NyZWF0ZShhZGV2LCBicCwgJmJvX3B0cik7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcjsKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKPj4gaW5kZXggZTM2Yjg0NTE2YjRlLi5hOGM3MDI2MzRl
MWIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgK
Pj4gQEAgLTU1LDcgKzU1LDggQEAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSB7Cj4+IMKgwqDCoMKg
wqAgdTY0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZsYWdzOwo+PiDCoMKgwqDCoMKg
IGVudW0gdHRtX2JvX3R5cGXCoMKgwqDCoMKgwqDCoCB0eXBlOwo+PiDCoMKgwqDCoMKgIGJvb2zC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbm9fd2FpdF9ncHU7Cj4+IC3CoMKgwqAgc3Ry
dWN0IGRtYV9yZXN2wqDCoMKgICpyZXN2Owo+PiArwqDCoMKgIHN0cnVjdCBkbWFfcmVzdsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKnJlc3Y7Cj4+ICvCoMKgwqAgdm9pZMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoKmRlc3Ryb3kpKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8pOwo+
PiDCoCB9Owo+Pgo+PiDCoCAvKiBibyB2aXJ0dWFsIGFkZHJlc3NlcyBpbiBhIHZtICovCj4+IC0t
IAo+PiAyLjMxLjEKPj4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
