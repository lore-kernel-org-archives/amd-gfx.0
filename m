Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A2C4741F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D83A321734
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 14:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nVhaVWjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83A321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 286816E091;
	Wed,  4 Nov 2020 14:09:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4276E091
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 14:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ko5mCv0o77xKYXjI9WpypmT3+XzO3iqc+sq8B5tSTUCkO0ebNm++rL7Q+BHAW/NVdthmTPBB7E1TL2QeKFgdRFtHfS3Ig/dmUM8bAY00cs+KhRuRUGk/qtsAsLZCSrOvDVJYbqtXQeGH1vjFnsLUZdDxa6L2NckG/u4i4ybYked6U1sh9poXFXfSiXKaGW3Gx+eoV1T0BNG9roW4IhkbNzlSqZGPgMr6BjLjQ6pBoxog9WLKMdB9W90bWLejUrIFIuNSOnanPkdPdQUplFvLzwjkhscPfhsRKscYBMEUtvxleIZ+cTCtJHY51w6GcPpnUlrwho9YBTMQ6UhzETR03g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IzDtelquObsu46UOkbvmdV7KUIY8yj/092pCGkPnhU=;
 b=kB8wbO0GcjBtYcJXcqnt559DM158m/ssBT//DoMb/wy0wLru25scB3fsuGnACEMAhawy9RKv4+uetXxGAkvjYMETQ2rYdH5wevsM6Q2LqiF0YXX8uBRUQgYCNKueGw3NIE6hC9NbEmQ+SOdr2QVBeCvrhRbcfSXmRNA2vkk3fP5IvzZFPX8bWxyA06UrDN0K9g6J0umjH8qwjOM/QBSimnKighcS/g74NN+9wx2mdegkCNwg3ejeSwj4zEfe+//9b2ralV976kbHv9ZATC5NbUDeN0tJCZ4/g00guPtNngFvtWgl3W+X66w6tDMVJwTdFuSPy+7YHCyJJ8zAJ7XdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IzDtelquObsu46UOkbvmdV7KUIY8yj/092pCGkPnhU=;
 b=nVhaVWjyxoRk+MyL7QISte9c9eaEZYl8SV3LXiCn3exauzhFR+sw5A32EpVlGIl47tIifEezrIvzkSkAxD/1F7UwPrXxfbSKlDVnO0CVwSfo8ReJfzaRLxIuA0bNe2LpW/auAN/xxqDbxa7aFnPbcq4UW9nHLZ0zfJSDGHPHk2w=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3126.namprd12.prod.outlook.com (2603:10b6:a03:df::28)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 14:09:41 +0000
Received: from BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c]) by BYAPR12MB3126.namprd12.prod.outlook.com
 ([fe80::e89a:3b9a:e967:3a0c%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 14:09:41 +0000
Subject: Re: [PATCH] drm/amdgpu: clip the ref divider max value at 100
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201103171340.2978395-1-shashank.sharma@amd.com>
 <7f9cc1a0-ad6b-ee9b-ac7b-4a49d08de1f9@amd.com>
 <MN2PR12MB3133BFD54B552B19A512B27CF2EF0@MN2PR12MB3133.namprd12.prod.outlook.com>
 <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
Message-ID: <704ebf80-a823-59e5-f01b-611c0bc2602f@amd.com>
Date: Wed, 4 Nov 2020 19:38:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <211bb89a-4433-3fb8-7849-6323cafe20fb@amd.com>
Content-Language: en-US
X-Originating-IP: [106.51.107.229]
X-ClientProxiedBy: MA1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::13) To BYAPR12MB3126.namprd12.prod.outlook.com
 (2603:10b6:a03:df::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.113] (106.51.107.229) by
 MA1PR01CA0119.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 14:09:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfa49aad-0809-403f-678e-08d880cb45e1
X-MS-TrafficTypeDiagnostic: BY5PR12MB4888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB48885A644C954208BF6ACF2CF2EF0@BY5PR12MB4888.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1NnHWc6/zrxFRA0KZ7gp2kv0ajyChvNlg15WScBwl/CyDyEF1ar+RC2sDASbtshU7jEuz7IZgyOLr5TBBFzbweo7HWxElY59vqv8AOFGFXLI3ROa9FRiTvaLqHudz7ezIxPR8TXK2g53xQwcSVabPdlU396D8sS7yY5JR9oZAWbxt26g2UJH5u+ZXq+Ch+Wnnnp+2Xy77H74BQDIA07wMOXk2BoUCc4wWIb8Husqq+vDS5nIlbf+jIiOk46uBDJwcSvyyUP2SBlraCDAvaEmg7v+1knonpRAygqftIHQDiK4UBCkQe8yV9/29zq6reQWv/CTKUJO57PetDhtDC3zYUlSdsTHpm+E4oZbHyCM88jDJGNIGEaQruCMK8asgFyTtvd6l+FRb6QitUqCdn+0k7s61JnnVJyvUrzjy/gy4yaVv7dTwAz77N9YBmrj6TD86hRYTYyHbYNyhE9xJ1GoTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(2616005)(66946007)(2906002)(66556008)(66476007)(956004)(86362001)(52116002)(1006002)(31686004)(6666004)(16526019)(26005)(54906003)(8676002)(8936002)(66574015)(5660300002)(55236004)(53546011)(31696002)(36756003)(966005)(16576012)(110136005)(4326008)(83380400001)(6486002)(186003)(478600001)(44832011)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4XnILgfE4PO1FSQWNDj/9LIzVr64GQY+0ANbte+hlB4GCnawPFPD/lsR5V/9FJ8H+ZI8MuKAUN1vLrvHi3YTwmWSlvSfQ2O6tDPqWPY41F0rn6MSqbQOWzRj1lDoLbh8F5yDhm8stFEkT2Tq83QPVVgMJ0/uYLHtk2jDA+EIKVkzwb0mUg4/RoD4ncUvX3W1j5VlIV2STo0IOnPbZuvXgRXVPe7pdjCfpixdeFoLeNl3YhwZLqA7SY+oaN+ECUqSPqzelQauo39/5XadLnUB3O6eW4Wu43JjO3cy7gWbDpIweUAsGu//0mR8IVhK//Fidtl5OZb1y8pHpOL42mfHB2Pdva/hpcgGwioLrBNLR0tdZ9pLYAdg85W8Rv6HU+JZOaYtrbsKvo0QjGRVuVJE0nUOGjc4bRPUDzvlIeTGvNX1QKanvt4tVCSfluyEsmr73rbcqrtLWaJwmwp+hVwz7uyYW8h3bkZ0PGmCOail35lgB9JsgP5tDvnn31woLu+5BgZDPMl6Wordlp6Zz3zM+nRp5CLgJTXVgiRRKWBrwq9QCBGhteV/9fwsCtoH37x9Qy50GY29XowlKg6n7bACYvgJPfiB7maW6zCBuX8U+wgUY2vVv3uhSk82yP/XY99+pjZ8IljGktm36R2ZYaBD4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa49aad-0809-403f-678e-08d880cb45e1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 14:09:41.4070 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +II0BcelKlrfUmUwunj413vCluJNag4DnxYwSVIPcKXrmQqqUXNcF/L/Y2+g6zOPACkVwIyF5hkjSqf4P2cjBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Qin,
 Eddy" <Eddy.Qin@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMDQvMTEvMjAgNToyNCBwbSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwNC4xMS4y
MCB1bSAxMTo0MCBzY2hyaWViIFNoYXJtYSwgU2hhc2hhbms6Cj4+IFtBTUQgUHVibGljIFVzZV0K
Pj4KPj4gSGVsbG8gQ2hyaXN0aWFuLAo+PiBZZXMsIHRoYXQgMTAwIGlzIGhhcmRjb2RlZCBpbiBS
YWRlb24sIGFuZCBnaXQgYmxhbWUgc2F5cyBpdCB3YXMgb25lIG9mIHlvdXIgcGF0Y2hlcyB3aGlj
aCBtYWRlIGl0IDEwMCBmcm9tIDEyOCDwn5iKLgo+PiBXb3VsZCB5b3UgbWluZCBoYXZpbmcgYSBs
b29rIGF0IGNvbW1pdCBpZDogNGIyMWNlMWI0YjVkMjYyZTdkNDY1NmI4ZWNlY2M4OTFmYzNjYjgw
NiA/Cj4gQWgsIHllcyB0aGF0IG9uZSA6KQo+Cj4gWWVhaCB0aGUgYmFja2dyb3VuZCBpcyB0aGF0
IHRoaXMgd2FzIGp1c3QgYW4gZWR1Y2F0ZWQgZ3Vlc3MgYmVjYXVzZSBJIAo+IGNvdWxkbid0IGZp
bmQgYW55Ym9keSB3aGljaCBjb3VsZCB0ZWxsIG1lIHdoYXQgdGhlIHJlYWwgbGltaXRzIG9mIHRo
ZSAKPiBQTEwgaXMuCj4KPiBMb29rcyBsaWtlIHdlIGp1c3QgZm9yZ290IHRvIGFwcGx5IHRoYXQg
cGF0Y2ggdG8gYW1kZ3B1Lgo+Cj4gUmVnYXJkcywKPiBDaHJpc3RpYW4uCgoKQ29vbCwgSSB3YXMg
d29uZGVyaW5nIGlmIHdlIHNob3VsZCBsZXQgdGhpcyBwYXRjaCBnbyB0aHJvdWdoIHNvbWUgZWxh
Ym9yYXRlZCBQaXhlbCBjbG9jayB0ZXN0aW5nIG9uIGRpZmZlcmVudCByZXNvbHV0aW9uLCBvciBp
cyBpdCBvayB0byBnbyBhaGVhZCB3aXRoIHRoaXMgcGF0Y2ggYmFzZWQgb24gdGhlIGV4cGVyaWVu
Y2UgZnJvbSBSYWRlb24gZHJpdmVyIGNoYW5nZSA/CgpSZWdhcmRzCgpTaGFzaGFuawoKPj4gUmVn
YXJkcwo+PiBTaGFzaGFuawo+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBL
b2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPgo+PiBTZW50OiBXZWRu
ZXNkYXksIE5vdmVtYmVyIDQsIDIwMjAgMzozNSBQTQo+PiBUbzogU2hhcm1hLCBTaGFzaGFuayA8
U2hhc2hhbmsuU2hhcm1hQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
PiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgUWlu
LCBFZGR5IDxFZGR5LlFpbkBhbWQuY29tPgo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1k
Z3B1OiBjbGlwIHRoZSByZWYgZGl2aWRlciBtYXggdmFsdWUgYXQgMTAwCj4+Cj4+IEFtIDAzLjEx
LjIwIHVtIDE4OjEzIHNjaHJpZWIgU2hhc2hhbmsgU2hhcm1hOgo+Pj4gVGhpcyBwYXRjaCBsaW1p
dHMgdGhlIHJlZl9kaXZfbWF4IHZhbHVlIHRvIDEwMCwgZHVyaW5nIHRoZSBjYWxjdWxhdGlvbgo+
Pj4gb2YgUExMIGZlZWRiYWNrIHJlZmVyZW5jZSBkaXZpZGVyLiBXaXRoIGN1cnJlbnQgdmFsdWUg
KDEyOCksIHRoZQo+Pj4gcHJvZHVjZWQgZmJfcmVmX2RpdiB2YWx1ZSBnZW5lcmF0ZXMgdW5zdGFi
bGUgb3V0cHV0IGF0IHBhcnRpY3VsYXIKPj4+IGZyZXF1ZW5jaWVzLiBSYWRlb24gZHJpdmVyIGxp
bWl0cyB0aGlzIHZhbHVlIGF0IDEwMC4KPj4gTWhtLCBpcyB0aGF0IDEwMCBoYXJkIGNvZGVkIGlu
IHJhZGVvbj8gSSBoYXZlIG5vIGlkZWEgd2hlcmUgdGhhdCBpcyBjb21pbmcgZnJvbS4KPj4KPj4g
QmVzdCB3b3VsZCBwcm9iYWJseSB0byBncmFiIGEgaGFyZHdhcmUgZW5naW5lZXIgYW5kIHRyeSB0
byBmaWd1cmUgb3V0IHdoYXQgdGhlIHJlYWwgbWF4aW11bXMgZm9yIHRoZSBQTEwgaXMgdG8gc3Rp
bGwgcHJvZHVjZSBhIHN0YWJsZSBzaWduYWwuCj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+IE9uIE9s
YW5kLCB3aGVuIHdlIHRyeSB0byBzZXR1cCBtb2RlIDIwNDh4MTI4MEA2MCAoYSBiaXQgd2VpcmQs
IEkKPj4+IGtub3cpLCBpdCBkZW1hbmRzIGEgY2xvY2sgb2YgMjIxMjcwIEtoei4gSXQncyBiZWVu
IG9ic2VydmVkIHRoYXQgdGhlCj4+PiBQTEwgY2FsY3VsYXRpb25zIHVzaW5nIHZhbHVlcyAxMjgg
YW5kIDEwMCBhcmUgdmFzdGx5IGRpZmZlcmVudCwgYW5kCj4+PiBsb29rIGxpa2UgdGhpczoKPj4+
Cj4+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+Pj4gfFBh
cmFtZXRlciAgICB8QU1ER1BVICAgICAgICB8UmFkZW9uICAgICAgIHwKPj4+IHwgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8Cj4+PiArLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+Pj4gfENsb2NrIGZlZWRiYWNrICAgICAgICAgICAg
ICB8ICAgICAgICAgICAgIHwKPj4+IHxkaXZpZGVyIG1heCAgfCAgMTI4ICAgICAgICAgfCAgIDEw
MCAgICAgICB8Cj4+PiB8Y2FwIHZhbHVlICAgIHwgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
fAo+Pj4gfCAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwKPj4+IHwg
ICAgICAgICAgICAgfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8Cj4+PiArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+Pj4gfHJlZl9kaXZfbWF4ICB8ICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgIHwKPj4+IHwgICAgICAgICAgICAgfCAgNDIgICAgICAg
ICAgfCAgMjAgICAgICAgICB8Cj4+PiB8ICAgICAgICAgICAgIHwgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgfAo+Pj4gfCAgICAgICAgICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAg
IHwKPj4+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4+PiB8
cmVmX2RpdiAgICAgIHwgIDQyICAgICAgICAgIHwgIDIwICAgICAgICAgfAo+Pj4gfCAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwKPj4+ICstLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCj4+PiB8ZmJfZGl2ICAgICAgIHwgIDEwMzI2ICAg
ICAgIHwgIDgxOTUgICAgICAgfAo+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsKPj4+IHxmYl9kaXYgICAgICAgfCAgMTAyNCAgICAgICAgfCAgMTYzICAgICAg
ICB8Cj4+PiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwo+Pj4g
fGZiX2Rldl9wICAgICB8ICA0ICAgICAgICAgICB8ICA5ICAgICAgICAgIHwKPj4+IHxmcmFjIGZi
X2RlXl9wfCAgICAgICAgICAgICAgfCAgICAgICAgICAgICB8Cj4+PiArLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tKwo+Pj4KPj4+IFdpdGggcmVmX2Rpdl9tYXggdmFs
dWUgY2xpcHBlZCBhdCAxMDAsIEFNREdQVSBkcml2ZXIgY2FuIGFsc28gZHJpdmUKPj4+IHZpZGVt
b2RlIDIwNDh4MTI4MEA2MCAoMjIxTWh6KSBhbmQgcHJvZHVjZSBwcm9wZXIgb3V0cHV0IHdpdGhv
dXQgYW55Cj4+PiBibGFua2luZyBhbmQgZGlzdG9ydGlvbiBvbiB0aGUgc2NyZWVuLgo+Pj4KPj4+
IFBTOiBUaGlzIHZhbHVlIHdhcyBjaGFuZ2VkIGZyb20gMTI4IHRvIDEwMCBpbiBSYWRlb24gZHJp
dmVyIGFsc28sIGhlcmU6Cj4+PiBodHRwczovL2dpdGh1Yi5jb20vZnJlZWRlc2t0b3AvZHJtLXRp
cC9jb21taXQvNGIyMWNlMWI0YjVkMjYyZTdkNDY1NmI4Cj4+PiBlY2VjYzg5MWZjM2NiODA2Cj4+
Pgo+Pj4gQ2M6IEFsZXggRGV1Y2hlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4KPj4+IENj
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+PiBDYzogRWRk
eSBRaW4gPEVkZHkuUWluQGFtZC5jb20+Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogU2hhc2hhbmsg
U2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BsbC5jIHwgMiArLQo+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wbGwuYwo+Pj4gYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMKPj4+IGluZGV4IDFmMjMwNWI3YmQxMy4uMjNhMmUx
ZWJmNzhhIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3BsbC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcGxsLmMK
Pj4+IEBAIC04NSw3ICs4NSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9wbGxfZ2V0X2ZiX3JlZl9k
aXYodW5zaWduZWQgbm9tLCB1bnNpZ25lZCBkZW4sIHVuc2lnbmVkIHBvc3RfCj4+PiAgICAJCQkJ
ICAgICAgdW5zaWduZWQgKmZiX2RpdiwgdW5zaWduZWQgKnJlZl9kaXYpCj4+PiAgICB7Cj4+PiAg
ICAJLyogbGltaXQgcmVmZXJlbmNlICogcG9zdCBkaXZpZGVyIHRvIGEgbWF4aW11bSAqLwo+Pj4g
LQlyZWZfZGl2X21heCA9IG1pbigxMjggLyBwb3N0X2RpdiwgcmVmX2Rpdl9tYXgpOwo+Pj4gKwly
ZWZfZGl2X21heCA9IG1pbigxMDAgLyBwb3N0X2RpdiwgcmVmX2Rpdl9tYXgpOwo+Pj4gICAgCj4+
PiAgICAJLyogZ2V0IG1hdGNoaW5nIHJlZmVyZW5jZSBhbmQgZmVlZGJhY2sgZGl2aWRlciAqLwo+
Pj4gICAgCSpyZWZfZGl2ID0gbWluKG1heChESVZfUk9VTkRfQ0xPU0VTVChkZW4sIHBvc3RfZGl2
KSwgMXUpLAo+Pj4gcmVmX2Rpdl9tYXgpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
