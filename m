Return-Path: <SRS0=twpl=GV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589C6C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41F622C7E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jan 2021 14:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41F622C7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D6AB6E3B7;
	Mon, 18 Jan 2021 14:55:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD89A6E3B7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jan 2021 14:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dORbltsEwgE5WpYTwfFe20Zn/FNYWFhfiS1KtgrTU1IDeYNC3Tj80pnAWIuUDfsi50uEOgkYpMHGfKAuf3JB6A3LHVmDiRPSzRhxacYmyMMzz6cNKsZLVt/S7sKt0ubIdPxxQydnd4xUOCI/z0nmmQK8CEDkeXp49veYhZ/Hox2O419ur23GLLzk8S4gBBpzpl3BW5Fg2KGq4uvLWyAnrjlhwd+hItT1pV1cnT0gm6Ol+XJEDRqq4w3FW/NhYta7dZeRqEp5x2+jcVk42h6T4yhey3AjEarUPqGkaN4rIsxcM35ezLvkR658yIwDN1p3AJqRXv5ZVU+E83h6N1IsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kFuW+1/Whp3kThHeOMCludisaolTTxdS5W2xarC6yM=;
 b=S4Q1u3cexPS3yVbWmtUY9N7d7fwGe7i3XtY9MKNNH2j6NGlRApouDTM1zeakm/gkIfV3Df5ZaYB5yrOBmDDOQN7GrIDF21MJqoo9MX2fZN24JbasRiXfPIKSqYGS+IjXB07wc7cIngI2uabjA0vf4l4KYrkCh84EBG/J/laDljXwe8HoYH8Rb/G0bkvOgSn3xvLZRnqrU8PzrkmjfHL1JqVQs+crFa0+7t0ZPfHkV10SXgiTLtp9+sL6oOhrmPEWNC0cc0TJSgryWxo/GPcWfWOb3FxbQO5rao+A0UHrL/z2ZC8cTdT6XOVqsoIIialyz80zdfKYBYFqPGpB3PAd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kFuW+1/Whp3kThHeOMCludisaolTTxdS5W2xarC6yM=;
 b=wpB9HehkYfl9WCeZbILzIqFjsJTUNG2oo7xqsoMyE0A+pvRAJ1Gbj6OIy52ky4o04TUXDqx11bpxQqTgzCJHQqaz2bMVPf/2FnuHbUkPUYpbrFO8R39sA/Pj8Jsk2AAHRRIrT3gCRWzbCBhUWy8dEnDXr2kTdgf9Zjj9Y0tKrm8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 14:55:40 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 14:55:40 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: Enable userptr support when KFD is enabled
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210115182423.32368-1-Felix.Kuehling@amd.com>
 <a4af46c0-f33e-d93a-4eae-bee52892e8bf@gmail.com>
 <b94a787c-f7f2-1141-c7df-c0950f8d1904@amd.com>
 <30326fb3-a772-e297-af3f-bfb970bcf275@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f74b3692-ff14-0221-5efc-ef79ecf47d2b@amd.com>
Date: Mon, 18 Jan 2021 09:55:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <30326fb3-a772-e297-af3f-bfb970bcf275@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 14:55:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c3477087-9e23-411c-5a7b-08d8bbc11f07
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4375E9605EEE87E307EC979C92A40@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1puTatinZcc/x2BNUS++cvI3UeMlZuV89UgMZmsjd8HCJjcbRRMPhdTABlGw9eHtxCqbaRQ1NTgJwhkvEnHaGc4qdQPMsXu5Udk3hp0oUu3dRS2mK5AbHXcabcp1zGTBHWnzw2B8ynZ0dOiwtc0gx8xjLkYJfN3rwne9vyYZlKDqTCtL6Lbx/BLx3QT0jb6DwUz9M6+xs3lN5ZDWiWFv3hY+WNsauCb4R4J0jZXkCOpzvQnGROPO4940o12gzLUhMhu+7nx8OOzy3F/eqmOV5QZ5KMCF7540oVJv99HIVR7R8z+SF8QqoG1e3ZBvaWmIxPTYx+MHxL2B3ohrb9TihqauJu7F9ITb8bgs6Edfzduret+S8iBCDopxQQ0tykt3Noh9JQQ68GxhZuU4UR6eXhzJIn6ff2qni2q93rKYBh47zReZSULh325JEoCnwcR9EW1gmKkeKz6Sz5Hcn/HvZmkzbO0RV4WRTBLm+k66lY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(478600001)(2616005)(956004)(44832011)(66476007)(66556008)(66946007)(5660300002)(16526019)(2906002)(186003)(31696002)(6486002)(316002)(16576012)(36756003)(86362001)(26005)(52116002)(8676002)(31686004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cUw5S0dsK0w4QUFPeEtzVlJkMXhlYTZNU2ZZK3RNUEFtNUdKMkdwMHJQemR2?=
 =?utf-8?B?cDl1M2pzSlZucklObkMwRFFmWkpWeGc4R0hmUWNtd1hML091WEZpT2MzNU5R?=
 =?utf-8?B?VXBVL1VVV3E1c3pRNWlINXE4L0t4VWpWUEZIb3RSRGtVNExlQU9VbXhLOVB3?=
 =?utf-8?B?cHl5bGlsUmpHV2EwSm43STBDbks2MEZMOUNjZEl4Yk5TL2tuSHltbkh5WWlM?=
 =?utf-8?B?SGhCSGZFUkt3OS9wZDcyMkpYNlpyT1Nqd2NDL1RJcG9DTW1xZ1RaVjR3TlEz?=
 =?utf-8?B?dkRXRmNlRytPMnFrS2ppQzI4T3RyTENuMDJXOXBZdEQxeFV4Sk5OODJVV2t0?=
 =?utf-8?B?Y0dZRmZDazJlV255aTg4ZWhDTjJnZUZMQ09iTytOQVRCakxDWkhKOXp3UEEw?=
 =?utf-8?B?MDF0aHhqMWtnZ2U5dUJyZTI5MlpadmR4K3RnNlpwejZ4QUpCam9qRXFFVExn?=
 =?utf-8?B?Vm8yY1RJMUFsRmJnRmVZOVNVTEc1VkJLUmMzaDFMOHNQL0d4azdnNk9sWUY5?=
 =?utf-8?B?dVFxVmQwMmhVczdES3BhZEVhYXV3VzhkOTVCL1Q2QjVmaXNyOWlsYWZpSDFG?=
 =?utf-8?B?dzl0Y0djK2FyMlN2ODdBcFk0NXVxV3pRZ0trYWRCZmdRbjQyVjBXQWpaaklB?=
 =?utf-8?B?NG1XL0NVOFp1bHc0eGVOMVAyZVJ1VHJHVGUrakJ2SVZoMHV4TWYveVFacG5I?=
 =?utf-8?B?c1ZEOG9KOElKK1dEdFAwdFZzRDFVWVhNT0VVZFZxL2RPMktBVGtpVVBISDJ1?=
 =?utf-8?B?T0U0U2xWck5WV0tNVTM3OXgrb0VXejVleTdvMEJzOFlKNTU5ckpMSXlSK1k0?=
 =?utf-8?B?b0NaeXlnZG1WcmdUYkRSakorZE1hK0ZHSXFhK2VmWkQ5UVN1dTZUVCtxUDBk?=
 =?utf-8?B?NnROcjgwR09ud0JJSVE1cTR6T2EwWlYvWlJDb001bGRQdUU3bGthQUovOE53?=
 =?utf-8?B?ZE05YzkzMGVaZXJmdVZuc2JXbjl5V3djNTFjZFBwQTdPMnF2RDJZcWJEMnB6?=
 =?utf-8?B?Wko4V0hPMUFtZzU3VlprVXBOQWwrekplUDl3bGdyajJpMlF5TldyZm1vamJZ?=
 =?utf-8?B?OFBKNFlKdTh6SUF4SFJkRXJGNUhOUFAyN2NwUVlRV280dHBZYkZ2c1I3dnQ2?=
 =?utf-8?B?VUlZYjdwMDFycU13dFlDUmdRV201RFlTVWpGc0V6cHlOTTQyT2VqWTk1bU13?=
 =?utf-8?B?NWFyNllqRllmczRiQXhSb2pUR0NpeFBQUTYzd2pGeGNEZVQ1Tk53NGhtSXBZ?=
 =?utf-8?B?RjM4dHRWUHg5TUZ2REV2MmFKUDBVa2Jpb3FJL21oVHdJRFJJemxUNzIveW90?=
 =?utf-8?Q?7B1LNUyuVpdmyV65brXSO6P5Gnfe9h85kU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3477087-9e23-411c-5a7b-08d8bbc11f07
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 14:55:39.8733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K66UosJKbcLOA+xqSYD0rPod1Fww0GiXQ6tliHkAKjcmUUEMFF05pijEDz/nsKnzJnbPN1XlpNsUrxPa1gyKEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjAyMS0wMS0xOCB1bSA5OjUzIGEubS4gc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFt
IDE4LjAxLjIxIHVtIDE1OjM3IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IEFtIDIwMjEtMDEt
MTggdW0gMjo1MyBhLm0uIHNjaHJpZWIgQ2hyaXN0aWFuIEvDtm5pZzoKPj4+IEFtIDE1LjAxLjIx
IHVtIDE5OjI0IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+Pj4gUk9DbSB1c2VyIG1vZGUgZGVw
ZW5kcyBvbiB1c2VycHRyIHN1cHBvcnQuIFdpdGhvdXQgaXQsIEtGRCBpcwo+Pj4+IGJhc2ljYWxs
eQo+Pj4+IHVzZWxlc3MuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+PiAtLS0KPj4+PiDCoMKgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1ka2ZkL0tjb25maWcgfCAxICsKPj4+PiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL0tjb25maWcKPj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKPj4+
PiBpbmRleCBlOGZiMTBjNDFmMTYuLjI4MDBiMmJiMjUyMiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9LY29uZmlnCj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQvS2NvbmZpZwo+Pj4+IEBAIC04LDUgKzgsNiBAQCBjb25maWcgSFNBX0FNRAo+
Pj4+IMKgwqDCoMKgwqDCoCBkZXBlbmRzIG9uIERSTV9BTURHUFUgJiYgKFg4Nl82NCB8fCBBUk02
NCB8fCBQUEM2NCkKPj4+PiDCoMKgwqDCoMKgwqAgaW1wbHkgQU1EX0lPTU1VX1YyIGlmIFg4Nl82
NAo+Pj4+IMKgwqDCoMKgwqDCoCBzZWxlY3QgTU1VX05PVElGSUVSCj4+Pj4gK8KgwqDCoCBzZWxl
Y3QgRFJNX0FNREdQVV9VU0VSUFRSCj4+PiBJIHRoaW5rIHdlIHNob3VsZCByYXRoZXIgbWFrZSB0
aGF0IGEgZGVwZW5kcyBvbi4gT3RoZXJ3aXNlIHdlIHNlbGVjdCBhCj4+PiB2aXNpYmxlIGNvbmZp
ZyBvcHRpb24uCj4+IEkgd2FzIGNvbnNpZGVyaW5nIHRoYXQuIFRoZSBwcm9ibGVtIHdpdGggdGhh
dCBpcywgdGhhdCB0aGUgSFNBX0FNRAo+PiBvcHRpb24gd29uJ3QgZXZlbiBzaG93IHVwIGluIG1l
bnVjb25maWcgdW5sZXNzIERSTV9BTURHUFVfVVNFUlBUUiBpcwo+PiBzZWxlY3RlZC4gSSdkIHJh
dGhlciBhbHdheXMgc2hvdyB0aGUgSFNBX0FNRCBvcHRpb24gYW5kIHNlbGVjdCB3aGF0IGl0Cj4+
IG5lZWRzLgo+Pgo+PiBJcyB0aGVyZSBhIGdvb2QgcmVhc29uIHdoeSBBTURHUFVfVVNFUlBUUiBp
cyBhICJ2aXNpYmxlIiBjb25maWcgb3B0aW9uPwo+PiBXaGF0IHdvdWxkIGJlIGEgcmVhc29uIGZv
ciBhIHVzZXIgdG8gZGVsaWJlcmF0ZWx5IGRpc2FibGUgdGhpcz8KPgo+IFRoZSBwcm9ibGVtIGlz
IHRoZSBNTVUgbm90aWZpZXIgZGVwZW5kZW5jeSwgbm90IGV2ZXJ5Ym9keSB3YW50cyBpdHMuCgpX
ZWxsLCBLRkQgYWxyZWFkeSBzZWxlY3RzIE1NVV9OT1RJRklFUi4gU28gc2VsZWN0aW5nIERSTV9B
TURHUFVfVVNFUlBUUgp3b24ndCBkbyBhbnkgbW9yZSBoYXJtLgoKUmVnYXJkcywKwqAgRmVsaXgK
Cgo+Cj4gSSdtIGp1c3Qgbm90IHN1cmUgaWYgaXQncyBsZWdhbCB0byBmb3JjZWZ1bGx5IHNlbGVj
dCBhIHZpc2libGUgY29uZmlnCj4gb3B0aW9uLiBFLmcuIHdoYXQgaGFwcGVucyBpZiBhbiB1c2Vy
IHVuc2VsZWN0cyBEUk1fQU1ER1BVX1VTRVJQVFIKPiBhZnRlciBpdCB3YXMgc2VsZWN0ZWQgaGVy
ZT8KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+Cj4+IFJlZ2FyZHMsCj4+IMKgwqAgRmVs
aXgKPj4KPj4KPj4+IENocmlzdGlhbi4KPj4+Cj4+Pj4gwqDCoMKgwqDCoMKgIGhlbHAKPj4+PiDC
oMKgwqDCoMKgwqDCoMKgIEVuYWJsZSB0aGlzIGlmIHlvdSB3YW50IHRvIHVzZSBIU0EgZmVhdHVy
ZXMgb24gQU1EIEdQVQo+Pj4+IGRldmljZXMuCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
