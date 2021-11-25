Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E83FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 02:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFBE36E3AE;
	Thu, 25 Nov 2021 02:19:01 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5D36E3AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 02:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzZqlXE9G4exfXP9czG9HanvSrfutA9AovocDcuRUDJMVFl/SmTRbyGwGbzNdTfkGkb/TaLOno4O8jolQD9YUylKc90dWcYSirA+FJBscesRw4jW3usXWI7GwFvfuueAokFcwtsEi1LZHEaQxz5cmaJI1gBZq3yh8dB8Y+I5FvTULR3AZTTjjS9yDyLfWby5MF47mAwEl5hDOH4fWLbNsMF61NPMJkyg8EFt7GJD+Lwp6EqU/Q8PtsqEVOp8675OAoUslt1rW9CWjQObda6QFp4uUy/uAEXJlPCJFScH5uSGTBgWJfyl/7hwSvndWQaypeFYZz/97bmpWbpyXG8cJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TAuYEUoiST+1qoR/ijVgpeQMiMMT2dWy7QAXoWKo8U=;
 b=Jxj1ermnzYucuj7Zzy68hOVH4qH218nkFO19lukx0Ljrf43lDn4eQLasahCihAkB0RiqvHmU/h5W/a+0c6fXIr1g2bpdXAOj0u9c40w88USTMU5AuwisMR+5qUrAszX1MJyWZCrr2vBTYNwcZR0MN8IafkcNu4y0zdT+KgjfDzxjrUZtOGq3ngFKSl6PuX/XZny6VZxZ+0RuUFKswHrzsP6kY7Amb8RhN/9RcF+K/vbhb0q4inI8VwIRDc0zKLxqlLhSC5zADdpvczcih4u21+P9AgKnEeCWMoww2kFQ6/UegaYv/BjcyMgYU13+GzEd/DUtx0ES1oVcCAPAT/VGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TAuYEUoiST+1qoR/ijVgpeQMiMMT2dWy7QAXoWKo8U=;
 b=mYA0f8hlA/BMxYkAMN18rfHT0RvYyn3tNHztSYTlZ7iZVg7Elia/KxeaRU2xRaYrcSvPtEkUoyuX+Ycm6tu7fNo6ExLtkEbmIlT6GDYTMcFpmSi/6hmAjjUrRM4s8MNlACbA9eQVAq8iUf3tpysnTKGXBJV3tdTeSMOMO5B1mu8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB2988.namprd12.prod.outlook.com (2603:10b6:5:3d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.24; Thu, 25 Nov 2021 02:18:58 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 02:18:58 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Jian, Jane" <Jane.Jian@amd.com>
Subject: RE: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Topic: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
Thread-Index: AQHX4T58sdgLureBqECdY83svDUkSqwSuvGAgADHNyA=
Date: Thu, 25 Nov 2021 02:18:57 +0000
Message-ID: <DM5PR12MB24691FE17360A4A7A76D6825F1629@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211124142036.22491-1-Jane.Jian@amd.com>
 <CADnq5_P1=kz9dDwLtH98sHGgt6=C5Y=U1EoouGJktwFW0pBG7w@mail.gmail.com>
In-Reply-To: <CADnq5_P1=kz9dDwLtH98sHGgt6=C5Y=U1EoouGJktwFW0pBG7w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T02:18:46Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=8e1f208a-1034-4c43-b275-0fdacb379b8c;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-25T02:18:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 28905bf1-fd7e-4815-a208-0163af21b1ed
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe835652-969f-4e86-684d-08d9afb9f019
x-ms-traffictypediagnostic: DM6PR12MB2988:
x-microsoft-antispam-prvs: <DM6PR12MB2988F4D27A43CB529CA20324F1629@DM6PR12MB2988.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oR2cvfs4Dt8IadEKKhfr/8VhECIz0XH3UIBoa1j8JGGbhCKFdy76mXl4nZBx3v6NCv6Zo3ON+fByYtf8+Rxesx9PYGGh9GgczB1nFGHgjXvFkW0NU6JTdKG+FBAfPxDf8/8yUxKCEN/iwFzoMnbYWqK6ZxjFiVJePciag8NZh2i94tMiCP54xtZcytrbIW03oVp1iQBx6EVY3rPsYAij1hDoXC1GrSS3suW/wlxEyx+HjKQmnAmJ242Sug8sQr1E1SmznE92O2iYHaq+f9jtFpr1H03RHMdMyP/tOnmSgCiTagk0MpXkO9RVGhBwFLPp8uBOrb760SY7Zo8dJ2QKGJvu33pHPJbHDY4Ar6Abi3gN0jN1yZyn69GlLcYNueFua+usJnpEaALJEVPAmM66q445t1D78HHpCVdrmho5yhe6tzzkFS07OQIGljSor8iVhdBPQEL++37jBmyM9mYjc3evdI4qrl+O49kFC2WZLMD0brK1VhUJ2G41Y9U5CCUAfKfrp0V2og8zILEBpp3s8i3HaYId7h+upnR2qa8GOPNx/XJnmOjrN7HGaISu1Oj4DKn079h1yNN+Qf3BcbmQiLCUgfm6OjwcypLRo3/TEjofeBPohGBaWyoA1IfguWCqN0ISJYv7tHcn1ciwamjV//McPszV7wyhtcII2Ues9NuBRPzaD/pI/aSNjOxwRRBZLK2wNVi3xYUnZAp2ZDL6mQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(186003)(53546011)(55016003)(26005)(6636002)(2906002)(64756008)(52536014)(5660300002)(316002)(122000001)(7696005)(38100700002)(66556008)(66476007)(9686003)(66446008)(4326008)(66946007)(83380400001)(33656002)(110136005)(54906003)(76116006)(71200400001)(38070700005)(86362001)(508600001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REx2c1hKSzZ1ZjUybGswNWpacG9ZWE9YdDBNRHlsNTlMU2d6V3FtUXdwRzM1?=
 =?utf-8?B?NkJKclozWFl6RzFLZlBDTUMzQnZndUx6U2JKajdqQ0ZYcUc1dVV4aWNzQm5w?=
 =?utf-8?B?Z0RWcmFqZVF4dWZwWjNiT1VNa0NUT3NQTklpejNrcTh5VHZvTDFUTEdPTmoz?=
 =?utf-8?B?c2s1VFhnaE1uU3JVTnkvekV3aHBDbGdvWU9hRnJGaEtPNVVDRHlxeG40Zlpj?=
 =?utf-8?B?dEpxMHN3cWJlMTRsSkt5ZzV6VEhQVVlqZjNKN0I5bUVLWGtja1FFZ2Q2UVZB?=
 =?utf-8?B?dERqNVkwQWcxM2ozRTU5TzdqYXVrQlI5UHlOMENYSWVHeGJZZ3psUXlEdUx5?=
 =?utf-8?B?Y1MrYis4NTUrZXp0bHZibUxUTnNLMVlEMXRiaTQvc1lsWlc2d0VkZ3Q5MURU?=
 =?utf-8?B?bVdrK2Mwell4VzZzQUpLc2lnMWFyNnM2VUQ1NThvNkkwc1VJV0Rnelg5aFFO?=
 =?utf-8?B?YlJ0TGFKTGt6SllUR2ovenNSMGxwYXdKeHNJU20zamlqWXBmaWZ4QXZHcjEv?=
 =?utf-8?B?MlZxcFk0MjN2eFhaUUQwMmFhWDZOYUQ1a1owSjFzNVFQU3ZtYjA1ZFhFaG5G?=
 =?utf-8?B?YXhSRjhwS0x4Q0RqYnRDQzN4VUZ4VU82M05UUk04YXNQWTM3eWh2UG1yZVJl?=
 =?utf-8?B?bTNvMzJWMHZjRTY0YklCb2lkeHNOejJmMHF0Wm5mRysxTGtlZ2E4OE4xdERs?=
 =?utf-8?B?bFhaMkNnTUllQUJTc1c3MnZEOWdxbHEwYXdVRDljSFhpVnpFckJCci9uVlRp?=
 =?utf-8?B?YzRjUVNvVlQrazRVWUFKMlQydE5UbTA4NjlwWndsMHJkUEVHYjlHK01RS2xq?=
 =?utf-8?B?a2NkTFpRa285M0hzQnVmN0RQUTVuMTRWYTN1U05PdEZSRHZESVRrbnFIeGNQ?=
 =?utf-8?B?MmlhQnYzeXF2Ync0Z092QlhsVnRBc2VPbHA2UE1LaDBESEU5TGxqcjA3aWEw?=
 =?utf-8?B?NjNNMjN5RFpIdzJlM0tPNUFoWkI4VnA4TDZ2MENvR2pRYStDY3BOSWtRRG5G?=
 =?utf-8?B?RW1Ub1c1OS9yZXlIZWRkbDRONVBXNnRMWng1QmJmUTdqa0RYU0h5TkljQkdq?=
 =?utf-8?B?MjkwVGc2OGVQcDhFVE95cDdUOTlhRjNtU1ZSaDVvM01RUTF4RXFLeU1JV1My?=
 =?utf-8?B?TzdkMVZQaGlHMERMaXRqKzdsVVIzOWIxZTJlUEpIbXdWdXdzL1BHVnprdXMy?=
 =?utf-8?B?NGhVeDE3OElLckx6Z3Q2cHFKcWRsS004YXpEcEcvWEFaSE9saVBNVWhCTUxv?=
 =?utf-8?B?d20zb1dzNnA4blZyaTBzd3I2Y3lFOCtXOVZ4ek05R0NGWUlEVFBkYndrekE1?=
 =?utf-8?B?WmpwUmEwbC9NcHM2RS8rT1ZwdDIzK2prRGhpOXM1QkhONjFmeU1tYUpkUXJt?=
 =?utf-8?B?cmtTOUgzeHJCMHk4anhxK1BRTlNGUk0wKy9ib3M4ZVZQMS85cGxNNGJCS2Fa?=
 =?utf-8?B?UTNjTm45SXdwdllKWWowVXY4VDh0aFJBQ2JCME9FZVkrVnVsOTJ0d2JOMm5q?=
 =?utf-8?B?VVZuaDdrVUNqWUt4Ni9jVVozNVFDa28zTllGNVZIamRHaXBrMUh0OGZWK2R6?=
 =?utf-8?B?a2tOdkxaalBWbTd3MGx0L3Q3K3NueGpwRG14enlmQXYzdWF6T3l6L2hDR0tC?=
 =?utf-8?B?MWJmM2ZaQmVHYzhPK2NlRU1WUzM4azVBaUU1RXk1U0JIbllFbUtOMXdXYi9S?=
 =?utf-8?B?MkJkUTE3QnBQdDlYNHVzUnMvQkNaMWRqUFJBNGs4V0R4cGxFTFNONXRKaGNB?=
 =?utf-8?B?NVduc2ttUE5RbDY2TG9YeW5xeVhNVFE2a0xWNVI4eVlKRitxUE94Ky9TTVFk?=
 =?utf-8?B?M1ZpV050U0c5QlBqQ2NWSFYvbTFEV2FyYUlXaDgxMnVjSWYyL0lHNlU4RzVI?=
 =?utf-8?B?dWFSQlU3M3h3V2pscGdrN3dXeUJBQkkzVlJCWG9FQVBzNTlRRzNDR3FCWG91?=
 =?utf-8?B?YjdkSjFXbmZBc0dsZTN1eFpyWEVhK044eDF2M1RNWlVJUHdtL1FORTBSMFZX?=
 =?utf-8?B?aGdTUEpVNmo4cjdEU25ib091WkMvVnZWSGJHTnRIQ08vOWJ3SUYvd0loaCty?=
 =?utf-8?B?N25neUZpTlpBOXdEL1JTWk1KdEIxMi9HMXVOT3RvbVNyVU5SL3ZQeVNvb3Ey?=
 =?utf-8?B?U3p1cUN4ZG5taS9DSzA0U25URUh3R3VDNHdZOUVLakM0ejMydDJnajV1bnhh?=
 =?utf-8?Q?drTcU5t+L0A4pTZxT3ZVvgE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe835652-969f-4e86-684d-08d9afb9f019
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 02:18:57.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6aaJhzHyNSpaKe298QDydthzOFvFuZvHltFZO0ESA75uMBlpVNgsfOCnRrOVWVVVEaPtrz8nGX3LZCM9KXWXHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2988
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 JingWen" <JingWen.Chen2@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KSXQncyBiZXR0ZXIgdG8gbW92ZSAnY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDE5
MiknIGFmdGVyIElQX1ZFUlNJT04oMywgMCwgMTkyKT8NCg0KY2FzZSBJUF9WRVJTSU9OKDMsIDEs
IDEpOg0KY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDIpOg0KKyBjYXNlIElQX1ZFUlNJT04oMywgMCwg
MTkyKToNCglhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmNuX3YzXzBfaXBfYmxv
Y2spOw0KCWlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQ0KCQlhbWRncHVfZGV2aWNlX2lwX2Js
b2NrX2FkZChhZGV2LCAmanBlZ192M18wX2lwX2Jsb2NrKTsNCglicmVhazsNCg0KUmVnYXJkcywN
Ckd1Y2h1bg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQWxleCBEZXVjaGVy
IDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNCwg
MjAyMSAxMDoyMyBQTQ0KVG86IEppYW4sIEphbmUgPEphbmUuSmlhbkBhbWQuY29tPg0KQ2M6IERl
dWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IENoZW4sIEd1Y2h1
biA8R3VjaHVuLkNoZW5AYW1kLmNvbT47IENoZW4sIEppbmdXZW4gPEppbmdXZW4uQ2hlbjJAYW1k
LmNvbT47IGFtZC1nZnggbGlzdCA8YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+DQpTdWJq
ZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1L3NyaW92L3Zjbjogc2tpcCBpcCByZXZpc2lvbiBj
aGVjayBjYXNlIHRvIGlwIGluaXQgZm9yIFNJRU5OQV9DSUNITElEDQoNCk9uIFdlZCwgTm92IDI0
LCAyMDIxIGF0IDk6MjAgQU0gSmFuZSBKaWFuIDxKYW5lLkppYW5AYW1kLmNvbT4gd3JvdGU6DQo+
DQo+IFtXSFldDQo+IGZvciBzcmlvdiBvZGQjIHZmIHdpbGwgbW9kaWZ5IHZjbjAgZW5naW5lIGlw
IHJldmlzaW9uKGR1ZSB0byANCj4gbXVsdGltZWRpYSBiYW5kd2lkdGggZmVhdHVyZSksIHdoaWNo
IHdpbGwgYmUgbWlzbWF0Y2hlZCB3aXRoIG9yaWdpbmFsIA0KPiB2Y24wIHJldmlzaW9uDQo+DQo+
IFtIT1ddDQo+IGFkZCBuZXcgdmVyc2lvbiBjaGVjayBmb3IgdmNuMCBkaXNhYmxlZCByZXZpc2lv
bigzLCAwLCAxOTIpLCB0eXBpY2FsbHkgDQo+IG1vZGlmaWVkIHVuZGVyIHNyaW92IG1vZGUNCj4N
Cj4gU2lnbmVkLW9mZi1ieTogSmFuZSBKaWFuIDxKYW5lLkppYW5AYW1kLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NCg0KPiBDaGFu
Z2UtSWQ6IEkxYWNlMzJhY2JmM2ExM2MwYmFhYzk1ODUwOGRhMTMyNGVjMzg3YTU4DQo+IC0tLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jIHwgMSArDQo+
ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgICAgICAgfCAxICsNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgDQo+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGluZGV4IDUwMzk5NWM3ZmY2
Yy4uM2Y5YjdiMGJhYjNjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IEBAIC05MjMsNiArOTIzLDcgQEAgc3RhdGljIGludCBhbWRn
cHVfZGlzY292ZXJ5X3NldF9tbV9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kZ3B1X2RldmljZV9pcF9ibG9j
a19hZGQoYWRldiwgJmpwZWdfdjNfMF9pcF9ibG9jayk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDMsIDAsIDMzKToN
Cj4gKyAgICAgICAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigzLCAwLCAxOTIpOg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBhbWRncHVfZGV2aWNlX2lwX2Jsb2NrX2FkZChhZGV2LCAmdmNuX3Yz
XzBfaXBfYmxvY2spOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gICAgICAg
ICAgICAgICAgIGRlZmF1bHQ6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmNuLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3Zjbi5jDQo+IGluZGV4IDRmN2M3MDg0NTc4NS4uNTg1OTYxYzJmNWYyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jDQo+IEBAIC0xMzUsNiArMTM1LDcgQEAg
aW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4gICAg
ICAgICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTigzLCAwLCAwKToN
Cj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oMywgMCwgNjQpOg0KPiArICAgICAgIGNhc2UgSVBf
VkVSU0lPTigzLCAwLCAxOTIpOg0KPiAgICAgICAgICAgICAgICAgaWYgKGFkZXYtPmlwX3ZlcnNp
b25zW0dDX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMTAsIDMsIDApKQ0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBmd19uYW1lID0gRklSTVdBUkVfU0lFTk5BX0NJQ0hMSUQ7DQo+ICAgICAgICAg
ICAgICAgICBlbHNlDQo+IC0tDQo+IDIuMTcuMQ0KPg0K
