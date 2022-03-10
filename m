Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6594FC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 14:22:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F29B10E41F;
	Thu, 10 Mar 2022 14:22:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFB210E7D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 14:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQngpPvmXBX6hwy3Hn8KmBlCnPlBo6SNzmE9pCY2G3maqF1bWTB++fA/htIARfI1vzVQspgA1m5FakciKjJn3197jQn1uAbpaO8DtVkH9Y6rKjoEolEPfBQ+xgYO18Cl84HOBTRJO+XYF/Vf7AzFM1aqba1y/OQPjn4ZSuKJirmBh2mKotXgll8On+FRgtO83AYQX1f71Cf1egLCVmm1RNQo64pQfJGZpI/9k04NTeLwcRn8b3upM0nAwOZUrNX+5A0zLfwDsIjd4qyIsnn+sObo0hyXnfyZfces8W+ggYaXCsuT3xwSFVq4xg/iv11c8XFZn75x6rRCpxXekZdHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1oBHoN13dsBG3Iq2fnu27uhMyMJCTZbeH54dYyeNng=;
 b=UWmCxAOhrbmamGOC7gsPMIdiSxQwpi3o6Sohmc8Anu1gvB5tt3ZGg5TYgqvM7nmdMS+plgG8cXkYA4o1ehdY0/5CEVxWPxLHFmjQtmESMbaoxnrHTOnOTOhdW2aRflO6HwmJoNAlbZtTiLp7IqlOsg7w0i4rdah0AykMS39fT0b5VGP7afDr/maIm+JS3dBDTr29hzt1uyDDCpvTJ+A0ycT8XjUJ1pdXlZWtuTVqKdz/bCBlVrHn3H4M/bjWb2joQdeHhSMLsJuCrIRsoWLzVFwtsz6Dl8XGLvsH5AlM8iGL7JmFErIKoDVZGPHTEbAvbBozXxHpJ6rj0yHD9iTTeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1oBHoN13dsBG3Iq2fnu27uhMyMJCTZbeH54dYyeNng=;
 b=TSaD9fU9s1rZzcWPnT6nU0Ojo5EhaofHL/KJsuapVY8hoWNKD9b0GyN9ncTUEvzMGz0B/PhBynQB4m0Xke9LBjzCZKV9ZnROgZw2mBWl/3Bwc5/AVcimRPNW8wE1GSF6/PIcsyjdRw5V2mEEpB/4Qqw6n4xk8a8b15HwkkMLC0Q=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 14:22:03 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::64ab:286b:3178:89c4%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:22:03 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] umr: Fix unhandled enumeration value in switch
Thread-Topic: [PATCH 4/4] umr: Fix unhandled enumeration value in switch
Thread-Index: AQHYNBfH3tLb/kKRm02zpj/U/q1eOKy4rBoz
Date: Thu, 10 Mar 2022 14:22:03 +0000
Message-ID: <DM6PR12MB35477B7CEF2773983590B5CFF70B9@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
 <20220310004226.50895-4-luben.tuikov@amd.com>
In-Reply-To: <20220310004226.50895-4-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-10T14:22:03.212Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: a1e8116a-b0df-4173-fa24-8d1e514ecff2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42913bc6-2efc-453a-b0a4-08da02a15956
x-ms-traffictypediagnostic: MW3PR12MB4442:EE_
x-microsoft-antispam-prvs: <MW3PR12MB44427A8C7AB10416C6BAAB3EF70B9@MW3PR12MB4442.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYPtIf4vO6b1NdQMXn0tvF6x1BloT9q1sQRuVADr4YdveUlW9sl60Tru4qpfhy8xzZDxP3WOo4k6wctyiKu6bhhPxiF7F8p1Qg/iyA2ILwVFIouHRs/2ZMYuVk3NdWMHmZSdGyH6D90lUi50CmBuRmtbu7ToR3f0JcrXxgcFHhIFOwy7ow1vNwiWMh9+kVkJ7GPlhGAXhW5gfY1NqiL5Ly2BbFDAXzVkwLEDPn5qbjo0bPYb90kY6rYcvB2vlBniw1z7d2bdcmVMT9HcD1ovbvmozhPQr/FH9qooYMgjDMVlGNT46/wdbdHozo9/XuFmoP6+r23vy3o9Gjf/ROcD8NOpy3URkuJpMYj5fJj3v0IZOgOT4oal+/WIte5Wk0X1gfiTqKCbpf9Zr4KxgMzE8ihTU2cEBAuP8HK4QObOZx10eklEQdjPp9s3pS1SQOzS7EGWZ4bW+ZQB7y7dOc2Cm2ko9FxIgxNp/XcLksZ/70G01bXS9Ti+RX5iIXTJEY9Mh1SR1G5F3v+Q7hDILPcfNAHqY8+DfQZ8+oZhBjqDSaoUXg71oe5w6+/oHgZ5SzqGQyJHn3xRdr4LkpZW0103AqKPK1kR7pPKcnAUTHpColKKre7rYq7SNXQAFK/DUgU/2SAKX2Z/kPdN6xOuQx8VGGn+ihGFLCDTikKJ7BqyoSsArX9lDrvHXydqnod/r5dxBHMl0EsWNep/bxRqR32wbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(38070700005)(55016003)(91956017)(7696005)(83380400001)(86362001)(316002)(6506007)(8936002)(4326008)(76116006)(66446008)(64756008)(52536014)(66946007)(8676002)(66556008)(110136005)(508600001)(38100700002)(2906002)(186003)(53546011)(33656002)(122000001)(66476007)(9686003)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yUwTC74ndiSPH7qI+gNA3aejOLH+BWiLhDMYcptx1ZLM/WhBlXXzieskEH?=
 =?iso-8859-1?Q?dE1GAEpyDAGRe9/7zmMdznAKymkKjcLs5JR5ru2uVwl2qA3HS9im8KCYBE?=
 =?iso-8859-1?Q?0mfWaVF6rjEuUR6jN7Ysz8SzrmEv1Cha8OH73lX5POn74bQDe8UMcYtx4o?=
 =?iso-8859-1?Q?/MmVhA9cyChQRlOnglNM7UtsnycmmnbyiNocJ1r1f+e1QmW5MlyTJ6hS0h?=
 =?iso-8859-1?Q?CN/PPdQDAhxNILf0/y6ISDPEiGuhiz+NW/OQh2pBtSZSJxAXmfrhUdPKan?=
 =?iso-8859-1?Q?5LQvzknQ9FO75puGlP/UQPD+3Ercmssguk7zLnzf2myQ77Fkw3TwIuA8QT?=
 =?iso-8859-1?Q?0ddBrW0gw3an0pM5EPJsUcIynYwIR0l5sP5AaZKaDqszrff2Ldt/tnR/UN?=
 =?iso-8859-1?Q?j6q/bSgVVKTxZQrvpmAq5vFjhozWw65MgHfiULgWUV2Anp/SDwP7rPI/EA?=
 =?iso-8859-1?Q?JzEPF2hPwgM18ZKtire3lNjBzmaHcFnYyE6HssRe6RV3XE+hHgDoXGC6W+?=
 =?iso-8859-1?Q?D2sjsOxxrMiSoak5yLb7iwTGyJ/xAPz0kjp1W/rU7Yavd8WkQnXqWXKxpW?=
 =?iso-8859-1?Q?vReJ2NT32W+76o8vShZJPreDIw5t7/Iqc220A6nRUhGEtFxgY4dqQ8SMdz?=
 =?iso-8859-1?Q?/iR0zTg92jSGZJtk5M2uo/vZxQnq2zWKYD/0bcO3kjrgm9Cpttl5d+RNET?=
 =?iso-8859-1?Q?ELshCPRuHlVt8zxQInf3nPTKHtnjw++1nvfl6aAdwBrte4xOljtmWyEIgg?=
 =?iso-8859-1?Q?dEjonb+FJWGbjz4PBZ2Pquvl6PFiCg9O/tsWNghzE/+uN6PiwjNZwZNMmo?=
 =?iso-8859-1?Q?Xibk9yMgoSv3789bAg8PLEx+B7DMer5Bc6sleZWwHrpVuqgSsdVWkO1Z1O?=
 =?iso-8859-1?Q?vBJXWERz5RoVLGBxpOucOVhX5yTstEARSlyvf1+yUyCUbtunQCbhWt6pSo?=
 =?iso-8859-1?Q?s40axqfo/v+tExuyYoEBVTELO1QAu5GkN7EVl3riRIemZyWiiojuwfIvQC?=
 =?iso-8859-1?Q?8wtK4FAn8yn3fla2ULcVzgopJxQsuuMrhnAmg/iJ36delgworjEnXehCk0?=
 =?iso-8859-1?Q?cRkKDLVF1pXywr+pRTQ8rO4si0lhEowSNWBYYZ8LQQiGBZEAibZARV7kSi?=
 =?iso-8859-1?Q?wjRrBzcPi0/gTn/j673XgsgX36+wfN2l3kc2sFIKp/mCQ6WVQM5Spq2/FM?=
 =?iso-8859-1?Q?RjRBcv4KzQThUP8UbswJV5pCMKk6sKs1F6Igi1I/xOfO0Xz3pwAmJZ6PHN?=
 =?iso-8859-1?Q?GR/9K5wJmUxIyWHBCmj4RtKFBYs6g78yMtHy7q9eL06E+u0101juo8EWok?=
 =?iso-8859-1?Q?/mrAdoXS+ICOQPCIerrUQih9J4WEEQClP95/OeS0pZvq4/zaISTIaV593g?=
 =?iso-8859-1?Q?zk7D2HJdUTVOUM5XXXiY1CdhVvefaPYjPbcdczlzvAzX4KIxGDUObv2tST?=
 =?iso-8859-1?Q?Vf1JGK9q/BlUMik/FrX+DcleTl5GcyB9eFREsn5NCWtORMtOCRjsMdE/An?=
 =?iso-8859-1?Q?b+pnXcn83c0SHKjVkVk2hZ8Ag15VsTzHVXGPPTY7afh4X4j9LnFXfhoal/?=
 =?iso-8859-1?Q?oUApcbhSVsFzQVX6uHq3I3iF5ircQj7PS7Hc05YXOGH7zbUXL5b0PFagVG?=
 =?iso-8859-1?Q?VeLrbg/EvPwVVZyliarbFDWGfkRr5Am8eb0axhoNPAy83/kNlK1j4cNvns?=
 =?iso-8859-1?Q?AQNnRlurojnw4SRoyV5rIotEpjwbOoRJ7K9bUeKwTmsbXiVzdNWRO3X76S?=
 =?iso-8859-1?Q?/W6g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42913bc6-2efc-453a-b0a4-08da02a15956
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:22:03.6940 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxwXMRj6PMPO4CUaNFKa6Ig7py7y1cRPQOvddG+imB6IaNvzibGU1CUV3hf4zuEKdWnx5LZ3HchGNlMDgHqGaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Patches 2-4 look great.  With #1 swapped out to use asic->errmsg() you can =
throw my Rb on them.

Tom

________________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, March 9, 2022 19:42
To: amd-gfx@lists.freedesktop.org
Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
Subject: [PATCH 4/4] umr: Fix unhandled enumeration value in switch

Add a default case in the switch, instead of the last unhandled value,
FAMILY_CONFIGURE. This solves the case when in the future other families
are not handled--they'll all fall into the default case.

Also, in the diagnostic print, print the value of the unhandled
enumeration--this could help debug easily, as opposed to having to
reproduce the issue locally.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/ih_decode_vectors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/lib/ih_decode_vectors.c b/src/lib/ih_decode_vectors.c
index ed5705059c542f..f2057df825f5c0 100644
--- a/src/lib/ih_decode_vectors.c
+++ b/src/lib/ih_decode_vectors.c
@@ -77,11 +77,11 @@ int umr_ih_decode_vectors(struct umr_asic *asic, struct=
 umr_ih_decode_ui *ui, ui
                }
                return off / 8;

-       case FAMILY_CONFIGURE:
        case FAMILY_SI:
        case FAMILY_CIK:
        case FAMILY_NPI:
-               asic->err_msg("[BUG]: unhandled family case in umr_ih_decod=
e_vectors()\n");
+       default:
+               asic->err_msg("[BUG]: unhandled family case:%d in umr_ih_de=
code_vectors()\n", asic->family);
                return -1;
        }
        return 0;
--
2.35.1.291.gdab1b7905d

