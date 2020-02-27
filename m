Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A6C4BA3B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3857C24672
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oiU+WrNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3857C24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC9A6EC81;
	Thu, 27 Feb 2020 10:23:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8097D6EC81
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 10:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FozbXHFVResH1GS4eH7O3458g8hiOyP9hUDhj252lFxtVS4cLXdJCkAIqcj/MYoIzwYNz19Wtdl7iJf5jMnModXyoTru4Yi2Qvhu9//+lSGx5v+nfEI/jND5dIuaki6yaP/RTCjLq0dtgB/wd+CG+CFMvCy4YgzJFhNnxRTqkW4H/Lime9DCPhsiFWEjyXNc8xljncAxiEW+pen6H1vD0zPYbYR6cBMfNA9Sxlq2IVyiyRLOjOBUFnTqD9Ie+vRGK9nhe0hvuL0Li4IdN85fw0ytaORR/bRxqQbgAuLkihGtYzgsaIr5CoyxygK2RcWghlFbNaNwboHO8VQTGBq5RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9No4e8jMKLQM9HWCREpfyKrGSlh9mryi5lrHhHEZ7vY=;
 b=MtDDsRJhd8lSJCbqodhmDsopLSbLf/lkB2a10VdOkYSUXXmsgP5RuN9eHuavqB64NvhMpoG0KL1zKzdJos5Vz7LkDyxUjYTjwd4EF8OyoAQ1nP588vVm/IdHK45EsGJSRYCka0f2EcR5S8uQnbngyCaNP9JvZrFOjfltOLRK84U/G5kHZ9jrIiWOxBs5nnTHiMGaqqdhWaEoHLY9aXTqPtxpRF5ovjn2XU8tO8j+azd5d5DPKd8UG/yvpYJESCK9K5DcJbgSxNibM7CedKCBmuVTBCFtAcdU4udRw08UDoV//D47jmCrnKMxfUN4mw2g1w4RVm3NcfO66odmuTSdiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9No4e8jMKLQM9HWCREpfyKrGSlh9mryi5lrHhHEZ7vY=;
 b=oiU+WrNqtaLH+/h7camhvyMN7RBBPj/j5y7LSr5y+B3Wm65mhy7HT+UcJQ+xOctXhj3z+myGHqUiFo54uyvoxgpWYLB8MDZ7RaMz+QkPW83Cn/jddUYOp+GDzyLRjD2yVnJrqsfKwczblA2eqAY7gjo4dK80FfvCbGWxKF68OhE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1468.namprd12.prod.outlook.com (2603:10b6:4:10::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:23:06 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:23:06 +0000
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: change hw sched list on ctx priority
 override
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200226203730.4621-1-nirmoy.das@amd.com>
 <20200226203730.4621-3-nirmoy.das@amd.com>
 <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <112d864d-f182-9bd1-7c07-44f9d7034b77@amd.com>
Date: Thu, 27 Feb 2020 11:26:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <2c8957cf-f4b5-2b65-acb6-d366c2fbc656@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0005.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::18) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 AM0PR02CA0005.eurprd02.prod.outlook.com (2603:10a6:208:3e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 10:23:05 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b416629-af26-4d8d-2a5b-08d7bb6f092a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1468:|DM5PR12MB1468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14680160744719A849DE0CA98BEB0@DM5PR12MB1468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(16526019)(186003)(6666004)(8936002)(52116002)(81166006)(81156014)(31686004)(6486002)(53546011)(8676002)(2906002)(66556008)(66476007)(4326008)(66946007)(2616005)(5660300002)(31696002)(478600001)(110136005)(36756003)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1468;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eav94vnMDSo+fdvMnckBUu94vIvH+d3efiYQKi0IFgTGEhRkEKk4kdewcUk8cGDGKaQWMD2KtU5k46aEZXrGfl+Z0Q1RccBeHGFL+hf/rbM22mk00tTx4oGqo4GZtSlogVA5ACIcvO1nOjGJOScncBxMNzXsP2E0RuXJ03uIa5POZJWlme93V3yMJcoB6a9u7o7Yn3t1l7DKfyjvoEiyWasSREqwtdEnjvYwkcsmtcX7tF0feXVKw/342Vjik/uuk3rh4B0bOFwQdGeAovUDAb67UBeISNATqccbVOhtumrhRqDD4VNr7aP77cIc72fNiY5cybVnjek29ygMkTsA4Xma3oZCqKy85LGslY4ITQcCcu870r6QEoswVSo5cr296b/W+z+NUn26Vz/X4TkaslG2/IxsRuSshYb+NrezlKR7L1S4/nHifHlEj3I4p5go
X-MS-Exchange-AntiSpam-MessageData: IS8KjzM3PcYz+o1IRWnoOSW2fEtO2ZosR8+ZHDK1AIZ+HbdGOFZs7Bn2hbXcArEYTkcWn4p+xGDK91RADVgoeB9iNtBNk7nah6jIbXXfJPTI7PrFUUB7qCOJMK88sq1R3iEvJ3SK82h9wJSKSbFKjXGE/NflT2qVT9kxQg/b8EcEgKUuRsoK3ZwIbSFom6jkxX2spjNb1JF8STtyyIahgw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b416629-af26-4d8d-2a5b-08d7bb6f092a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:23:06.6796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNCZkvlZOgoXtmwYCWR4nr2aF1MvEUcIyn0XLDhPdCs8aLy27J2Symu6I3Vd9yZ8YAqAMLv3rg2jTL+zCcQJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1468
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIvMjcvMjAgMTE6MDggQU0sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc2NoZWRzID0gYWRldi0+c2RtYS5zZG1hX3NjaGVkOwo+PiBA
QCAtNTAyLDYgKzUwNywyNCBAQCBzdHJ1Y3QgZG1hX2ZlbmNlICphbWRncHVfY3R4X2dldF9mZW5j
ZShzdHJ1Y3QgCj4+IGFtZGdwdV9jdHggKmN0eCwKPj4gwqDCoMKgwqDCoCByZXR1cm4gZmVuY2U7
Cj4+IMKgIH0KPj4gwqAgK3N0YXRpYyB2b2lkIGFtZGdwdV9jdHhfaHdfcHJpb3JpdHlfb3ZlcnJp
ZGUoc3RydWN0IGFtZGdwdV9jdHggKmN0eCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgdTMyIGh3X2lwLAo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnVtIGRybV9zY2hlZF9wcmlvcml0eSBw
cmlvcml0eSkKPj4gK3sKPj4gK8KgwqDCoCBpbnQgaTsKPj4gKwo+PiArwqDCoMKgIGZvciAoaSA9
IDA7IGkgPCBhbWRncHVfY3R4X251bV9lbnRpdGllc1tod19pcF07ICsraSkgewo+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCFjdHgtPmVudGl0aWVzW2h3X2lwXVtpXSkKPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY29udGludWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qIFRPRE8gd2hhdCBo
YXBwZW5zIHdpdGggcHJldiBzY2hlZHVsZWQgam9icyAqLwo+Cj4gSWYgd2UgZG8gaXQgcmlnaHQs
IHRoYXQgc2hvdWxkIGJlIHVucHJvYmxlbWF0aWMuCj4KPiBUaGUgZW50aXR5IGNoYW5nZXMgdGhl
IHJxL3NjaGVkdWxlciBpdCBzdWJtaXRzIHN0dWZmIHRvIG9ubHkgd2hlbiBpdCAKPiBpcyBpZGxl
LCBlLmcuIG5vIGpvYnMgb24gdGhlIGhhcmR3YXJlIG5vciBzb2Z0d2FyZSBxdWV1ZS4KPgo+IFNv
IGNoYW5naW5nIHRoZSBwcmlvcml0eSB3aGVuIHRoZXJlIGlzIHN0aWxsIHdvcmsgc2hvdWxkIGJl
IG9rIGJlY2F1c2UgCj4gaXQgd29uJ3QgdGFrZSBlZmZlY3QgdW50aWwgdGhlIGVudGl0eSBpcyBp
ZGxlLgpUaGFua3MgY2xhcmlmeWluZyB0aGF0Lgo+Cj4gQ2FuIG9mIGNvdXJzZSBiZSB0aGF0IHVz
ZXJzcGFjZSB0aGVuIHdvbmRlcnMgd2h5IHRoZSBuZXcgcHJpb3JpdHkgCj4gZG9lc24ndCB0YWtl
IGVmZmVjdC4gQnV0IHdoZW4geW91IHNob290IHlvdXJzZWxmIGludG8gdGhlIGZvb3QgaXQgaXMg
Cj4gc3VwcG9zZWQgdG8gaHVydCwgZG9lc24ndCBpdD8KIMKgOkQKPgo+PiArIGRybV9zY2hlZF9l
bnRpdHlfZGVzdHJveSgmY3R4LT5lbnRpdGllc1tod19pcF1baV0tPmVudGl0eSk7Cj4+ICvCoMKg
wqDCoMKgwqDCoCBhbWRncHVfY3R4X2ZpbmlfZW50aXR5KGN0eC0+ZW50aXRpZXNbaHdfaXBdW2ld
KTsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2N0eF9pbml0X2VudGl0eShjdHgsIEFN
REdQVV9IV19JUF9DT01QVVRFLCBpKTsKPgo+IFdlbGwsIHRoYXQgaXMgbW9zdCBsaWtlbHkgTk9U
IHRoZSByaWdodCB3YXkgb2YgZG9pbmcgaXQgOikgRGVzdHJveWluZyAKPiB0aGUgZW50aXR5IHdp
dGggZmluaSBhbmQgcmVpbml0IG1pZ2h0IGNhdXNlIHF1aXRlIGEgYnVuY2ggb2YgcHJvYmxlbXMu
Cj4KPiBDb3VsZCBiZSB0aGF0IHRoaXMgd29ya3MgYXMgd2VsbCwgYnV0IEkgd291bGQgcmF0aGVy
IGp1c3QgYXNzaWduIAo+IHNjaGVkX2xpc3QgYW5kIG51bV9zY2hlZF9saXN0LgoKSG93IGFib3V0
IGRvaW5nIHRoYXQgd2l0aCBhIG5ldyBmdW5jdGlvbiBsaWtlIApkcm1fc2NoZWRfZW50aXR5X21v
ZGlmeV9zY2hlZCgpID8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
