Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3060AC433E6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 13:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBD720767
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 13:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MPpFJjeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBD720767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BA96E0AC;
	Tue,  1 Sep 2020 13:26:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A896E0AC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2020 13:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz6LBe+9uio7RaprODDGkQtUccB5/4N/8VH7f3p+1MUQu2J/mY62bNxG9jc4a1LgQNSJiU5UTWVGgq/KgYEHarPScmN2gBzoWr/8scThrEdQCdeNm/OhZAvcS/UeHmV4NpITlUSqc2UkqajnOZHjGNJvA5sYulqDEqQ0j32mk5SIOGAVYT1I9Re7DGN82u27CGL0ORe5/BXqGv8imMMB6XHCBIlLvTU3/PMRXxciQGriGkx2OfCe50ceedRslVvG7WSH/3YpGXzGxGar5qaIsXdQZG8NtKd+FkOTawcNCd7gvMYWviC9BjkApmkzBI4nkarz7D2YGosC6ZCUzAh46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pAqZjIaYc5nNx6KVX8Q/u9gEKa13iRD7Zodb+Ny+hQ=;
 b=gcbEeX+fEpt7k86h3gzFWJ41Y7kayAOSIDO6Mx/jNyzHezRrytdHdqAUYaPhe7FgKRt9yogJRO8LCKyfyC74zWLPYIMkQikvtq8VY4E+vrZrRAwzwqWhYKnGMffcNw9Brfr6mxBl6vCXrGifrL0/Vburha9jlcEd2I86Qz8xhPW+fMdCxBhC7CAPd4V++mbTsvFWMToR6rG7kgkSuxFx75qqgJsdC4qdvZ9nJavB8LmCaoogeQJxf49Xz/O8zclJIDoY2UGCd1bB9aUbw+YioNPdPuEpvk4FyWU9V88tyAwcB1rrdagYjDc8lN09xfFkHziTQIhDshRNzmz5o6GgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pAqZjIaYc5nNx6KVX8Q/u9gEKa13iRD7Zodb+Ny+hQ=;
 b=MPpFJjeWfhNnjQaAs7q/8y1/1nXCEweng0ny1Vsc2dKjqXcsT/DPCcYplJwD+x1WNPdh3xpXkiIFWNRQNG5EFtOxWI4mpNk/dUZVsXUNDsJcnU0vwGgAAzyjTgkxvQri6p+DxN99LpiwrPq37cB/7ajmFwN/3oEksMs7bsjDtBk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 13:26:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::d548:1236:cb4f:1be9%7]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 13:26:06 +0000
Subject: Re: [PATCH] drm/kfd: fix a system crash issue during GPU recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, christian.koenig@amd.com
References: <20200901013619.14836-1-Dennis.Li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <44930860-7c61-c984-9c32-90a2cc0a3732@amd.com>
Date: Tue, 1 Sep 2020 09:26:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200901013619.14836-1-Dennis.Li@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34)
 To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 YT1PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 13:26:05 +0000
X-Originating-IP: [142.116.113.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a429e598-80cf-4a64-a36f-08d84e7a94a6
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430452F277BF7F44148D3C9922E0@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfwmbUA7kCpc1ouwQCZjaVkZTdlW5YxitGIXdKvG01bxDA8coB8ZpMba1BwNSjf9QDGjSfxqU10RWbUehLUMAp6iaDF5Efl+zsYycIbTA0SOE15QBW2qru0A0Xfxe8CCOxuGl0kfLtCRtg/aurluxD229zIS4AxZFQEJjI047p/4p4hxmbdJsiCGkNstRZ2QtU5P1IC2xboIq5VilYDd1MDJY3StRf+bgsSuw8axEXTtsWF9avQ7U7Zay9kx/Dr0P4LXm4Jk9F9wgQQwZCqfwaeoWCW34XeFeNqVog33C4db94ux0GkzfmBbz2D+CjtQ2Ai8GRpSHbV9uG9FJIp08tSqbAOjDKrDfywW8GvM84omSglBpt7SqhrWpZNukzJ0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(26005)(83380400001)(66556008)(52116002)(5660300002)(8936002)(16576012)(36756003)(2906002)(31696002)(478600001)(2616005)(31686004)(66476007)(66946007)(6486002)(86362001)(186003)(316002)(44832011)(8676002)(956004)(6636002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KJeRo+ZYBq8PK8M2NxmBDi3iWBb1SVnG5/ev9lNbRJTvuyiBqtESGbYUdVK57tgusquE1Cm0V3ZgzwUWgu50kb2hUYFw2KWeK3VHF6XlNX3kq7A4ULOPAMtNCNjMnQG1L0wBhktdjPFLHVyxZlt81/AzpVEs+pC29Kg/RRwnBQzb/6h9hm4xCyiNfOL2vforBR16t7yfLo6gA0Dp2FG1oY1UUFzaxZCgeRtoxxVSGAZKBC1WPh1HGbyQqKss/9Z9tOo3rnfbCj+fF9uz2DgfDLw99UcG7jugU7Ohm2zkjmZf82PUbXfUFHCHWe3dxBeLOkhsxfI5MAMe1q7EV0xCZG+Bby5e6tYMxVv0XSz0U8MwkCh2gtjI2bWeeeIoc7NG+6HCy9kZLidAzDpPeDpt/+PkqwwMG2aIm8xug2F8VUujTv3k+kPp+5VH5LKFtoD9b4gpiFDgzhYmWE7mD2sBy1rXP0o/5/WmsxBNuM3aRbuoT/uI8zJ9lGh92Lz3tgLf+/jBOKLYt2zWLK1c9RInIkj+s88j5Os3p7B4YP4hzUh1iKGG9GAPoiKZeIZVB43OC0EWASkb2AmBRYHStKnFbzvbgLU6K/S7wxWX+DioUkpv8haqLaambS93wFxQEbc78RvAY7PV7EKSXKOXy5/MOQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a429e598-80cf-4a64-a36f-08d84e7a94a6
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 13:26:06.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56w43+BG1UhfqnmFLGHwU9e6d9hMAWpSgEiLYCnF85JJJVphtLSzxJmJbk0E+nM8d5iUxZCcNQST9M7p3H9b5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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

SSdtIG5vdCBzdXJlIGhvdyB0aGUgYnVnIHlvdSdyZSBmaXhpbmcgaXMgY2F1c2VkLCBidXQgeW91
ciBmaXggaXMKY2xlYXJseSBpbiB0aGUgd3JvbmcgcGxhY2UuCgpBIHF1ZXVlIGJlaW5nIGRpc2Fi
bGVkIGlzIG5vdCB0aGUgc2FtZSB0aGluZyBhcyBhIHF1ZXVlIGJlaW5nIGRlc3Ryb3llZC4KUXVl
dWVzIGNhbiBiZSBkaXNhYmxlZCBmb3IgbGVnaXRpbWF0ZSByZWFzb25zLCBidXQgdGhleSBzdGls
bCBzaG91bGQKZXhpc3QgYW5kIGJlIGluIHRoZSBxcGQtPnF1ZXVlc19saXN0LgoKSWYgYSBkZXN0
cm95ZWQgcXVldWUgaXMgbGVmdCBvbiB0aGUgcXBkLT5xdWV1ZXNfbGlzdCwgdGhhdCB3b3VsZCBi
ZSBhCnByb2JsZW0uIENhbiB5b3UgcG9pbnQgb3V0IHdoZXJlIHN1Y2ggYSB0aGluZyBpcyBoYXBw
ZW5pbmc/CgpUaGFua3MsCsKgIEZlbGl4CgoKQW0gMjAyMC0wOC0zMSB1bSA5OjM2IHAubS4gc2No
cmllYiBEZW5uaXMgTGk6Cj4gVGhlIGNyYXNoIGxvZyBhcyB0aGUgYmVsb3c6Cj4KPiBbVGh1IEF1
ZyAyMCAyMzoxODoxNCAyMDIwXSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQ6IDAwMDAgWyMxXSBT
TVAgTk9QVEkKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBDUFU6IDE1MiBQSUQ6IDE4Mzcg
Q29tbToga3dvcmtlci8xNTI6MSBUYWludGVkOiBHICAgICAgICAgICBPRSAgICAgNS40LjAtNDIt
Z2VuZXJpYyAjNDZ+MTguMDQuMS1VYnVudHUKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBI
YXJkd2FyZSBuYW1lOiBHSUdBQllURSBHNDgyLVo1My1ZRi9NWjUyLUc0MC0wMCwgQklPUyBSMTIg
MDUvMTMvMjAyMAo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIFdvcmtxdWV1ZTogZXZlbnRz
IGFtZGdwdV9yYXNfZG9fcmVjb3ZlcnkgW2FtZGdwdV0KPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAy
MDIwXSBSSVA6IDAwMTA6ZXZpY3RfcHJvY2Vzc19xdWV1ZXNfY3BzY2grMHhjOS8weDEzMCBbYW1k
Z3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdIENvZGU6IDQ5IDhkIDRkIDEwIDQ4IDM5
IGM4IDc1IDIxIGViIDQ0IDgzIGZhIDAzIDc0IDM2IDgwIDc4IDcyIDAwIDc0IDBjIDgzIGFiIDY4
IDAxIDAwIDAwIDAxIDQxIGM2IDQ1IDQxIDAwIDQ4IDhiIDAwIDQ4IDM5IGM4IDc0IDI1IDw4MD4g
NzggNzAgMDAgYzYgNDAgNmQgMDEgNzQgZWUgOGIgNTAgMjggYzYgNDAgNzAgMDAgODMgYWIgNjAg
MDEgMDAKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBSU1A6IDAwMTg6ZmZmZmIyOWI1MmY2
ZmM5MCBFRkxBR1M6IDAwMDEwMjEzCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gUkFYOiAx
Yzg4NGVkYjBhMTE4OTE0IFJCWDogZmZmZjhhMGQ0NWZmM2MwMCBSQ1g6IGZmZmY4YTJkODNlNDEw
MzgKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJ
OiAwMDAwMDAwMDAwMDAwMDgyIFJESTogZmZmZjhhMGUyZTQxNzhjMAo+IFtUaHUgQXVnIDIwIDIz
OjE4OjE0IDIwMjBdIFJCUDogZmZmZmIyOWI1MmY2ZmNiMCBSMDg6IDAwMDAwMDAwMDAwMDFiNjQg
UjA5OiAwMDAwMDAwMDAwMDAwMDA0Cj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gUjEwOiBm
ZmZmYjI5YjUyZjZmYjc4IFIxMTogMDAwMDAwMDAwMDAwMDAwMSBSMTI6IGZmZmY4YTBkNDVmZjNk
MjgKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSBSMTM6IGZmZmY4YTJkODNlNDEwMjggUjE0
OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMAo+IFtUaHUgQXVnIDIwIDIz
OjE4OjE0IDIwMjBdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmOGEwZTJlNDAw
MDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAy
MDIwXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCj4g
W1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gQ1IyOiAwMDAwNTVjNzgzYzBlNmE4IENSMzogMDAw
MDAwMzRhMTI4NDAwMCBDUjQ6IDAwMDAwMDAwMDAzNDBlZTAKPiBbVGh1IEF1ZyAyMCAyMzoxODox
NCAyMDIwXSBDYWxsIFRyYWNlOgo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICBrZmRfcHJv
Y2Vzc19ldmljdF9xdWV1ZXMrMHg0My8weGQwIFthbWRncHVdCj4gW1RodSBBdWcgMjAgMjM6MTg6
MTQgMjAyMF0gIGtmZF9zdXNwZW5kX2FsbF9wcm9jZXNzZXMrMHg2MC8weGYwIFthbWRncHVdCj4g
W1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gIGtnZDJrZmRfc3VzcGVuZC5wYXJ0LjcrMHg0My8w
eDUwIFthbWRncHVdCj4gW1RodSBBdWcgMjAgMjM6MTg6MTQgMjAyMF0gIGtnZDJrZmRfcHJlX3Jl
c2V0KzB4NDYvMHg2MCBbYW1kZ3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICBhbWRn
cHVfYW1ka2ZkX3ByZV9yZXNldCsweDFhLzB4MjAgW2FtZGdwdV0KPiBbVGh1IEF1ZyAyMCAyMzox
ODoxNCAyMDIwXSAgYW1kZ3B1X2RldmljZV9ncHVfcmVjb3ZlcisweDM3Ny8weGY5MCBbYW1kZ3B1
XQo+IFtUaHUgQXVnIDIwIDIzOjE4OjE0IDIwMjBdICA/IGFtZGdwdV9yYXNfZXJyb3JfcXVlcnkr
MHgxYjgvMHgyYTAgW2FtZGdwdV0KPiBbVGh1IEF1ZyAyMCAyMzoxODoxNCAyMDIwXSAgYW1kZ3B1
X3Jhc19kb19yZWNvdmVyeSsweDE1OS8weDE5MCBbYW1kZ3B1XQo+IFtUaHUgQXVnIDIwIDIzOjE4
OjE0IDIwMjBdICBwcm9jZXNzX29uZV93b3JrKzB4MjBmLzB4NDAwCj4gW1RodSBBdWcgMjAgMjM6
MTg6MTQgMjAyMF0gIHdvcmtlcl90aHJlYWQrMHgzNC8weDQxMAo+Cj4gV2hlbiBHUFUgaGFuZywg
dXNlciBwcm9jZXNzIHdpbGwgZmFpbCB0byBjcmVhdGUgYSBjb21wdXRlIHF1ZXVlIHdob3NlCj4g
c3RydWN0IG9iamVjdCB3aWxsIGJlIGZyZWVkIGxhdGVyLCBidXQgZHJpdmVyIHdyb25nbHkgYWRk
IHRoaXMgcXVldWUgdG8KPiBxdWV1ZSBsaXN0IG9mIHRoZSBwcm9jY2Vzcy4gQW5kIHRoZW4ga2Zk
X3Byb2Nlc3NfZXZpY3RfcXVldWVzIHdpbGwKPiBhY2Nlc3MgYSBmcmVlZCBtZW1vcnksIHdoaWNo
IGNhdXNlIGEgc3lzdGVtIGNyYXNoLgo+Cj4gU2lnbmVkLW9mZi1ieTogRGVubmlzIExpIDxEZW5u
aXMuTGlAYW1kLmNvbT4KPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jCj4gaW5kZXggNTYwYWRjNTdhMDUwLi5kNWU2YjA3
ZmZiMjcgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rldmlj
ZV9xdWV1ZV9tYW5hZ2VyLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
ZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+IEBAIC0xMjk2LDE2ICsxMjk2LDE4IEBAIHN0YXRpYyBp
bnQgY3JlYXRlX3F1ZXVlX2Nwc2NoKHN0cnVjdCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBz
dHJ1Y3QgcXVldWUgKnEsCj4gIAltcWRfbWdyLT5pbml0X21xZChtcWRfbWdyLCAmcS0+bXFkLCBx
LT5tcWRfbWVtX29iaiwKPiAgCQkJCSZxLT5nYXJ0X21xZF9hZGRyLCAmcS0+cHJvcGVydGllcyk7
Cj4gIAo+IC0JbGlzdF9hZGQoJnEtPmxpc3QsICZxcGQtPnF1ZXVlc19saXN0KTsKPiAtCXFwZC0+
cXVldWVfY291bnQrKzsKPiAtCj4gIAlpZiAocS0+cHJvcGVydGllcy5pc19hY3RpdmUpIHsKPiAg
CQlpbmNyZW1lbnRfcXVldWVfY291bnQoZHFtLCBxLT5wcm9wZXJ0aWVzLnR5cGUpOwo+ICAKPiAg
CQlyZXR2YWwgPSBleGVjdXRlX3F1ZXVlc19jcHNjaChkcW0sCj4gIAkJCQlLRkRfVU5NQVBfUVVF
VUVTX0ZJTFRFUl9EWU5BTUlDX1FVRVVFUywgMCk7Cj4gKwkJaWYgKHJldHZhbCkKPiArCQkJZ290
byBvdXRfZXhlY3V0ZV9jcHNjaDsKPiAgCX0KPiAgCj4gKwlsaXN0X2FkZCgmcS0+bGlzdCwgJnFw
ZC0+cXVldWVzX2xpc3QpOwo+ICsJcXBkLT5xdWV1ZV9jb3VudCsrOwo+ICsKPiAgCS8qCj4gIAkg
KiBVbmNvbmRpdGlvbmFsbHkgaW5jcmVtZW50IHRoaXMgY291bnRlciwgcmVnYXJkbGVzcyBvZiB0
aGUgcXVldWUncwo+ICAJICogdHlwZSBvciB3aGV0aGVyIHRoZSBxdWV1ZSBpcyBhY3RpdmUuCj4g
QEAgLTEzMTgsNiArMTMyMCw5IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3F1ZXVlX2Nwc2NoKHN0cnVj
dCBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFtLCBzdHJ1Y3QgcXVldWUgKnEsCj4gIAlkcW1fdW5s
b2NrKGRxbSk7Cj4gIAlyZXR1cm4gcmV0dmFsOwo+ICAKPiArb3V0X2V4ZWN1dGVfY3BzY2g6Cj4g
KwlkZWNyZW1lbnRfcXVldWVfY291bnQoZHFtLCBxLT5wcm9wZXJ0aWVzLnR5cGUpOwo+ICsJZHFt
X3VubG9jayhkcW0pOwo+ICBvdXRfZGVhbGxvY2F0ZV9kb29yYmVsbDoKPiAgCWRlYWxsb2NhdGVf
ZG9vcmJlbGwocXBkLCBxKTsKPiAgb3V0X2RlYWxsb2NhdGVfc2RtYV9xdWV1ZToKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
