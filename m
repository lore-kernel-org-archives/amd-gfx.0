Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9B4C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 17:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 518E010E0A5;
	Wed, 12 Feb 2025 17:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwF7Rv6k";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FCC10E0A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 17:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UC9NZYsOKjMJyhHlFXxgmKcKWVXViDI8nVIBUbLdESM/fSrCWwDGhr8YlY4xHQ5rUgL87CPPohyL64W70OiwgphV+LcRRwJJ5myH2tfXDx57aN+075PMJUVAAsEN2tMgJwxh1v8y+LjI8IeRT9Len8xzDyFtMqkg8cIzKH1Hn4h5oBJPevZeWjNbaNAEKMnVnoqYowsLWb0ag1vzW6n+8bnVyNwuDG4e92AtQOjzZhz6pBhzUnBCWjEwS4orQrnsIV0BV50KR1NFn+dxLOWxjQKJBnGNPNV3xD0NfVeZPsJT2CpVcl7jdFixchIBXZnhseazwKEwLkccTNZUvf/dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmFM9ExfWId5g8WrRN35yyR4YMigU7joPXBgdNo//sA=;
 b=lOxwSewWyD85Pb2QnBRwmGeGmFajTti+zq9M4tSLYTVBa/rHJDgoRk0gBvtxoHs1xkgsUcnHi/wDxGOTzOiddUM5SwrKJv19s7i0UAUZ4vwhElN0TTFuPOn7VqhQrBBoszhsMtVf24/MOf42yBeGrwhGG4Z+bn6tNkAGHapCqjqu+DEkkLrinKquGMqotZoIlzJHf0XTbEw+YWvVg68evwyEXOzWHfcMvFmkhvAhWAJREHe/4/AJSbDTXmwdzOuIpYPaoe4ytz/ytv5BCa5HoQwrE1int1vAaR7k/UyL00ZJeHEvoNKi/+41YqobCUQgJx+RM1bWasl8wohGlhFnqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmFM9ExfWId5g8WrRN35yyR4YMigU7joPXBgdNo//sA=;
 b=WwF7Rv6kCWJ5ZfXeQsoxqOrDw0i1brNI8tZakXJsVbWx8yljm8Ec1fPUu1Ba/SrSyLN8YsO8WN5VYZHSTqKiusl5ln8g4nSBYWq+FIi/4sqzJ+mliK8ZEFuG/YUns1CvrO0jkSwxZYaVpqJKdDvjCBDVbaZmv/wwgvHNfHRo8hg=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by IA0PR12MB8205.namprd12.prod.outlook.com (2603:10b6:208:400::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Wed, 12 Feb
 2025 17:58:35 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::b62f:95b3:3fa5:d345%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:58:35 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Topic: [PATCH v2] drm/amdkfd: Ignored various return code
Thread-Index: AQHbWtzVwZL9Z8SLhUG/oG7mXIfKgrL/DyMAgAACV4CAAAxygIAACJ+AgEUSe0A=
Date: Wed, 12 Feb 2025 17:58:35 +0000
Message-ID: <SJ0PR12MB81384BBB697C2D8CB991F3FFF5FC2@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20241230170223.574547-1-Andrew.Martin@amd.com>
 <BL1PR12MB5898B926B9A6FFF7D66E306285092@BL1PR12MB5898.namprd12.prod.outlook.com>
 <SJ0PR12MB8138C3B22C551491933825A2F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
 <BL1PR12MB5898C219584BBCB336BD214E85092@BL1PR12MB5898.namprd12.prod.outlook.com>
 <SJ0PR12MB8138722885AD1BB9C0BEE7E8F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
In-Reply-To: <SJ0PR12MB8138722885AD1BB9C0BEE7E8F5092@SJ0PR12MB8138.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=875e0fdb-fd47-4e84-b2c6-d64d1f1c1207;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-12-30T17:35:23Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|IA0PR12MB8205:EE_
x-ms-office365-filtering-correlation-id: dcc8ac71-fc4e-4533-52c5-08dd4b8edf2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ufCGNx6wdgXE3JFhFVo+SF6HBLtcnRSNYLGkTGTsqV3IjRZAukVSeQseFfuP?=
 =?us-ascii?Q?znTxC7wBl5Tf9V5J3CWFobZVnKRB0JokZWapZqV5xZdmooSxoTFDaMfAPaJu?=
 =?us-ascii?Q?LQp6nAv+aw2wf8kbiuMQAYvisxXW4qVj1VzTA4gd2PAynfFHDD4mxyynWOe6?=
 =?us-ascii?Q?/XHyPM2WakN+7W5wAA5qDDD2BM+zY8SoWOFFVjLK75qJY04eD/rsAR2mFcbo?=
 =?us-ascii?Q?MGIfB9A+7dtpM0sXrJ7vvyRP8pzgnU+AjYd8Q/knCUxl4LBrlZ1TMWdaPklp?=
 =?us-ascii?Q?BPZMcagrswoMWAYu2qGmqUCgEEYRudZrctj2T1r7SjoM52JYx3aGX0gsoHBM?=
 =?us-ascii?Q?sY4KfkW2tfq6vKoKYw2k/+MPSY1ac/u2wcZIW9N1rE53HO66QVvg9UXhSS2A?=
 =?us-ascii?Q?p9qXztwA+HZ9Do6EU9jiCtz9FQU1mrWzwVhoA7b3ES26bebDDC8V9KnefIO8?=
 =?us-ascii?Q?MNiOnEPXHcyanvkALgiGTRR34PDZiLVYjYdRsEdhADGILR8XR+pCJMoB2HCs?=
 =?us-ascii?Q?oElLQLPLUkFwvWJtlTZDDLEqjI+iSyeZR5KGSvUiXyfsqqKoW8dyrzr90895?=
 =?us-ascii?Q?23tBQluhU+jGzVzJ98kOkKIy+qR/yH85NO0Dya3PzupbRY7dn1SHC5OMy2f3?=
 =?us-ascii?Q?BiYrzr4IyHoAT1jLVrCUTDwPx6r9xOXOf0uAtlpsRCFRt/W6SI+wVcmmCMFR?=
 =?us-ascii?Q?ov6pvFtcgFmznlyBtKB/qc5jDWgH9VtZmbFQg6FsLkbarHwZC+6jkG5wRqLS?=
 =?us-ascii?Q?dSruVcbQ+Uic1WeYT7t9Gl19p+Onc5kLKgqeXjwmDMTHz7MYXF6wtTwom3mJ?=
 =?us-ascii?Q?vkCQhftRzscNxqUNTTfAPdp25dxo1ltCHcwpsiavY6ShR6+EvsYUn/+MDssp?=
 =?us-ascii?Q?wTxd3BJm1NoNdRlkbbjgbNNKVNgd/5QZKlETux/yg3Ap+cvH7f4xQWmuoLHz?=
 =?us-ascii?Q?vpdaFbneXbZ7eZa2y+i5C/znSdb9/SzsMsxBqtTGkJVqgtxG0hLP0exCfTNd?=
 =?us-ascii?Q?5iUV19bK+Y056RWAam63TR7kJp8aEX5CslegCPmmd2WFMCYYxLvZyt+UOh7V?=
 =?us-ascii?Q?vMA2+SCicdR8B+n0QBTggpxEsrgf/G1GMQTyqAs26OTu9Zd81RXexPicXdUe?=
 =?us-ascii?Q?lOfqG80GwcTQkjqJcMG8bMyXW86iB0R/vdPHnPNJkXIGzc3LfJKLEaNu9Muq?=
 =?us-ascii?Q?VxA/oCvuHRU3/vClswGNos9uDogf1MTgyxbBUwPXIEqyGSJrG5ea/PSV4iK6?=
 =?us-ascii?Q?7Q3weuPAbcr+YDJOdB5bbWCbDr836sKPXUwzWaXrK92vnwg+8DmMdC+N8gpd?=
 =?us-ascii?Q?dsmttr+2Mp6yqppFp7lMrbruVc8V9hOWxvT1owR0MLmIGuZrpoBV31r9232v?=
 =?us-ascii?Q?a9SYz8HLjH6V6vAi4TUVBVzp8b2+tggeP7bMDv4K3eUiooOPykrCFvU8bXEn?=
 =?us-ascii?Q?Dg05AZv/WAcWjB9Xl6D8qw3Tw4FQLYmk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L0382UtvZL6LhZ5zpCdeqVVZfkC2/sx1UV0lKFEMs+CFpJVFD4xDP4vN8bEO?=
 =?us-ascii?Q?dYdPNayItS2c96MoR8+3u6JCzEn+TUNO573AwX5aDaQC8BXo2ANosVkHdkbp?=
 =?us-ascii?Q?bHA9kLoorHbwEYQOIvFvENOvbdiO9Smc3cmXL2P4EzrYcaHFdjweMtS+NBGv?=
 =?us-ascii?Q?uPNAHsV9QpFyM4YJFqz81rowRRvebJCHrhGhiAPcuoIqL80vev0Dk5AFrVVh?=
 =?us-ascii?Q?DNHWJjxFR3wrJpXRcXnZT+QMJEhfeqjeuBBD0j7RICr8snjaWtx7FOnlCqw7?=
 =?us-ascii?Q?IFyovY7q+pWqofPYAcEvkitmW3UiAGv+RuxDs4xC1Ae5IRumGRjadFC+z44H?=
 =?us-ascii?Q?4FANFaIH29qjLh3OgZDVDaZHDSY4sVVuWVy5eNNHgrHaMN8zFsnqUqC8dzio?=
 =?us-ascii?Q?P9ZeoX3ZqDWp+R0uMP7XuMCD2ttPWl3tjut7Fjc9huHJT1dfw3G08e3uWjrn?=
 =?us-ascii?Q?UsPwcqdw7dX27NjmRoRDf00/PjsHmyLf6phCYder5HIMqR/WsphU0L6rTght?=
 =?us-ascii?Q?6YifzOzCq/RMvtssTyzoVIUbRmIidOTvoq82cpR1D4OwcGb/SicsxLSpa+CV?=
 =?us-ascii?Q?h4jFeYL7qVxBZRG26b6RrOA3k1A9SZKqmH56YWqeqxYVDaoKneRpZIpD9id+?=
 =?us-ascii?Q?GMRypeS+Ry1HxEAVCeA5yj2EKSeytjhI+77pgiIx5VH4rNsMAY5pSmjeSWgR?=
 =?us-ascii?Q?b7qYiiuKljCStioM3SY5l32cdV57laH9ySayShmJIM1u59Taw9/cPIzgKOM9?=
 =?us-ascii?Q?O7cN57GHBM2Agd92+lUvrEnwVpTRFVTEqSPvToVYOXvPSClJLYA4tMZcZ+I1?=
 =?us-ascii?Q?BPBq0KVBnkG9fuRNBebdbtmnqhFvDVDky6R5rpqKOLU7CUvJqmurm+b7ZjSy?=
 =?us-ascii?Q?88QRioLc/A9BTDSdJm1MOkL9IK5Tpg7+dRYQUgyTau2UkuGdTF8pum/bM7mk?=
 =?us-ascii?Q?WhgEmQGregxdv3XGpIl06GPLiot7RNX3njoisqZPaKKu3vFTQbNN2TOEoNUJ?=
 =?us-ascii?Q?261AYyILoDADXdBVXedKV4ql3LuLUb8M4llvDRwHMD8HwxQIqcCTXQTVqiwz?=
 =?us-ascii?Q?b9WHcskcuw3VLiMwXNvsONi9qg6wqyulA4IDhPI/IGQ6XwwZoVkXJSVgtPqi?=
 =?us-ascii?Q?uLEBzZNGXDoNIm7E96+ty8yS5sNZtGsqwoUEmXrCsLQMouAdV8j5KaFjLeWn?=
 =?us-ascii?Q?WoBskua0h6/pIPX5HMONTxamRTocSYZgEiVnI0AyHEV4Co8I+8JviaEF0Ry8?=
 =?us-ascii?Q?ww1RUOR+QNNDLJlrioPyB4+HmeAgck/0ZNsvVus0ssqrzLWeVz0IgJtZy5nn?=
 =?us-ascii?Q?2TqSBCnEBxMa9phkDD97Fdh8R/4yDoo8sh8PAqIXhPD58nfHskLAKA2RUF+Y?=
 =?us-ascii?Q?ftagmm+JwVA9bjyEJg7CLN4fABG5IQi4VbFnqSpY6fr11K3StPgbGM+AvGBA?=
 =?us-ascii?Q?bk5xRp5VDbm3D7saDWiGGxEjt5DmCwoYZ6C7DXsNrR56qLAWGsGOHQLVpO/B?=
 =?us-ascii?Q?sDarcgl05GRfEkhDLv5ARfLDKyeWpLqZLX07yPOqp0nQ0dIT1t9HJFBW9zRs?=
 =?us-ascii?Q?VE99UmZiqHR1f4nbdTc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc8ac71-fc4e-4533-52c5-08dd4b8edf2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:58:35.7912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVrJQB1LU326Q5mzXbo3cZfxUHd2XwerX8xgy17BfoqJYOb8W7nRoAypw6DcuqS4K5f2x1Y55qhHzWZO+Ov8oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8205
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

[Public]

Greetings, sending peace.

Still seeking a review on this.  These changes are simple and should not ta=
ke much of your time, so please send me a "Reviewed By:" or your comments.

One love!

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Martin=
,
> Andrew
> Sent: Monday, December 30, 2024 2:10 PM
> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
>
> [Public]
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> [Public]
>
> @Russell, Kent
>
> Thanks, I will send out the next version soon!
>
> > -----Original Message-----
> > From: Russell, Kent <Kent.Russell@amd.com>
> > Sent: Monday, December 30, 2024 1:37 PM
> > To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: Martin, Andrew <Andrew.Martin@amd.com>
> > > Sent: Monday, December 30, 2024 1:15 PM
> > > To: Russell, Kent <Kent.Russell@amd.com>;
> > > amd-gfx@lists.freedesktop.org
> > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>
> > > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> > >
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Russell, Kent <Kent.Russell@amd.com>
> > > > Sent: Monday, December 30, 2024 12:44 PM
> > > > To: Martin, Andrew <Andrew.Martin@amd.com>; amd-
> > > > gfx@lists.freedesktop.org
> > > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Martin, Andrew
> > > > <Andrew.Martin@amd.com>
> > > > Subject: RE: [PATCH v2] drm/amdkfd: Ignored various return code
> > > >
> > > > [Public]
> > > >
> > > > Might be worth changing the commit headline to what the patch
> > > > does, something like Don't ignore return codes Or Various return
> > > > code cleanup
> > > >
> > > > Otherwise it sounds like your patch is intentionally ignoring
> > > > return codes, which is the opposite of what you're doing. Also 2
> > > > comments
> > below.
> > >
> > > Thanks, will do!, Please see response to your 2 comments also!
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf
> > > > > Of Andrew Martin
> > > > > Sent: Monday, December 30, 2024 12:02 PM
> > > > > To: amd-gfx@lists.freedesktop.org
> > > > > Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Russell, Kent
> > > > > <Kent.Russell@amd.com>; Martin, Andrew
> > <Andrew.Martin@amd.com>
> > > > > Subject: [PATCH v2] drm/amdkfd: Ignored various return code
> > > > >
> > > > > This patch checks and handles the return code of the called funct=
ion.
> > > > >
> > > > > Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
> > > > > ---
> > > > >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  2 +-
> > > > >  drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  2 ++
> > > > >  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 +++++++++++++=
+---
> > --
> > > > >  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++-----
> > > > >  4 files changed, 23 insertions(+), 11 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > > index 065d87841459..52a11dc01422 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > > > > @@ -2864,7 +2864,7 @@ static int runtime_disable(struct
> > > > > kfd_process *p)
> > > > >
> > > > > pdd->dev->vm_info.last_vmid_kfd);
> > > > >
> > > > >                       if (!pdd->dev->kfd->shared_resources.enable=
_mes)
> > > > > -                             debug_refresh_runlist(pdd->dev->dqm=
);
> > > > > +
> > > > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > > > >                       else
> > > > >                               kfd_dbg_set_mes_debug_mode(pdd,
> > > > >
> > > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > > index 693469c18c60..f335ed9e0b3a 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> > > > > @@ -2351,6 +2351,8 @@ static int kfd_create_vcrat_image_gpu(void
> > > > *pcrat_image,
> > > > >       if (kdev->kfd->hive_id) {
> > > > >               for (nid =3D 0; nid < proximity_domain; ++nid) {
> > > > >                       peer_dev =3D
> > > > > kfd_topology_device_by_proximity_domain_no_lock(nid);
> > > > > +                     if (!peer_dev)
> > > > > +                             return -ENODEV;
> > > > >                       if (!peer_dev->gpu)
> > > > >                               continue;
> > > > >                       if (peer_dev->gpu->kfd->hive_id !=3D
> > > > > kdev->kfd->hive_id) diff --git
> > > > > a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > > index a8abc3091801..b4db409d90a1 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> > > > > @@ -518,6 +518,9 @@ int kfd_dbg_trap_set_flags(struct
> > > > > kfd_process *target, uint32_t *flags)
> > > > >       for (i =3D 0; i < target->n_pdds; i++) {
> > > > >               struct kfd_topology_device *topo_dev =3D
> > > > >
> > > > > kfd_topology_device_by_id(target->pdds[i]->dev->id);
> > > > > +             if (!topo_dev)
> > > > > +                     return -EINVAL;
> > > > > +
> > > > >               uint32_t caps =3D topo_dev->node_props.capability;
> > > > >
> > > > >               if (!(caps &
> > > > >
> > > HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
> > > > > &&
> > > > > @@ -565,9 +568,9 @@ int kfd_dbg_trap_set_flags(struct
> > > > > kfd_process *target, uint32_t *flags)
> > > > >                               continue;
> > > > >
> > > > >                       if (!pdd->dev->kfd->shared_resources.enable=
_mes)
> > > > > -                             debug_refresh_runlist(pdd->dev->dqm=
);
> > > > > +
> > > > > + (void)debug_refresh_runlist(pdd->dev->dqm);
> > > > >                       else
> > > > > -                             kfd_dbg_set_mes_debug_mode(pdd, tru=
e);
> > > > > +
> > > > > + (void)kfd_dbg_set_mes_debug_mode(pdd,
> > > > > + true);
> > > > >               }
> > > > >       }
> > > > >
> > > > > @@ -584,8 +587,8 @@ int kfd_dbg_trap_set_flags(struct
> > > > > kfd_process *target, uint32_t *flags)
> > > > >   */
> > > > >  void kfd_dbg_trap_deactivate(struct kfd_process *target, bool
> > > > > unwind, int
> > > > > unwind_count)
> > > > >  {
> > > > > -     int i;
> > > > >
> > > > > +     int i, r =3D 0;
> > > > >       if (!unwind) {
> > > > >               uint32_t flags =3D 0;
> > > > >               int resume_count =3D resume_queues(target, 0, NULL)=
;
> > > > > @@
> > > > > -627,9 +630,11 @@ void kfd_dbg_trap_deactivate(struct
> > > > > kfd_process *target, bool unwind, int unwind
> > > > >                       pr_err("Failed to release debug vmid on
> > > > > [%i]\n",
> > > > > pdd->dev-
> > > > > >id);
> > > > >
> > > > >               if (!pdd->dev->kfd->shared_resources.enable_mes)
> > > > > -                     debug_refresh_runlist(pdd->dev->dqm);
> > > > > +                     r =3D debug_refresh_runlist(pdd->dev->dqm);
> > > > >               else
> > > > > -                     kfd_dbg_set_mes_debug_mode(pdd,
> > > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > > +                     r =3D kfd_dbg_set_mes_debug_mode(pdd,
> > > > > !kfd_dbg_has_cwsr_workaround(pdd->dev));
> > > > > +             if (r)
> > > > > +                     break;
> > > > >       }
> > > > >
> > > > >       kfd_dbg_set_workaround(target, false); @@ -1071,6 +1076,10
> > > > > @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
> > > > >       for (i =3D 0; i < tmp_num_devices; i++) {
> > > > >               struct kfd_process_device *pdd =3D target->pdds[i];
> > > > >               struct kfd_topology_device *topo_dev =3D
> > > > > kfd_topology_device_by_id(pdd->dev->id);
> > > > > +             if (!topo_dev) {
> > > > > +                     r =3D EINVAL;
> > > > > +                     break;
> > > > > +             }
> > > > >
> > > > >               device_info.gpu_id =3D pdd->dev->id;
> > > > >               device_info.exception_status =3D
> > > > > pdd->exception_status; diff --git
> > > > > a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > > index 1405e8affd48..250aa43a39c8 100644
> > > > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > > > > @@ -1907,16 +1907,18 @@ static int start_cpsch(struct
> > > > > device_queue_manager
> > > > > *dqm)
> > > > >
> > > > >  static int stop_cpsch(struct device_queue_manager *dqm)  {
> > > > > +     int ret =3D 0;
> > > > >       dqm_lock(dqm);
> > > > >       if (!dqm->sched_running) {
> > > > >               dqm_unlock(dqm);
> > > > > -             return 0;
> > > > > +             return ret;
> > >
> > > I can agree with this one, since it minimizes the changes, but it
> > > does flow
> > the same.
> > >
> > > >
> > > > I think it's cleaner to just leave the "return 0" . e.g. If the
> > > > code gets refactored and new stuff gets added above, then this
> > > > might flow
> > differently.
> > > >
> > > >
> > > > >       }
> > > > >
> > > > >       if (!dqm->dev->kfd->shared_resources.enable_mes)
> > > > > -             unmap_queues_cpsch(dqm,
> > > > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0,
> > > > USE_DEFAULT_GRACE_PERIOD,
> > > > > false);
> > > > > +             ret =3D unmap_queues_cpsch(dqm,
> > > > > KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
> > > > > +                                      0,
> > > > > + USE_DEFAULT_GRACE_PERIOD, false);
> > > > >       else
> > > > > -             remove_all_kfd_queues_mes(dqm);
> > > > > +             ret =3D remove_all_kfd_queues_mes(dqm);
> > > > >
> > > > >       dqm->sched_running =3D false;
> > > > >
> > > > > @@ -1930,7 +1932,7 @@ static int stop_cpsch(struct
> > > > > device_queue_manager
> > > > > *dqm)
> > > > >       dqm->detect_hang_info =3D NULL;
> > > > >       dqm_unlock(dqm);
> > > > >
> > > > > -     return 0;
> > > > > +     return ret;
> > > >
> > > > Same here
> > > >
> > >
> > > If I change this back to "return 0 ;" then I would have lost the
> > > return value from "unmap_queues_cpsch()" or
> > > "remove_all_kfd_queues_mes()" which was the whole point of touching
> > > this function.  But since we in the "stop_cpch()" perhaps it is a
> > > more optimal solution is to ignore the return code with ...
> > > (void)unmap_queues_cpsch()
> > > else
> > > (void)remove_all_kfd_queues_mes()
> > > ...
> > >
> > > Which would be the only change here. Otherwise, I would need to
> > > introduce a 3rd return statement.  So do let me know which path
> > complements the design more.
> > >
> > Good point, I missed that it would drop the one from above. That's
> > fine to leave in then.
> >
> >  Kent
> >
> > > >  Kent
> > > >
> > > > >  }
> > > > >
> > > > >  static int create_kernel_queue_cpsch(struct
> > > > > device_queue_manager *dqm, @@ -3439,7 +3441,6 @@ int
> > > > > suspend_queues(struct kfd_process
> > *p,
> > > > >                                       else
> > > > >                                               per_device_suspende=
d++;
> > > > >                               } else if (err !=3D -EBUSY) {
> > > > > -                                     r =3D err;
> > > > >                                       queue_ids[q_idx] |=3D
> > > > > KFD_DBG_QUEUE_ERROR_MASK;
> > > > >                                       break;
> > > > >                               }
> > > > > --
> > > > > 2.43.0
> > > >
> > >
> >

