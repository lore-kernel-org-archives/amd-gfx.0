Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56390C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Jan 2022 04:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A715710E289;
	Sat, 29 Jan 2022 04:01:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C138A10E289
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Jan 2022 04:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZMdtdI7Q2WTNNF5qqXDmnv/FIOPJ3mC3pV5fajFtTYHInuwELpCZ4/0JlgjKWObTgrhDou6DGLHTxE0tyAIw0kDaOGpRXXC/aQyZ7seYxw/qr9zOk6C/91svDvoJgwyBbo3gGP3vPeDkxXHuEn/ww5GerTqU5hS1yRfnxrd6RhpAh5fH5nP6gq1C/rhy070V99M3KWHwyXEVhrmyJdLjvlzuCl0hmF6pM5X0e1Z0A+4OFzxlDJbuiiXptxUsk2bxL4dRcdoyV8G15yR7Sj5HbKTSbN5xPAyVoyVcWUMN+ZoBBbTLAMrBXR6nicIHFl+NoK0z/6SRJIWVqU2onysng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfTh+v6sS5XlPGiHL6WITYNB7QACeYzf+99eX4ccs1M=;
 b=FJluKdpR7t6RmJgjTXeC6XY/H1S6hnO7YWEzK/zsDaknhlEsBaCs+F2MSYSY9Dl5AmzEmTPW9ay0srbEImlyFXAdxPPWtclnyNsMt2iQ6M7nG9TpCCfdlu/u/8bDdj3i6Y7CTsgaJRBx7C00z2mQ+qiJJWzecjwrX5ZTtuhA9QKCR1xTgjYlgAX7JoieGdC36Xv9jctZvwfk11dSt4LNjbNng/AIjS3VHWPPGgYj9WX97TiFGwuh35/l7PVEwCeM7ApTXQwN77vdXL+7nDpMyHcM0QKEaR0GZfPnWAyENmZU4AxyAE/zh5oc8efGkRPyP2fVv7QgvBGr5z3OanHMbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfTh+v6sS5XlPGiHL6WITYNB7QACeYzf+99eX4ccs1M=;
 b=MOuln3fULyqQXIrDZ0uFVh6PFSuIlhNmwWauCu8Bh9TV00/50C2j4OCB0mSLq1nF4hXh8q7W/4StVxH8s+v6ckqEK/aS2VowUTdJj6iSNZILMPrRRFBqRA9qTPCc9mHdnL16magSMgqlGEmxB70jaIX46V9IbrDVCbNUX95a1vM=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB5567.namprd12.prod.outlook.com (2603:10b6:5:1ba::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.18; Sat, 29 Jan 2022 04:01:34 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::a4:23f1:1652:90c%4]) with mapi id 15.20.4930.019; Sat, 29 Jan 2022
 04:01:34 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Topic: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop
Thread-Index: AQHYFMPV6LTZ3BlJqkiSK/A8Y1eylqx5X5Vg
Date: Sat, 29 Jan 2022 04:01:34 +0000
Message-ID: <DM5PR12MB2469E1D230F79516248A86DCF1239@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220129035311.3734878-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-29T04:01:27Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d5453a3e-4706-4ab1-a616-6bd697cf7376;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-29T04:01:30Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a7050f87-ee95-4dd7-8571-8696a64dca82
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa22fbfa-b95a-462c-78bb-08d9e2dc0a6e
x-ms-traffictypediagnostic: DM6PR12MB5567:EE_
x-microsoft-antispam-prvs: <DM6PR12MB556728E5087279CFF4DA5DCFF1239@DM6PR12MB5567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1nxoiCouSZiOmGFAmp0qfDGsqKjAXE5c3XHBItezri+c9fJUNfHJEBY1I3YTrdjZOBfFFBFEJ79Wq1O28GR1qNWIoNpu/NkSupbW5kc1JIMG9UGop5AQAm3jKJJBDlTBVPjzQHEGVlyuo4aHV/BuAKpNW95slFZg6Ozf5CAgh6oUXwpcu10WE4W53A1xLulyUCp5qkNy4sAuK9vVWpVi6lYET+M1GrRfQz/xgs33IcPYwBhvdId0GJbK3uWtNWUEwV6GcU77MMAtkubCaAbkFztigKu4XV7ZPQ4nTGEptCphwUhHtepDh3uOKrF8t7RcReXSUm/jtcIZ6u5VcalRKXhL9QOuhguyBX0MXcwYP8KF3KBStqRu6winRdWVSuCXIQVweIYHnHv7V+go6b1MKIyDxhvjVc0vYZFBksKY2IyJgcs4C2K2CHuOs/OnTSr1qq18PHGLJPukDq6wEqnmMp3f9zF8arpauHk831lGB9YvDO9uL7GrHo6K8R+5AsxWvRvFOsyt7oASsB+F1ITKANbxrP75NeGk3s3ETGB6sQe2Dn+x1KjmMjXfuCH6ubXyfttEONXzAtj6+R6FvXvtCY3kPqddZL/JCpYO7v4zijyFjeW/S5eoBeK0lRww+A/xRurbBqEmoHolobk/mdj26s4nJYWCrNmbiech+jKXgW7uhwXKeViNGLkQr0Su3ctPDBAMKrxe3na7pbw62B2hA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(76116006)(66556008)(8936002)(8676002)(4326008)(64756008)(66446008)(66476007)(66946007)(86362001)(316002)(5660300002)(110136005)(508600001)(38070700005)(33656002)(71200400001)(54906003)(52536014)(38100700002)(55016003)(122000001)(53546011)(83380400001)(186003)(2906002)(7696005)(6506007)(9686003)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CY8ZPqdwR3TwDIpVF67MwgVsQLTXYi//W4GZdfONwbUFphfxjONTo9QB4qt3?=
 =?us-ascii?Q?9nmAG7wNUtiEPcCUvsbfQv1mdx0zT6SUeF5b5cSNzrcO5R71/Ze/Na+ZsZyu?=
 =?us-ascii?Q?WSATfKUdNTLwYW3NBq8DNjf3aX4TALSvHkU8feACKfe5tOrle+DmErIFrUKB?=
 =?us-ascii?Q?N1YqGRAI95vuzhotv8BUPqD9xWSxze1BdY/jiOaaZ7z4JlRYEhNX0mQOc5zY?=
 =?us-ascii?Q?oOeJjf0F6sydjqmleplMxIlgJ50OJpKcxVI43mBMoJhdIjb3G9WZR1vJa8Li?=
 =?us-ascii?Q?hiwB8cR9AqTwkdy1if5j1JZ7FbKdvcvgDY5vbBs7JjyT+jKlXE2Yq+VUF/PV?=
 =?us-ascii?Q?Hk2GaApfF8ghsjV0oHR6PefmbBf/+qYAHHzLdA/NUASrAXbaNEizwpe6e40c?=
 =?us-ascii?Q?/dlUCdumI4TEznY9D0QxdZBQmEMi79pHAZmSjqcqFCcWbX861tXNT2jorvYV?=
 =?us-ascii?Q?oAkuB1SG001x9Ay9mHw4WsT3tbbEA+0c8pksMwslAigCYCEHWRczplCeHdFZ?=
 =?us-ascii?Q?99pXXDVOFtqo9edngFvqj6aJD7V3isGe4vWA17FiFF9BNxJJZ/nnsLjiJfkC?=
 =?us-ascii?Q?V4BDLAZXvHdKYC18ptL45PQ+NJMxAasYFocP4UNeBVzQBql7xrZIa4LICKP6?=
 =?us-ascii?Q?nVqKT7qm/UhkMY1ZSwwMmvtcR/Kl/bq5xkrX1qjaSJDC+yXOZ9Xj1XR2jPGB?=
 =?us-ascii?Q?wdiE7VhJ8xNDIu8gdVoxraLmSeMFeqX9G0QgvZZeRlTjXwC/ywQXitfkNLYF?=
 =?us-ascii?Q?SEzeB31uD5Sm7qGHSrRo+886kYiyB+Cu5NqDVaYD+lQD/JDtahpbJXYPXq3r?=
 =?us-ascii?Q?ywybNxqDEPqcsUuTFeXWIWfdkxL4B4zNCJwNSBrKkswZaZ3w2YAfd2mVi05B?=
 =?us-ascii?Q?iJaPqWiN20pBoMuNTuBMk38SoYRGeyVBy+YESNZHD+MfV9QRRuRLCdtgKE50?=
 =?us-ascii?Q?EiX0CcTUrrqJxgXsrCDlqIJu0RHwt76QhxiOTC8WUs7X5p5jr9SExYX6Gfk/?=
 =?us-ascii?Q?DX6Orem7DqI06oSF2FaP56E63hSZUxJaDQHk9sww1hFLaIZkZnRhcZAjAP5x?=
 =?us-ascii?Q?hZ8lSsWOwV50tZj/KGPmPI40kmaH7uqcfyxGP5SdB3rNl+kIK2R9k9r8RV1y?=
 =?us-ascii?Q?KmxtKrUkHScl9/WDxZc5mPo5VVLRKwng0Yw6TV3KK1js+fG8StypIrG0akck?=
 =?us-ascii?Q?si2KjIwQ7/+eSzVmmHhUCdP5ctVnTljBY1VfgutvyBs/v34eNW3PBxaOI6M3?=
 =?us-ascii?Q?ri+qas1chEEDsTl7OnQV6jjvtKeevMWdh4DRpLi6NJdLbLgT7oO4OChvYnHz?=
 =?us-ascii?Q?OAZmRT/B7u7lrCz6pn2VQnmkrP1Th1293sVZPz6WvnUAMJ9gSfUSUkqG+DGf?=
 =?us-ascii?Q?SjZr8DfSSzf6SYGi55UcatxrmTSjBoq+iHMtK0/k2UeLBDsAgYv1Zn+zB3fG?=
 =?us-ascii?Q?1TsbISlYN5D449hbAZlEdLPctaRSkJCDubpZINdyPkGzBhayxzFXA4daMjjL?=
 =?us-ascii?Q?dYYjpjvTR8AYkxR4IpyOhuaNPshYwvAG8hAdm1hdEVtYDtErjNk04wwAswJK?=
 =?us-ascii?Q?SHGmbz5l8qd4JmkYkevfJzSN09uU7jEwgn+1TQV1lmpLtarJ37MlfJDLwaYm?=
 =?us-ascii?Q?2r7oSCK2pU+RvySxmwWdJMxCCwoI4d1UtjbFGRQ/RPGUOJL9Kg/TH8Os8ntX?=
 =?us-ascii?Q?6UZRjuB19pWN6vix6Q0Lm88eyXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa22fbfa-b95a-462c-78bb-08d9e2dc0a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 04:01:34.1268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwgSYunXV+Nenyd1DuXzAEXugWKYEAmYGwz5QGA3NYTKXE+ReAxXUNv5SkBU2fKqz1EetSo9spTC+ctGbcXLpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5567
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Please add a Fixes tag, as it should fix a regression from former patch.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Saturday, January 29, 2022 11:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Add judgement to avoid infinite loop

1. The infinite loop causing soft lock occurs on multiple amdgpu cards
   supporting ras feature.
2. This a workaround patch. It is valid for multiple amdgpu cards of the
   same type.
3. The root cause is that each GPU card device has a separate .ras_list
   link header, but the instance and linked list node of each ras block
   are unique. When each device is initialized, each ras instance will
   repeatedly add link node to the device every time. In this way, only
   the .ras_list of the last initialized device is completely correct.
   the .ras_list->prev and .ras_list->next of the device initialzied
   before can still point to the correct ras instance, but the prev
   pointer and next pointer of the pointed ras instance both point to
   the last initialized device's .ras_ list instead of the beginning
   .ras_ list. When using list_for_each_entry_safe searches for
   non-existent Ras nodes on devices other than the last device, the
   last ras instance next pointer cannot always be equal to the
   beginning .ras_list, so that the loop cannot be terminated, the
   program enters a infinite loop.
 BTW: Since the data and initialization process of each card are the same,
      the link list between ras instances will not be destroyed every time
      the device is initialized.
 4. The soft locked logs are as follows:
[  262.165690] CPU: 93 PID: 758 Comm: kworker/93:1 Tainted: G           OE =
    5.13.0-27-generic #29~20.04.1-Ubuntu
[  262.165695] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIOS =
T20200717143848 07/17/2020 [  262.165698] Workqueue: events amdgpu_ras_do_r=
ecovery [amdgpu] [  262.165980] RIP: 0010:amdgpu_ras_get_ras_block+0x86/0xd=
0 [amdgpu] [  262.166239] Code: 68 d8 4c 8d 71 d8 48 39 c3 74 54 49 8b 45 3=
8 48 85 c0 74 32 44 89 fa 44 89 e6 4c 89 ef e8 82 e4 9b dc 85 c0 74 3c 49 8=
b 46 28 <49> 8d 56 28 4d 89 f5 48 83 e8 28 48 39 d3 74 25 49 89 c6 49 8b 45=
 [  262.166243] RSP: 0018:ffffac908fa87d80 EFLAGS: 00000202 [  262.166247] =
RAX: ffffffffc1394248 RBX: ffff91e4ab8d6e20 RCX: ffffffffc1394248 [  262.16=
6249] RDX: ffff91e4aa356e20 RSI: 000000000000000e RDI: ffff91e4ab8c0000 [  =
262.166252] RBP: ffffac908fa87da8 R08: 0000000000000007 R09: 00000000000000=
01 [  262.166254] R10: ffff91e4930b64ec R11: 0000000000000000 R12: 00000000=
0000000e [  262.166256] R13: ffff91e4aa356df8 R14: ffffffffc1394320 R15: 00=
00000000000003 [  262.166258] FS:  0000000000000000(0000) GS:ffff92238fb400=
00(0000) knlGS:0000000000000000 [  262.166261] CS:  0010 DS: 0000 ES: 0000 =
CR0: 0000000080050033 [  262.166264] CR2: 00000001004865d0 CR3: 000000406d7=
96000 CR4: 0000000000350ee0 [  262.166267] Call Trace:
[  262.166272]  amdgpu_ras_do_recovery+0x130/0x290 [amdgpu] [  262.166529] =
 ? psi_task_switch+0xd2/0x250 [  262.166537]  ? __switch_to+0x11d/0x460 [  =
262.166542]  ? __switch_to_asm+0x36/0x70 [  262.166549]  process_one_work+0=
x220/0x3c0 [  262.166556]  worker_thread+0x4d/0x3f0 [  262.166560]  ? proce=
ss_one_work+0x3c0/0x3c0 [  262.166563]  kthread+0x12b/0x150 [  262.166568] =
 ? set_kthread_struct+0x40/0x40 [  262.166571]  ret_from_fork+0x22/0x30

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index d4e07d0acb66..3d533ef0783d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -884,6 +884,7 @@ static int amdgpu_ras_block_match_default(struct amdgpu=
_ras_block_object *block_  static struct amdgpu_ras_block_object *amdgpu_ra=
s_get_ras_block(struct amdgpu_device *adev,
 					enum amdgpu_ras_block block, uint32_t sub_block_index)  {
+	int loop_cnt =3D 0;
 	struct amdgpu_ras_block_object *obj, *tmp;
=20
 	if (block >=3D AMDGPU_RAS_BLOCK__LAST)
@@ -900,6 +901,9 @@ static struct amdgpu_ras_block_object *amdgpu_ras_get_r=
as_block(struct amdgpu_de
 			if (amdgpu_ras_block_match_default(obj, block) =3D=3D 0)
 				return obj;
 		}
+
+		if (++loop_cnt >=3D AMDGPU_RAS_BLOCK__LAST)
+			break;
 	}
=20
 	return NULL;
--
2.25.1
