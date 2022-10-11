Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43A8C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 02:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3E910E779;
	Tue, 11 Oct 2022 02:07:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F21810E779
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 02:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAJVFak/E0y6CeI1Oh7NLk6QiaDJgqizi7G1HireHShCl4V68KG5mR22V8+ld/7N6gia6TXaElLN+aqVhNCHmIpgsk/NcvRL2gbx2g+ZaUBdJ27MY7k0RXyDpdD6IY1z1bA2ZqJkBM2b1Fu9rIiERkr616c2E4iVgdAi6HQMJi6Xz3gf5l/b+O8oHTl8ZWEc4D28tRRUorYE1Az13KkI0KeIwTkHjMiVeEPUxzr1lEwqns/cfEXLFuZxA95SBOJG1LW/9b8j/ZtqpHGlFVIBHGjZNwwLoioWlCTHaE7fKVeMaOws1aBqrFgPsTMNOIYs5IGYcQlObj3PGkC7rHsdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLGMMNe/KwxAb1gA2t3w/tBoeoZMOzra7llBbv6ABpE=;
 b=TTL7KsB7cM9WCfOv9mVnUU5EylkHlPILWQ65woTOa24bt6Zc7031JyrOn5qC6Zoq/Q8TQv4ILe/r0mVl1r7w9dpuC/gyZJU/1vq2ljSA+0xc17aL/AYATU9e8hmOCqHm2m9F4k3B5ImWFasqLDdLuRd+X+XoQrWNg/hcOKxayAILxmM+9tUixeEYgLa2Kqk8rE+5cn5FZWGV6/YxIVl8Fm1zeuqrW3RousBahVT+dWLPvKqvuCDR/WBvkbOVSKXBnrndJQ+vmU9cmnJE9UEQmtyFFL4/RsdT5GEwE/kqPeXYCdwLX+u5YKAyPjPqHS/b4WtDuD45gegNEZ4DgS6OJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLGMMNe/KwxAb1gA2t3w/tBoeoZMOzra7llBbv6ABpE=;
 b=gGinlza1wZ0YGyW8j+r0Vs8FzlZiTKT8gLAN8WD7bf+/JJC/pUQ3Y+3Dnj5t5xau+ZuaYFgTNeM1T+gAiB40zJBb3GdRGvQ9Mm1diKobU1re4Rbf/gsyS0MHN5PxIgZUBiP6Kr8Coxujmrw5nYui0SfBvIsexM44uCqylpvQM9A=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SA0PR12MB4560.namprd12.prod.outlook.com (2603:10b6:806:97::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.18; Tue, 11 Oct
 2022 02:07:32 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::877b:16ff:dd33:debe%7]) with mapi id 15.20.5709.018; Tue, 11 Oct 2022
 02:07:32 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: fix coding style issue for mca notifier
Thread-Topic: [PATCH 4/4] drm/amdgpu: fix coding style issue for mca notifier
Thread-Index: AQHY3FYrsP1u3SeFx02TMIFeXeq3QK4Ic6Fw
Date: Tue, 11 Oct 2022 02:07:32 +0000
Message-ID: <BN9PR12MB5257523F044D311FD207F210FC239@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221010031213.19258-1-tao.zhou1@amd.com>
 <20221010031213.19258-4-tao.zhou1@amd.com>
In-Reply-To: <20221010031213.19258-4-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SA0PR12MB4560:EE_
x-ms-office365-filtering-correlation-id: 544937ec-6402-491a-ade7-08daab2d5bc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tq/k/oNebMg2xstVRUP6y7aCmSvz76mdYYrysehD9pKZMz/WQ+gegbrjLW3xzUuC+1rTN/cCAJJVqYaFLRrT6WPq0JLMFiZmxTH4s5VAFbxuhdMk5wXQ3rvZ0jY/ZPiQMKuvanJ1sO+06Hc7naNHG0ABI2gCXhgH5y+aG3a5JK2kUyUFTu/ayX0ieT2ok90AFk5OKy9Pp0y7+uLVlSqg5mN2NPIBQ3qr6kRTQgGb2lN7k20m/AsFG2FHhZWrCSTTGT0tH1nSMMuFcpdY8L4AY5QXNuGoi8O8ZQO/+gnQ8wMW6MkpWepyxH1rh6Tk24x8hqZpl4257+MCp6llV2jyTZz+U1g/aT3IIlqez4P517pR0+xZYzxAT4DaoaMfaxlNZny0yr6FcdgxPh+hkvhbYxkTt2tB5eZzSgG5QOoWbJz9ZbjYcQIMVFmt6TyP4AJuE7bf6D3fl1z5tyWYaBw2mAyVqMs5FOWReqhYePpLSE4ygTLhR3FAvvbReJyyx8gGoVGoarWdHbJ6c2eYQOCZBIJTDfteg0REh3xZdPCHTeV2OS1z/ajJNpjM5XEdbATjcbs828O7oEfT4udVEzEeIJsGnLPKsHCi7fLTGBZapXvkbGuUQ9emNITm9ElV05Z7HQ55UvnrXM8nbQ4dlxAa26mw0h8p+rj5nT6wHvELgvpzbo14YGozXELvjKchW/CvdecVFlnMjAtGdao0HJJfYv4oHxsW47Vw/LzCaIU0MqqxGmR6J4v3psB5xWc9t1Lc7KssIUjYljoZLRhDhfae+Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(9686003)(38070700005)(110136005)(316002)(6636002)(55016003)(478600001)(71200400001)(122000001)(38100700002)(33656002)(86362001)(66476007)(6506007)(83380400001)(186003)(7696005)(53546011)(26005)(66556008)(8676002)(64756008)(66446008)(52536014)(8936002)(5660300002)(66946007)(41300700001)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1wyQIyv/64LSLSm10bztfcxQ5oOaIH67BtObfw4fORvVe9GJMjjpX2aohSQT?=
 =?us-ascii?Q?upXfdkrlwk+39NsipTgYpPtfZG3rXiBS+8b52cMkaaO3rhw0Pvr936PNpabx?=
 =?us-ascii?Q?h/xrFZ4HZcZaZuA5YRhvquZzZo85sRlZOZixCd1X+m51f0MptlaHZ5dywQAZ?=
 =?us-ascii?Q?oblWL/PG7CxJHD744F9qiBbvYw4rNSrs7ILZ9MR47nF66g2Pwj9xpgRwmv6q?=
 =?us-ascii?Q?AEDoqNOfyrovHWPTHncwVYblk0ghc3UlZ9UnjgkdzU1dxvHUN9wnjYvLxw70?=
 =?us-ascii?Q?CQ+og5V93D6y6ogDVCK6bvbjqDBB5mJBZvyUyDbjOSpmWnJaiZEkymAfTfkZ?=
 =?us-ascii?Q?jyQIGeuAEH+85zzHQCO6btEQcYYans1LilBUyGWs8W9qw5lLwLLITp0O2gDS?=
 =?us-ascii?Q?I+9I7TJSl+yY+NJ8Arpq74+D7g7GL4jeAiXbJKzlxXQ+eu1mlSL6FLviivij?=
 =?us-ascii?Q?qSfXhyLmYUrYUPq1A+gLxNacHnVeht3DWM10TOEFwGwH1v8LxLrMf1/wPJGi?=
 =?us-ascii?Q?k+/lQCtCxa0nxytOxlNtqq+y/pehaDohlCqioWAjh94Z5a1+lC74Kg5CJvkH?=
 =?us-ascii?Q?fkFhw/S1tUPSWOwznJSQ8sVoQuhqaZoZ1Ibk4V4zo1Okej7T4O1G6hPYiXNC?=
 =?us-ascii?Q?uQWxqmZ5FWxTkEfqezvJ7M0gbFqkTx+qH901vD9DFgnE1RgLrEwnuoP2zF6/?=
 =?us-ascii?Q?3Vhyv4oSQ2jfpkIR2Mk9lTOuMrPcb7XPZ9ifK0ZjWEw91fP1haDqCBD3CyOq?=
 =?us-ascii?Q?nwTeRxntiwaFzlBy+9w5AIVoEX1r8rBezITT6VUSiXXC77ycTz0Y8RJ2BoVe?=
 =?us-ascii?Q?vCJWg+avJ1siA2u7OHXiqvSc+Yk5Xdnf1biXTejjk3lLiIFrqNCzYIr6UDoB?=
 =?us-ascii?Q?GU1IBrkmuiOSaz7jBPYz85B5rAUR8hbM286twpZk+tiJBoCtv5YYBr4a6zYS?=
 =?us-ascii?Q?1HaMepscjoSEjxHklTDnaKu+ZbineoELTRupZ3uVW69/spw0l3On3vh4EQVT?=
 =?us-ascii?Q?a4oDXOMYCmFsR2H9vHr1hUEZVPBsKSefak9SmMEIxa+wCspqBijC7puS8Kch?=
 =?us-ascii?Q?BHE+X9O2Fxqsnmk7zcfbZYsBorU7T4i5hGDgkHYwWh08Ybx13U5Y25DhoLtS?=
 =?us-ascii?Q?aGIy1hfahuAqeUFwXRYtcDasyBG4T8R7zVxzf0ulwIFTSE3x/IX3/gikFmpl?=
 =?us-ascii?Q?/ld5wDEP6KsaoouD3Wga4za/Mq8IaZ2Ly0BBXUbXLD7iRSvAO4N4r1Uuvra4?=
 =?us-ascii?Q?J2e6o5TlyoqYwVhpkuvBdbskUUyil4G5kcF4ePmuoJiTeFHlhy0b2TIk3Fe7?=
 =?us-ascii?Q?/Cni/DcY/+URNpYjbeOfO4/SP8OBUI9CTPpZLH/MruZYhuhP6dDLjI+XtcxF?=
 =?us-ascii?Q?6MrIFmLStyzg4YB3TYXlT2CBV+GDpdDpiZpOcEE7UqSui+lONbKjo8rCS0hX?=
 =?us-ascii?Q?L2ftz+kA2GuHYoFXMGFJyt1LQ2UOSEd9oWrGpjbQS8G8GARUxIb1vFtFNeoK?=
 =?us-ascii?Q?LJyu1LpfBn8XXOTJDoT/hKhOO3XdSwYIF+xVOemvICyVxn6ceSY/7rXCjiZY?=
 =?us-ascii?Q?8/XRZ+5ouCGIlvIhS0DgOiusO4Y9yKxLo2219y0a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544937ec-6402-491a-ade7-08daab2d5bc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 02:07:32.7150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0CmS0wsNhN2pbSBg5EJiniyyq84GtVy4WQdSh7OObIhwfcENPRq+cqnQDcwdc6ReEhv6Ts/Y03shxSeHUEGtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4560
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Monday, October 10, 2022 11:12
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; L=
i, Candice <Candice.Li@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: fix coding style issue for mca notifier

Fix some issues found by checkpatch script.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index c2f9970e851c..2dad7aa9a03b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2877,9 +2877,9 @@ static int amdgpu_bad_page_notifier(struct notifier_b=
lock *nb,
 	err_data.err_addr =3D
 		kcalloc(adev->umc.max_ras_err_cnt_per_query,
 			sizeof(struct eeprom_table_record), GFP_KERNEL);
-	if(!err_data.err_addr) {
-		dev_warn(adev->dev, "Failed to alloc memory for "
-				"umc error address record in mca notifier!\n");
+	if (!err_data.err_addr) {
+		dev_warn(adev->dev,
+			"Failed to alloc memory for umc error record in mca notifier!\n");
 		return NOTIFY_DONE;
 	}
=20
--=20
2.35.1

