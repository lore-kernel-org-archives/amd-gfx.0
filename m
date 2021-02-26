Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF504C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7122D64ED5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 16:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7122D64ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053D26E3DA;
	Fri, 26 Feb 2021 16:24:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7232E6E3DA
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 16:24:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVSe+kbhPDxAIM+YT54JAFCiaIMfTc/Z9HfSRG11dcbsttBubfgp6VbmmbNFkmXSpS/fF/BJVZctg7GvjRgeDhLRRvJ1cEpyNXNban4WNqlQ9KdwYesE/1b8CZVFk2hfAWAfO1D5Gq0ND4QhgyYXVweJ1iidGPWn6iqX4+aklcxV3mVNKPalKj5NlP2w8VfrUHsFZrdpBvExPa0JSTls6orotP36ZuLS10IldyZKhiEmvPtzun9+hFAUrJ7Xl+IZvhVX3xb03xErnjQ5Klk6Z0PogWxgp/LiMdVWjSzR4SrH7IdidX0gL99HA09EavWI+WeCD5TWzGc0s3ALgMhfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42lj38n+QZNX1ysuvLdw2iARKErKPGi1SHbNmiTQtgk=;
 b=XwZYbuBg7iEXLbGR0O83kUvtfMNEOZDJCYdHAhnUWbvmCRDMluznYITW/r+GDeooUkGhnue/uJN+luM35zMCdT1UWCD04SYvU7u5jVxuL9WNQ8RWUJA40jrfnnM8Ocsh8E8E9cwXfreQQAV4dkEnbyGW+zZvqvXMrVYAno2kEQ6O+oRaThkIntfN4HIpjW9NVUs8r6Lai34me/Y0vR7wDH32RpDrYKV1w6X8aWtK74xgdO9ZicuFw499Zrevqzb5NXhyGloreSPI2Z1NdXuEyimriXk+tahVNnf94BSEuBD2AgRDh/cObFMpuYPgrI8xY2tt/cSAeerOHTgZ3DHLEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42lj38n+QZNX1ysuvLdw2iARKErKPGi1SHbNmiTQtgk=;
 b=DzMRWe4yRNEuPvXjNAHBYobVvNDWCftRk+zWanA/QT5MvGcIP1YdYhxBXimUStFUqqCP7JU+YLjXXMoGYxtmbzdqZrcMeWXGo1tH45fWyWl2QPAmh5E5NgZ9MLGQaCI4cVBPmJ1JAtsiSkZZFuUgXCoRQ6FNZV/fF1Fmt6367eY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 16:24:12 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%8]) with mapi id 15.20.3784.030; Fri, 26 Feb 2021
 16:24:12 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: Make noretry the default on Aldebaran
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225185602.661486-1-alexander.deucher@amd.com>
 <20210225185602.661486-2-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <c314c5ab-7e29-0c42-ebcb-ac32e6cf41b7@amd.com>
Date: Fri, 26 Feb 2021 11:24:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210225185602.661486-2-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [142.117.121.176]
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.117.121.176) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.31 via Frontend Transport; Fri, 26 Feb 2021 16:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e903fc4-85b7-493e-0394-08d8da72f360
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696055EEB1D3BC2953BC8F3929D9@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ooydwOTBWnw8HHgCDU425MNfoY/HvBsWeiuz9m9+2rrk6oJCkulUFye6zWcz6x3u3jL0BxH6kMilD/2v6cxi54A330n41jv/+vBiFqq7p3mI9ls+Hm3lgeVuBahEFNRYvJs/rhPegYvdXYeEL9t8I2R0zUtpISOOxUHhbnnY0ZJo5LBy2X1dYtGccPhYuK7/ddyr4AtZX9mtbBeFJGY/nCDv3HpdDUTpN+bHj2RoVq+fNJ18WWU0ggCCldWUNH6+zkUdDKcqOTvdzT6vx3Y8mrQJb0M1EX9RzEp9H8YcxKflR0rnF+1EhVcVGRg74+/M74FnozOx7tVtsyFbl1pYq/+oensIwjYX3XP4nOA0YVxsKjr3XxgrXxKyiarrU5UFoudGxaRyiNRxfaw+78U/2WshiCuwwHBuF2K5O+Pw//qz+YYrgkNDe4FX7fEhWliKCMiTeH22sW/Pl3Gr1WSoluMkhdDx1wKPPvp8ryvlfz6FVHZzUAAFDJsRl7T55vrc32BRTO+pTbnWMR5FPYPNJGAemJm6rmcQ0qziLgK+sw7LaRjK494sDsOIndtFhpPWZSPfQHmJASlvV5CwYovnIRxDV6XDRIvsHSFJD2jIqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(44832011)(6486002)(66556008)(8936002)(31696002)(8676002)(956004)(36756003)(66946007)(5660300002)(2616005)(86362001)(2906002)(52116002)(478600001)(66476007)(16526019)(31686004)(54906003)(4326008)(316002)(26005)(186003)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWIzdzF2OEZ3V3hhRTFxSm41NWN0bUtMZXFCUXRBYXp0cjBtMjlJS1FZZHF1?=
 =?utf-8?B?SURaU21HbzdoVS9kRzF6Y1lGQmw3NW03em5aUURQcXNOcDZEbGp0ZEJBMndT?=
 =?utf-8?B?eVZ2eW9yWmpwUEVpcW9RUDJST3hIakIyWnMxZ3BTY3NoOUZiMHNlcml0SWRY?=
 =?utf-8?B?TzQrU3NRY2NFZVVRNEF5TUV6YVdyNGF4bXpYL3RlMTFSVlRScm1ZRXA1WjlN?=
 =?utf-8?B?Ukdmd1JJVXdnTFc2Q1dxZjBNSDdyNS92YnhxMG5uZEdURGVhcFJZVDZKQWJz?=
 =?utf-8?B?c3N0Sm50UEVBUGovSHhhV29LL2Q2cmh1QzRxZStxUzNCTGRZY3hFZEdDcnht?=
 =?utf-8?B?emF2MzkwVElzaWwrL0M0dVcybTFLdFBvMkNDQUVIL0ZKQ2pJNFI5ZkROOW1O?=
 =?utf-8?B?ay9RTU9ReVNzaFJaM0YyU05kSk1RS2YweGEvTHV6V0NDcm5idlY0azJFN2Z1?=
 =?utf-8?B?SkN0UmEvYVhuOHBRMW1Ib3Z3Mi85d09SY1ZRNy9FSVFRejRxVWJ5VzJYUUJK?=
 =?utf-8?B?UktFc2JoQ0c2Uk1mQ05lazVJTEl0T1c4bVkvdHpEYmVRNktnT1h4U2U4VlJp?=
 =?utf-8?B?RVNTRmlTVXZFanlnWSt4RUJUMURiTVM2YmRVYjVMSVNYMDBvcW1hRUxhOVlk?=
 =?utf-8?B?THF5OVB5dVdGbkM0cEEraTN6a1c5c25CNEJyZjFCd0xyVWh0Y1QxcXdKd2Zt?=
 =?utf-8?B?eG9zMlpZVDZIKzF6Rm13d3pwYlJvVzh4K3lvejgrRUtXbWxta2V5OGxRY29F?=
 =?utf-8?B?eWdZM2tYRGVyOFFlTXpBUTZhcVAzY3U5cWw3ZWE2QnAwdzFLcUw5VFZLalkv?=
 =?utf-8?B?SFJieXpmUWVYeE9weE1GRWJ2WkpyaFBPaHRSZGxraDlzZEptZWx4VVRyT3Fm?=
 =?utf-8?B?dXVQTDFITDJXckE0azhzRTFoanN1RWhDRGRIUEl1UHlGYkRDWDVEQm1qbWFj?=
 =?utf-8?B?MVNJYmZDcStFTUJhcGZTYnBMcDljaTZjaUN1TUZMeVRhOTl4U1ozdHpnRnNz?=
 =?utf-8?B?RkJPelQxampMb1pLWEpyMzMxS0EyamJkemlrY05mdUMvWnpNcExUMWtFSW5D?=
 =?utf-8?B?Z2NoTWJpcTduQ01YZzJVa1IrSnMzNVk2dEtMNUU1MEp2T3pCd2VVdGxrTjE1?=
 =?utf-8?B?TURQZ3R0WS9yTGdmRlUvelBXN1hBRDVtallvaDA0RXRxUjJhUmM4NHJTVmFq?=
 =?utf-8?B?KzVSTitDcjlBUXFlUm9FNlB6Tklqam5CMTlTTk12QmQ5dHNuUm0ySEpqM29r?=
 =?utf-8?B?bzFOYmg2NlBrRnkvSXpGdEoxVzM4NUcvRkdob09XdmYxaGJXVVZ0WGZLRE50?=
 =?utf-8?B?SEdWdmdsalFObCsyNEpveHhVRFJyMDBEYjc3c3hFd3N1a1QxUU81K3Qwc0Zh?=
 =?utf-8?B?WWZ0Sno5UVA1dDBPTnhqb1J5V2NMYzVuemxxVWdTWG5taDJsRHZLdXQvWG96?=
 =?utf-8?B?clUreUx3T2RrUE52aUJpNXJtWm5XczlIT1AwaGxaNVVjWHlPQXV4WG5wbDBh?=
 =?utf-8?B?Z3Zxd25tMUlTYWZGa0xXa2F3TTFxenhWVTRobDVYRmJGVXVvQnQ2U2NGVzgx?=
 =?utf-8?B?SHVpamVLRWVZQithZlJiZi9GLzNFVk52Wmx4dVk4UEZSS0lxVlBhZkc1Q0JE?=
 =?utf-8?B?Yyt1ZEh6ajJ5amhTaERXOGs4dFV3aXBzREsxS2FubmRLeWk4cmd1T1k5WUth?=
 =?utf-8?B?MDRhUnFiUC9IeFUxNkF6NU91ZjE4NGNoVzU3bjBhVVBqVEJlend4cnRieDE1?=
 =?utf-8?B?L1FNTVppR0pOSjJWVU1SVjM3QjlKWlF0NEdodjhIWVVzWVNmVzB5UVJLVE01?=
 =?utf-8?B?U2dvZ29xTWlkbVZhOW5FZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e903fc4-85b7-493e-0394-08d8da72f360
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:24:12.0533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2wynu13tENZmajCNQHabJs/GFvU+wpsrFCKl1Ys7TFKCxdBkpceqKpx7qZ+nfTrxQM4rVhjz5b48MyqenoM/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBkZXBlbmRzIG9uIHR3byBwcmV2aW91cyBwYXRjaGVzOgoKMmU0NjRhN2ZiODgzIGRybS9h
bWRncHU6IEVuYWJsZSByZXRyeSBmYXVsdHMgdW5jb25kaXRpb25hbGx5IG9uIEFsZGViYXJhbgo2
MjhjOGQzYTE2MDIgZHJtL2FtZGdwdTogUmV0cnkgZmF1bHQgaGFuZGxpbmcgYmFzZWQgb24gcGVy
LXByb2Nlc3MgWE5BQ0sKbW9kZQoKUmVnYXJkcywKwqAgRmVsaXgKCkFtIDIwMjEtMDItMjUgdW0g
MTo1NiBwLm0uIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+IEZyb206IEZlbGl4IEt1ZWhsaW5nIDxG
ZWxpeC5LdWVobGluZ0BhbWQuY29tPgo+Cj4gVGhpcyBpcyBuZWVkZWQgZm9yIGJlc3QgbWFjaGlu
ZSBsZWFybmluZyBwZXJmb3JtYW5jZS4gWE5BQ0sgY2FuIHN0aWxsCj4gYmUgZW5hYmxlZCBwZXIt
cHJvY2VzcyBpZiBuZWVkZWQuCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVs
aXguS3VlaGxpbmdAYW1kLmNvbT4KPiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+IFJldmlld2VkLWJ5OiBQaGlsaXAgWWFuZyA8UGhpbGlwLllh
bmdAYW1kLmNvbT4KPiBUZXN0ZWQtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMSAr
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuYwo+IGluZGV4IDZkOWM2NjBkYTI3YS4uOGE2NGY1ZTQ5Y2IyIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IEBAIC01MDgsNiAr
NTA4LDcgQEAgdm9pZCBhbWRncHVfZ21jX25vcmV0cnlfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+ICAJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiAgCWNhc2UgQ0hJUF9WRUdB
MTA6Cj4gIAljYXNlIENISVBfVkVHQTIwOgo+ICsJY2FzZSBDSElQX0FMREVCQVJBTjoKPiAgCQkv
Kgo+ICAJCSAqIG5vcmV0cnkgPSAwIHdpbGwgY2F1c2Uga2ZkIHBhZ2UgZmF1bHQgdGVzdHMgZmFp
bAo+ICAJCSAqIGZvciBzb21lIEFTSUNzLCBzbyBzZXQgZGVmYXVsdCB0byAxIGZvciB0aGVzZSBB
U0lDcy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
