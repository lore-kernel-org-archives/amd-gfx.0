Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB893C433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C08264EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C08264EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D3C6EBFE;
	Wed, 24 Feb 2021 22:22:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A156EB9F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADkwE1gIY9S5tTPD2dWkBkgWIjtFoGgf1oKAJek8OZ95ZMdtiAsr0/wyXkzAgYtYouML1KVizR+BAw3ZEkJoNnIbmlanPC92ZOAcPT1xDTXNNDqwelvc7NRkAI1832Fz6hlZ7JNfuLcPiDeZ8WGozDi03Q4nOeYojZJVz7tEoof7Ks7gpAShDmwShSe2I6tsjZfKswtnOhrU0QnUXv5bj1D4WHqiGgKAkhO54OUW3NIwSGTYWvot8D5Kl4n07n04uuRuIAH00hp5VsE68PjFgVVjPO2KVVdlj9500584qEdu8bdaHZgL2i4TMFlaPG3FdMe4slOLwta8m6Dp/yb+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FGOHoBCB2iUKgmnr1jctyehAUHGlXvbKNyAmSdn610=;
 b=lKB1KzGJ5sDj+YBNaZ87g0pskJbmivmCt72vjRRhLDzpuC+GHe2W1VXv6TGIqSwP3Phg1Ip4pucdujqxWJpZ5CEe5WmYqls9iDbRbunQHGv78kPnQQgK2DMa+llg+eAWJoMGlglWTN4CCONdNFfq+d9wX232P2C3y5eqFqCVwJXadB4MOGgdJQx5XVsOPcCmdVYTtBZcsEmDnTHMdgk74/N/Bq1Ue8yfjHksPXF+8SHpaHQR7bnj3y3QYDX/TnsF0zC8qtKZjulhdpt0Xm93oPKEa1J2DV/XbJZ0RXzL7+iTYLeimoIR1qzqEoUzaGo+l0C5yLjEv8vyXJaI4bwzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FGOHoBCB2iUKgmnr1jctyehAUHGlXvbKNyAmSdn610=;
 b=iliUGx2NyGB+Bl0K6rC1HtQ7VfwZw0HJl/7sdxwODQUDEDific0pj7UlHXCmczPoyIy2Zbqsh8UwfS8iAf8taZbnT8HNf4BKSgikI22NAEW8BCIelAGBVyhGMBp5/PxMd/dVeEWlMyYO3TsLfZMeGm3gTdDuI6wdD0GDBCor8ak=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4722.namprd12.prod.outlook.com (2603:10b6:208:8c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 22:22:41 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:41 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 157/159] drm/amdgpu: change psp_rap_invoke() function return
 value
Date: Wed, 24 Feb 2021 17:18:57 -0500
Message-Id: <20210224221859.3068810-150-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 40140236-86ab-4765-011d-08d8d9127b76
X-MS-TrafficTypeDiagnostic: BL0PR12MB4722:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4722657848CFB353B944639CF79F9@BL0PR12MB4722.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLev++5oSmMEIf7fv+N8ff9FJGwOe+MQEFfmpH67Luw7jtYfgpUhXrKppz9wtoNgNkyTvokyaF5qUahpPSslHX25HH/3V7l/5SQYPX9ANzMMR+013N0FAgPCEIh0xxFwDMDbJyEokBOz6Moi4h4Fc9ke/S1ehSdBaHVHG5VaS6/meFlpioIKvcMN6UPqOAYnSmlb4D2HRbbE9puLrC+3dHnnDhuD/jP33a3dDwMyykLWjXnKGArKn1DFuFCR09TG9kAWfG6wAqt103sTRq3Xh1mK5VVVaQX0U8D+F0YdjTEM1GN+SK8Y0+idAbGIQjEQgDjy5jxxsFGJocoQIYhDPNtfJbVxefk6hAHQEZZVGdSOXkc7SEMrX2BkguEt2dCApMdZ5e8F6yt5a2i/V2ER4Kv3Wlt0R2KUkz2iErzUbt2GzHKv1M7Jy0kjWjJSFJUnJ2G4EvspbmfPQqTqnrCbY28KMfydGKZaebgH0uyJjP/Fyxsb6JS0M6s1ZaJ+G+G3DutnRMO42azS9RA+OlRc3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(8676002)(6916009)(4326008)(6506007)(8936002)(478600001)(66476007)(54906003)(6486002)(2906002)(6512007)(86362001)(52116002)(956004)(5660300002)(83380400001)(316002)(16526019)(1076003)(2616005)(36756003)(186003)(66946007)(66556008)(26005)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZjZRUytwalBzblRYYU84eG9lOWRyWkNyMng4SE8xK1ZZdkFBa1lPTS9yeFQ2?=
 =?utf-8?B?WGkwY2diK1B2TGZONjF0UC9VSUk5anVHRlpkZnk2ZW5sRm4xSSt4d2RGdlZ5?=
 =?utf-8?B?Vnp3Rm1DY2J2dzdSL2RPYnlSYWwwV2JkSVZWODJNUytKbm12dVZQZEVsdDNE?=
 =?utf-8?B?Vmh1ekUveHhLSFUrVjg0QU9ycWFTK05FdkZTekYrUVhiVi90VFBNQnpwT1Vr?=
 =?utf-8?B?ZFZ4QnZXalNVSGNCSVRYSk9aMExQSURlSTBjd0kwMVVBbWhFYXZtblJjcHU3?=
 =?utf-8?B?Qk54bVFnU3orSmhGY0dCaHBNUjJzR1FndFgrK2o2YXluWDkwOEVKUWVGbFJV?=
 =?utf-8?B?bEZGMnNET2FXSUtsNnVYNE1JQkUxQ2ZHQWVzamg5Zk5lbitueGx4bDhJYVhL?=
 =?utf-8?B?MlFlRWxmQnh2NDFBT0ZuUmMzRDNKQ2xRSWZ1TmVnMzRtZERRTFE5U2FPYzIz?=
 =?utf-8?B?bGNQcm9POGtEUUxSdzdILzFrb0Y3VnlodjJlOVlUZ1VpblVpeHdPanVoTWg0?=
 =?utf-8?B?SmpNMmMzVEk1WmxDK1NmVE5tRHdkeGgxSVlJRVJHSnpDNnlvYWRvMTNGcjZ6?=
 =?utf-8?B?dk83bUR4VFF6VmJVbEhxUm9OY1N4bEJybkJySEl6dmhlelZvOFVuL0RhNVp3?=
 =?utf-8?B?M2U4RkhqeGJCMDBIenQ5NWlZRXAzL0RIN01xamV2MVUwam9VUVU5OWVBbXpi?=
 =?utf-8?B?dHZpcVQzL3ZwRzQyS001dDJYdlk5UURGRHd0RmlFTElWQTJIQmprVlJ4WEdj?=
 =?utf-8?B?TTJPbkdIZVFBYks1QjVrSXl6eXVnT1piZS9ZYjBia2F6Mk5oK2Vic0crQ3Z2?=
 =?utf-8?B?THNSTjFlbFRiWTFpenJiVFdoN01QcDZVUjVxVG1VQkRUakJ2dDcxaEtOcFky?=
 =?utf-8?B?dlZBUXN3d3R2YWVUSWkyVzdlT3hTUGt4YWNCYy9qbFJzMjNGU0tUVGFITE8y?=
 =?utf-8?B?MEJ1UUhwcW50ZVdHZVBSTWZycFNPcS8zVGpDRXFkc0dmVDQ5Rmw1R1hUSEhH?=
 =?utf-8?B?TnpZYUowRndpdXRhbHZ2TWxxK1JKcUYwbkQ5MlljZ2RralVyNkpzYk84Ny9C?=
 =?utf-8?B?NXE0a3F4QW1NZ1NmbU1HQVVhQ3lYYmtxeGhudTh3T2Zya1l3UFdvR3JrY0Ir?=
 =?utf-8?B?ekFFY1hEU0kxWFNrZDc1STlJSStnUmxjdjdkWkxMVXFiM3RRdHpYOGpwblVi?=
 =?utf-8?B?SWtuM2g4eWdndFdOSC9xODNMSzV0d1oyVlJhNE5BRDFjaG52R0F6V3VFakZB?=
 =?utf-8?B?bmZ4TVBrQUhzMlpnMjZKaWV5QmNXTDVFa2ZwMEYxNnpDYjNoZzZUUmxHTHpj?=
 =?utf-8?B?ZlR5clQ1QU52MnFINmJURHprOUNNWHRHQ3I3eThJZjZFWUc1RGo4QWR3YTZP?=
 =?utf-8?B?eGY0Unp4REI0b0VMekRZLytsaUZqNWsvL0xoTjIrYkRJbkg4Tkd6NjlqYjhh?=
 =?utf-8?B?UlZvMHA3N0E0RTFmRHJqLzEvQUJHakdaMlRNUXZCd2xaSGY4WjVJUGY5SFQx?=
 =?utf-8?B?K2doMmxJSi9uTHE3dDhuQXJUVmFHaktUZll0bnNSNUl1QXBydC8zdEwwSGo0?=
 =?utf-8?B?UEF3cThLVkhCTFU4V1h0YkNuRExpUHdHUys3SkpVSjY3Sm8zN3lwNjVUcHk2?=
 =?utf-8?B?RVJDMHNjWnFRUTdtSVJWL1RtTjJIdHYzVzZML2V0ZFFkUHYyODFITTdHWXZO?=
 =?utf-8?B?TlRNUHRzZVBjVDNuRkMvN29vUzdaTkNTK2lqMElMZnBXUkFBUUR5T3U2SjFM?=
 =?utf-8?Q?4o423DiuM3T+C3cHhDJhSJiSLfpQZXhkYZr3Khb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40140236-86ab-4765-011d-08d8d9127b76
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:07.8836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpfCPb7e0DcS0dea+HZ2fPdlNraWuz0yfszj6HjEGHvjVjiSXgoQubm3IETvSEJX+4uSXfmVyobpC5pHz8sSrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4722
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Kevin Wang <kevin1.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogS2V2aW4gV2FuZyA8a2V2aW4xLndhbmdAYW1kLmNvbT4KClJBUCBUQSBpcyBhbiBvcHRp
b25hbCBmaXJtd2FyZS4gaWYgaXQgZG9lc27igJl0IGV4aXN0LAp0aGUgZHJpdmVyIHNob3VsZCBi
eXBhc3MgcHNwX3JhcF9pbnZva2UoKSBmdW5jdGlvbi4KCjEuIGJ5cGFzcyBwc3BfcmFwX2ludm9r
ZSgpIHdoZW4gUkFQIFRBIGlzIG5vdCBsb2FkZWQuCjIuIGFkZCBuZXcgcGFyYW1ldGVyIChzdGF0
dXMpIHRvIHF1ZXJ5IFJBUCBUQSBzdGF0dXMuCiAgICh0aGUgc3RhdHVzIHZhbHVlIGlzIGRpZmZl
cmVudCB3aXRoIHBzcF90YV9pbnZva2UoKSwKMy4gZml4IHRoZSAncmFwX3N0YXR1cycgTVRocmVh
ZCBjcml0aWNhbCBwcm9ibGVtLgogICAodXNlZCB3aXRob3V0IGxvY2spCgpTaWduZWQtb2ZmLWJ5
OiBLZXZpbiBXYW5nIDxrZXZpbjEud2FuZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogSGF3a2luZyBa
aGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3BzcC5jIHwgMjkgKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3BzcC5oIHwgIDIgKy0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXAuYyB8ICA3ICsrKy0tLQogMyBmaWxlcyBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcHNwLmMKaW5kZXggNzFjNTBmOTNiNmQ0Li5iZjgzNjI1YzZkMjAgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmMKQEAgLTE1OTUsNiArMTU5NSw3IEBAIHN0YXRp
YyBpbnQgcHNwX3JhcF91bmxvYWQoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCiBzdGF0aWMgaW50
IHBzcF9yYXBfaW5pdGlhbGl6ZShzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKIHsKIAlpbnQgcmV0
OworCWVudW0gdGFfcmFwX3N0YXR1cyBzdGF0dXMgPSBUQV9SQVBfU1RBVFVTX19TVUNDRVNTOwog
CiAJLyoKIAkgKiBUT0RPOiBieXBhc3MgdGhlIGluaXRpYWxpemUgaW4gc3Jpb3YgZm9yIG5vdwpA
QCAtMTYxOCw4ICsxNjE5LDggQEAgc3RhdGljIGludCBwc3BfcmFwX2luaXRpYWxpemUoc3RydWN0
IHBzcF9jb250ZXh0ICpwc3ApCiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotCXJldCA9IHBz
cF9yYXBfaW52b2tlKHBzcCwgVEFfQ01EX1JBUF9fSU5JVElBTElaRSk7Ci0JaWYgKHJldCAhPSBU
QV9SQVBfU1RBVFVTX19TVUNDRVNTKSB7CisJcmV0ID0gcHNwX3JhcF9pbnZva2UocHNwLCBUQV9D
TURfUkFQX19JTklUSUFMSVpFLCAmc3RhdHVzKTsKKwlpZiAocmV0IHx8IHN0YXR1cyAhPSBUQV9S
QVBfU1RBVFVTX19TVUNDRVNTKSB7CiAJCXBzcF9yYXBfdW5sb2FkKHBzcCk7CiAKIAkJYW1kZ3B1
X2JvX2ZyZWVfa2VybmVsKCZwc3AtPnJhcF9jb250ZXh0LnJhcF9zaGFyZWRfYm8sCkBAIC0xNjI4
LDggKzE2MjksMTAgQEAgc3RhdGljIGludCBwc3BfcmFwX2luaXRpYWxpemUoc3RydWN0IHBzcF9j
b250ZXh0ICpwc3ApCiAKIAkJcHNwLT5yYXBfY29udGV4dC5yYXBfaW5pdGlhbGl6ZWQgPSBmYWxz
ZTsKIAotCQlkZXZfd2Fybihwc3AtPmFkZXYtPmRldiwgIlJBUCBUQSBpbml0aWFsaXplIGZhaWwu
XG4iKTsKLQkJcmV0dXJuIC1FSU5WQUw7CisJCWRldl93YXJuKHBzcC0+YWRldi0+ZGV2LCAiUkFQ
IFRBIGluaXRpYWxpemUgZmFpbCAoJWQpIHN0YXR1cyAlZC5cbiIsCisJCQkgcmV0LCBzdGF0dXMp
OworCisJCXJldHVybiByZXQ7CiAJfQogCiAJcmV0dXJuIDA7CkBAIC0xNjU0LDEzICsxNjU3LDEz
IEBAIHN0YXRpYyBpbnQgcHNwX3JhcF90ZXJtaW5hdGUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3Ap
CiAJcmV0dXJuIHJldDsKIH0KIAotaW50IHBzcF9yYXBfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpCitpbnQgcHNwX3JhcF9pbnZva2Uoc3RydWN0IHBz
cF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCwgZW51bSB0YV9yYXBfc3RhdHVzICpz
dGF0dXMpCiB7CiAJc3RydWN0IHRhX3JhcF9zaGFyZWRfbWVtb3J5ICpyYXBfY21kOwotCWludCBy
ZXQ7CisJaW50IHJldCA9IDA7CiAKIAlpZiAoIXBzcC0+cmFwX2NvbnRleHQucmFwX2luaXRpYWxp
emVkKQotCQlyZXR1cm4gLUVJTlZBTDsKKwkJcmV0dXJuIDA7CiAKIAlpZiAodGFfY21kX2lkICE9
IFRBX0NNRF9SQVBfX0lOSVRJQUxJWkUgJiYKIAkgICAgdGFfY21kX2lkICE9IFRBX0NNRF9SQVBf
X1ZBTElEQVRFX0wwKQpAQCAtMTY3NiwxNCArMTY3OSwxNiBAQCBpbnQgcHNwX3JhcF9pbnZva2Uo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkKIAlyYXBfY21kLT52
YWxpZGF0aW9uX21ldGhvZF9pZCA9IE1FVEhPRF9BOwogCiAJcmV0ID0gcHNwX3RhX2ludm9rZShw
c3AsIHJhcF9jbWQtPmNtZF9pZCwgcHNwLT5yYXBfY29udGV4dC5zZXNzaW9uX2lkKTsKLQlpZiAo
cmV0KSB7Ci0JCW11dGV4X3VubG9jaygmcHNwLT5yYXBfY29udGV4dC5tdXRleCk7Ci0JCXJldHVy
biByZXQ7Ci0JfQorCWlmIChyZXQpCisJCWdvdG8gb3V0X3VubG9jazsKKworCWlmIChzdGF0dXMp
CisJCSpzdGF0dXMgPSByYXBfY21kLT5yYXBfc3RhdHVzOwogCitvdXRfdW5sb2NrOgogCW11dGV4
X3VubG9jaygmcHNwLT5yYXBfY29udGV4dC5tdXRleCk7CiAKLQlyZXR1cm4gcmFwX2NtZC0+cmFw
X3N0YXR1czsKKwlyZXR1cm4gcmV0OwogfQogLy8gUkFQIGVuZAogCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmgKaW5kZXggYjE5NzE3YjJlMTEwLi45YzlhMTNmMmExMjEgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmgKQEAgLTM5OSw3ICszOTksNyBA
QCBpbnQgcHNwX3Jhc190cmlnZ2VyX2Vycm9yKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLAogCiBp
bnQgcHNwX2hkY3BfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9j
bWRfaWQpOwogaW50IHBzcF9kdG1faW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwLCB1aW50
MzJfdCB0YV9jbWRfaWQpOwotaW50IHBzcF9yYXBfaW52b2tlKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwLCB1aW50MzJfdCB0YV9jbWRfaWQpOworaW50IHBzcF9yYXBfaW52b2tlKHN0cnVjdCBwc3Bf
Y29udGV4dCAqcHNwLCB1aW50MzJfdCB0YV9jbWRfaWQsIGVudW0gdGFfcmFwX3N0YXR1cyAqc3Rh
dHVzKTsKIGludCBwc3Bfc2VjdXJlZGlzcGxheV9pbnZva2Uoc3RydWN0IHBzcF9jb250ZXh0ICpw
c3AsIHVpbnQzMl90IHRhX2NtZF9pZCk7CiAKIGludCBwc3BfcmxjX2F1dG9sb2FkX3N0YXJ0KHN0
cnVjdCBwc3BfY29udGV4dCAqcHNwKTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yYXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXAuYwppbmRleCA4ZGE1MzU2YzM2ZjEuLjUxOTA5YmY4Nzk4YyAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JhcC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXAuYwpAQCAtNDgsNiArNDgsNyBAQCBzdGF0aWMgc3NpemVfdCBh
bWRncHVfcmFwX2RlYnVnZnNfd3JpdGUoc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgX191c2Vy
ICpidWYsCiAJc3RydWN0IHRhX3JhcF9jbWRfb3V0cHV0X2RhdGEgKnJhcF9jbWRfb3V0cHV0Owog
CXN0cnVjdCBkcm1fZGV2aWNlICpkZXYgPSBhZGV2X3RvX2RybShhZGV2KTsKIAl1aW50MzJfdCBv
cDsKKwllbnVtIHRhX3JhcF9zdGF0dXMgc3RhdHVzOwogCWludCByZXQ7CiAKIAlpZiAoKnBvcyB8
fCBzaXplICE9IDIpCkBAIC03MCw5ICs3MSw4IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9yYXBf
ZGVidWdmc193cml0ZShzdHJ1Y3QgZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKIAog
CXN3aXRjaCAob3ApIHsKIAljYXNlIDI6Ci0JCXJldCA9IHBzcF9yYXBfaW52b2tlKCZhZGV2LT5w
c3AsIG9wKTsKLQotCQlpZiAocmV0ID09IFRBX1JBUF9TVEFUVVNfX1NVQ0NFU1MpIHsKKwkJcmV0
ID0gcHNwX3JhcF9pbnZva2UoJmFkZXYtPnBzcCwgb3AsICZzdGF0dXMpOworCQlpZiAoIXJldCAm
JiBzdGF0dXMgPT0gVEFfUkFQX1NUQVRVU19fU1VDQ0VTUykgewogCQkJZGV2X2luZm8oYWRldi0+
ZGV2LCAiUkFQIEwwIHZhbGlkYXRlIHRlc3Qgc3VjY2Vzcy5cbiIpOwogCQl9IGVsc2UgewogCQkJ
cmFwX3NoYXJlZF9tZW0gPSAoc3RydWN0IHRhX3JhcF9zaGFyZWRfbWVtb3J5ICopCkBAIC05Nyw2
ICs5Nyw3IEBAIHN0YXRpYyBzc2l6ZV90IGFtZGdwdV9yYXBfZGVidWdmc193cml0ZShzdHJ1Y3Qg
ZmlsZSAqZiwgY29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwKIAlkZWZhdWx0OgogCQlkZXZfaW5mbyhh
ZGV2LT5kZXYsICJVbnN1cHBvcnRlZCBvcCBpZDogJWQsICIsIG9wKTsKIAkJZGV2X2luZm8oYWRl
di0+ZGV2LCAiT25seSBzdXBwb3J0IG9wIDIoTDAgdmFsaWRhdGUgdGVzdCkuXG4iKTsKKwkJYnJl
YWs7CiAJfQogCiAJYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCB0cnVlKTsKLS0gCjIuMjkuMgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
