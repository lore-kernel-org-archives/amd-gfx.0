Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6E1C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 14:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FCE510EB00;
	Fri, 14 Oct 2022 14:27:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CD9910EB00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 14:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUQsinnDApSQc+DmB1HZvkV8CLCeVkGRoFbbJPQKPz31eLJK/Bw2vUYKnSzPcG9BNO1qY88Yo6maDHMrZqOFLNyKvw2DNXv+8l92ORPV+qjvrxYUgRKEsmU4LRCuc62PAiYYimr74qeA8tWOJRXqYPpCMhQQPsDAmFWxQUYaf9K9Z7ULBGOkoxQn+VWPYBLG9fmuV+kBvGvOyxxiqsdQtHtzUeGBeQ8SR4hCTP/iAhebuUaCTFpnpa7SU1f/kfJ8TR4Bq2J6q5Jvp46Tc58I1AcxM2PYgNTjAugiy9dp0L3o80mVBhfThvfGo7ZweIIEUF4zxU2Ji4bUisTWYI2yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNXSWUCvqNg8C1pSd/S2t7wesy924Lc/4Bq6RsjkTkM=;
 b=laYnxmIjQIrq/ZmKw+Xt8TQMmkO7MtxPPDZ2IvzwogClVxu3t/FwoA8OnEFjXGLwyGYS9Yk3Jc78e89wuhpGF3bckiLm/hEAJs/qrVFXZaarkdqb0l1uR+7/gq6wqgxSEweHoX6hGfLUCvqaVh97KedBO+PKzKd/QBUxQInAA8xh/qxanWaHTat4i2lJisPcId6Kx85dV0zKpKuD3Erw1avRvVASk/w0wNy/O04Xhh+faV3yVbfhKGm6+ipq8cY6kAVKpr/xlcIl2vmF9MRWltoRHtq7fSfo7K0cgix8cbMDiD+DS03pUeh8A8dhVNeRTaYEDwd7O4027RVbQp5xqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNXSWUCvqNg8C1pSd/S2t7wesy924Lc/4Bq6RsjkTkM=;
 b=IEVydpAkpcF/7jhZpdodnr97QdC+xoTruAPvqZbw3LRHpERmMWu8U4ajSfMSy+JP0M48g4ompU2AXo8UIYwoRvjrXpQ6D3txg1kSfgICFhcVOokOAxm5kgtQuj1ObnOZ+1t63eBxaa6sqfize4KIxGRtshpC4JHVGgyo6dZJb7o=
Received: from BL0PR12MB2532.namprd12.prod.outlook.com (2603:10b6:207:4a::20)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 14:27:35 +0000
Received: from BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::e7bd:5e50:4e73:85a5]) by BL0PR12MB2532.namprd12.prod.outlook.com
 ([fe80::e7bd:5e50:4e73:85a5%5]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 14:27:35 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: Guenter Roeck <linux@roeck-us.net>
Subject: RE: [PATCH] drm/amd/display: Fix vblank refcount in vrr transition
Thread-Topic: [PATCH] drm/amd/display: Fix vblank refcount in vrr transition
Thread-Index: AQHY39dsfZ4AWPrFe0CumLVjeQygmK4N8ekQ
Date: Fri, 14 Oct 2022 14:27:35 +0000
Message-ID: <BL0PR12MB2532EED10D577BC1481D2946ED249@BL0PR12MB2532.namprd12.prod.outlook.com>
References: <20221014141524.GA4063757@roeck-us.net>
In-Reply-To: <20221014141524.GA4063757@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=edaa877c-ef4a-4a6a-b1df-e2f6d9620707;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-14T14:25:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB2532:EE_|SN7PR12MB7323:EE_
x-ms-office365-filtering-correlation-id: c9761d46-bbf5-4ae7-5fa1-08daadf03d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szwzbxT6Kv48iZHCqqVngTxBk9qxxjZdmWS+8bDTQ6+2e6MEpP1T7P5K6GT+Ewgz7PtK/8rNVAa5IQc60elazAHlBSocHessbp+I2KL25e7uJos9jSP1ZMIARChuwf6xvt3a0PlQiyZWGjrsc75HLUxney34kulNu4JXG2qey2/MjfOI70bpEiUUNhER1HG2FWhumWk2OfHDRNECgh2kVBbrN7aa/gzVULT5M9JvqBCSs5PF5dJVHPgEEUBRrCjaMRBJcr1QYAZuJwcHH+T8UE0tsaULPYIYKO+gNnNnuGDKV6cT+FPL9T8FL+Mgz/b4Bs6F5P72YOlTlxsx9E5g4ofHS0xuWudFHbkrsCx7sotWOjfOYIuRjAWeErA0Pvy8kpEKb+j7WpuYwJ63fTMvTqdr10T8THLKA2fR3p31N3YZ4xOMUng3y86DFUcKewMKb9pagBEUaPN99YZ0zI07wfAtwObZ4whL8QlgBu0Mg0wCkkaFhlpwGvkYoFEGxAttwhAT7ZkPRCxMyiFHVHELM+FAI9VLG/feTbDSjM4ypnibO+6N9x3wl7aPZXsr4d4ZNvSPbFOj/wB1kscabCuagwvCZaH2EfwzcyeHpOHgj0RJZOKoKLLVlwdkZEGJt6UntoI4C/0g4hU4renpWMazf3wqJBuLSW3PK+Rli38lY944xgNmUVTHYCRtZX1sJAj+jzsxdjUGGpdHDNCD8rcBMyJmQqhq/TI5aLHjaHHKjrrFBWFtSpY5da2A8Wj5sb70HUkZxULaQHiFsvG8YHDiYw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2532.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(86362001)(33656002)(38100700002)(122000001)(38070700005)(2906002)(5660300002)(7696005)(4744005)(478600001)(9686003)(26005)(6506007)(186003)(55016003)(8676002)(66556008)(66446008)(64756008)(316002)(54906003)(6916009)(66476007)(4326008)(66946007)(76116006)(41300700001)(52536014)(8936002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l38eNBvUUuoK27F0Fjg2eJ36dcCAkzq0zJrRicAjKYgo/CMOnlhvHYGlAHei?=
 =?us-ascii?Q?JHBdQniqAxSR2UzTGxMXgxFIwSq54DnnjJQLbu/t1ObbCKi9lK+m0DwFvXJE?=
 =?us-ascii?Q?CE76jHsc01ZOgqIBK7evuj0ODcAEzJlqc/JrBbPY4zpuiJjvc6ngPIFtZ7gz?=
 =?us-ascii?Q?walDUdl2JCVLjZUtRTqYRf5E24Q9FHcs1dYDLrxmpIl2Wn1e9QWK0r29RuV6?=
 =?us-ascii?Q?sgvi7vyBVnse2HmtpQslcJDEvQGbKS9P2ZjmFeU+U+0CRwqljNZ2lpGgWUGf?=
 =?us-ascii?Q?4h1NAPsJnLAUCyIsqKyptmnR3sp/dUL+A0dkffu4GyinfvhZngFEq82CtpjH?=
 =?us-ascii?Q?CtB1PVNQQ2g5bn6QBcoivUuH4H1z09r2/+7dxw2GGhQPXstdh68GYMKH69oK?=
 =?us-ascii?Q?h5AAcFkqy9rF+6ixgktJy3CE+tp/DFZ6jzyuoFsW3shIOcbB6IOJxQuVVYyB?=
 =?us-ascii?Q?HK2vjeITb4JCB6uq6BUq77GsNuD2jYX8KWZOhTHAu6hVMM2QsiI4z0NdxfMs?=
 =?us-ascii?Q?MOdV5XAKk78K1ITMa73EouHpRpceUH6FJS4JJNdXrKirJC8Q8HAMwR53t9Kq?=
 =?us-ascii?Q?6ij+YXQ1R2rvAjBOoYcXUi40gUQ+ifkTlRSeg7Q4WqXLvc1VvAbP6Pf6C+kl?=
 =?us-ascii?Q?+BXNE3szFws6Bg9vTrcgy5Sjp2YfGzgtIcW5S+lxNdJ5gefd/FDjEDQtNl0a?=
 =?us-ascii?Q?kkXyyW4VxRncNKhmLBFHkHevmvaKXWBy2PlI2fcCLjFOC4Kkpk6Sl/niFBmv?=
 =?us-ascii?Q?yzFHd+2qfnpq3/ABWfv9xkTLfNz4ti+GoAAotcjBtH9tn+KxXkqRzp1E3eQW?=
 =?us-ascii?Q?RgRRdxhukwaRqBJ9bo5F//N63gXNnJQxiHI6LgIJ7bOF2YKNW7RUDlxvOvbi?=
 =?us-ascii?Q?nF5CchtBEHGf9ercl7bC7/sxzRJAjTYKitHpSNZ1l8k5CdpmH9O/D/nhNYRB?=
 =?us-ascii?Q?GV7XA0xxyXdhqLxIM7ars4eoYaq/x6ICMutQ1HuZd0LP7pfCi5i4mkhbSH9D?=
 =?us-ascii?Q?qVU+Xx77s4ucV3v5kR81mu7wGUUIy7F3lJws+DFwOKXfx33OT3VyPde67I7t?=
 =?us-ascii?Q?/MTDfkU9ank79BvkmNZdCvCn9gMrZpfQu3mnyldRECLjlG5Qsk7b8vD5FVO7?=
 =?us-ascii?Q?Vm2gCdh3LQikbdvPhdpv37KwTKgRqidxt9MELc/1LZeohvgkN/6hEDg/kINF?=
 =?us-ascii?Q?7Vz4dzuM7YcphTbRuLu//bmEyp8FjGby8j8nu65Zwttlo+G1kXtWTtgaFAG8?=
 =?us-ascii?Q?bXKEArnnqODGKnaIfF0y8R4zxOSjsnX42jdJWl3X7aR6bgKWRCBb+hZHvPZD?=
 =?us-ascii?Q?7zxxvJLl0aFgCPoeBlcbdROvpe+rfZftL3Co3SnoJodwItW8iMJ2sZOoCtS/?=
 =?us-ascii?Q?hwgD25Z/74Mqj3Ztdbdke2i2c4L9Dcs+RRmGaAgPaiN+FTLuUMBrz0kiImOp?=
 =?us-ascii?Q?Q+gaN3hq0mgAm0ney5HDC6n2ayNWgRCoggEPnTkKU+OWzHgEO4HbAvNrQgbn?=
 =?us-ascii?Q?978Y6qhYy1WpYAOiiNbjmv0oXIXiEFD9j+dYzXVBags2ifZmxSv44LHJzVm8?=
 =?us-ascii?Q?mXI1IYCoPUjJd3B4lA4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9761d46-bbf5-4ae7-5fa1-08daadf03d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 14:27:35.3461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32363N2umdZIRolJyHjSxaN9J1CJL+qmNM+9Z+//E8FPQ1SQ3+hnxaILVnVQdT9DyVBBV5JnpwHfSlERFpoPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> This patch results in a large number of compile errors if CONFIG_DEBUG_FS=
=3Dn. Reverting it fixes the problem.
>
> This is an architecture independent problem.
>
> Guenter

Oops, seem to be because at amdgpu_dm.c:8328 the } should be inside the #en=
dif not outside.

Yunxiang

