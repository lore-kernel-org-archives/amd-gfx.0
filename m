Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84103C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 03:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED9710E00A;
	Wed, 29 Jun 2022 03:07:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E80E10E00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 03:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7TIXjuZyZkx98Bwz5H6ESSjoe8f7L6UGhkVgk/0y5/wkVbWyMyp5Oj8iX51npvUHMKV8QV22jG+nrXHPKh0YTRAZUph4bHPEVnCD8Iurq1V17NmATHosmNYMVMY2mTAHwGr7+h/xPfw4pBl3LwshN73HhjaFherSIuB1MHpkGz+6KHtuTgrw8yBfs9wfcwS+o6BL2uQfJp2kwPwzCXFvPnpHoIm9WHvpktGfAbNk/eR5OkHLWlXxcScRTgIOGUrbQDDQ3GraUgmyr7wziKN2n27L4FNxXX67LZjL7Gczjw6zXa3raykLfhuM6yJFH+BoU7H2p1WBZoa/+vBsX6mdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I88PGMs49/4pvlypAzh6tx2tXUIkw0yBmizaY+UXIno=;
 b=kxgUaJi7ksE0EVri65Eh2lRllF7xMBsebaQVGcEWb8USLHiHivFTqY9XLSB6gZWVzSY9hXlXvJE+BXcyjNaegZ3x13dHxrn+FkTb8O97vPDkF2b+oNOMWmm46r2NGHcxQseCPBOWv8xpbXQ/54PWKtHAoQfdlpFfG5VCC+veVUjm+OyV42WisZQ7WV/Jb0JaWRi5C1DN8pnyPhc3WVyDIW2gWoxHzw8LtDjXKn0nwFakqJtKantM9daJDIDDEXJVS1fLZYDQIGtoG62J8Wfpm9GqDQRe9cWCXekSksXKfBBQAgKe1NDo84BL4qVw6qOyaPOQ2W7+qjiXdHSk+CZBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I88PGMs49/4pvlypAzh6tx2tXUIkw0yBmizaY+UXIno=;
 b=ZkjEsNW5eAWbuFy9IYG91SnYzkyvf1TXST5M47n/S0qKKXSKbzbvH7cKPZL/Nr9vHr/leXM7hl4xx4vLQtglG6qBCvmruer8ObYZVUGyEAq4v57Vyu0WDoFn8oSKSQECnFP8DhvFEau0vA1u4wol8sHRdf1R+enBGsQzlhtsusE=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Wed, 29 Jun
 2022 03:07:10 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::7d16:a6b1:7a6a:aae8]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::7d16:a6b1:7a6a:aae8%9]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 03:07:10 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>,
	=?iso-2022-jp?B?GyRCISgbKEJtYXJpby5saW1vbmNpZWxsb0BhbWQuY29t?=
	<；mario.limonciello@amd.com>
Subject: SYNCOBJ TIMELINE Test failed while running amdgpu_test
Thread-Topic: SYNCOBJ TIMELINE Test failed while running amdgpu_test
Thread-Index: AdiLY8Uv72/o16mSSt6xXsLeeDdGOQ==
Date: Wed, 29 Jun 2022 03:07:10 +0000
Message-ID: <DM4PR12MB5152E2C6E83FE53A63319623E3BB9@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-29T02:52:52Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f91d38bf-90d1-4ee8-8145-6db98c08a51f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-29T03:07:07Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: b31bdc15-cf33-46f6-aa73-332c20711907
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c066689b-9108-4afd-78bc-08da597c7525
x-ms-traffictypediagnostic: BYAPR12MB2869:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cs3F9hDL735+WFyf24/wZCSmX7dehf6R0KXLmV80+6HByblCXmn+TOUO2G/1W3kguhHeL2iZ8Zu84XrjjdibV/R5D/LLIURlFTiu3czSdZP9iN9uCOowmlzzW3Kp0lXOfhLgp9iL3rO1QM0IoyVJTuseM/ukJSVBbIQ8lr0Wzy9oDGAs437+mt8uvEPC5IJ3kutmZlJoWuMlXOVc8IKfXzsQhP/5U6X8iMfRAyOu40BYqMGXQNQXAl49O63njUWPvyRTMNUaw1ghZtfIN3B5lTOly9u/9Yh6BHf0tsODuC/9NnkrK1Idcvw8e2S6BZOCSRHpy27q63P6XP+XylyZRSGox7nicZPWfnYJ9WChQLxgdcNAv+Rmm44DEnsEY57eRoIRLhQdb1+8Jb8BtOhDBbwZytIBR5i3r0vcjJ2v/MweFvjWbSVO7N1GSKpfLeNsNdG7Gvw6t5eHNCyVR6IRTD654biad6H9991MKk+Q1em7Bq/81vqCBvNazGs/4gUYQqMgVv4FFSkDkoWdc0MSAikW2f/j50vqhps4ircSYAgVGMbOJzMoU247IcoPdEjGLjpDU5m5etuGhYXym56FXJAy4H7UQRkKTIKFhOvIN8diqebNd1i00uLPK1yeLk+fjvv8AK6eP0bXFOfq+pZOxn59i3YRO4tHepGk7hfMSp8sYcZUCgbMbQk6hIPFTB+ZDZNRGpDXVPYsvDrOMKQ7kpMN7MFA3JpZRUCAAPzzs+VN95N+Ezf3EvplRI+8R1OcfoBDxaoEOqfqgc0ZqDJ752TglvTFHqrNbnXJJJWRkYAu5ETdRE6yeJnjPR+XvFBRRrH3HQd6zLvh93BMclOkrQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(316002)(76116006)(5660300002)(122000001)(66446008)(71200400001)(66476007)(41300700001)(8936002)(55016003)(478600001)(52536014)(66556008)(4744005)(110136005)(33656002)(8676002)(38070700005)(6636002)(9686003)(186003)(64756008)(38100700002)(4326008)(66946007)(26005)(86362001)(2906002)(7696005)(6506007)(166002)(54906003)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?ZkZNMDVrSnA2WWt2Zmx4eDVLSTlNaS83TFA5TldXaWRqMGtsa0d4REQv?=
 =?iso-2022-jp?B?YjdjSTQ0bFZxUC9rQ2pQL1RudWhPSzk4RzJrcnhualJMUUdHNUlhamx2?=
 =?iso-2022-jp?B?U05OcDloK3ZJOE5ld0hiV0U1K0ptM3AzaUNKenM3cndCa1JlWDl1Z3BO?=
 =?iso-2022-jp?B?UldDZlVXMjE3Vm4vZnNTRjIzSCtqSS9Sd3kvTjJ3Y1JlVTEzNjYweEVR?=
 =?iso-2022-jp?B?eWhUUGlHTUM4SVNJblg0R1N6NDBKS01sQlU3amU2Q3FqZkNKUHR4NVRB?=
 =?iso-2022-jp?B?SVh0M1FpUGVNNzdiSFdYaXp4ejVvV3RKNldzb1pGYmdhNWJuN2d3UWlP?=
 =?iso-2022-jp?B?am80bk4ydG4rVVZuMm5UazVHbGN2VHVWeEttOExJVERoTG5mU0VCR1pn?=
 =?iso-2022-jp?B?dExzT3VJVjZnbktSMG5xNzhaRzloMGpJSXUyM3hJM0h2aDNDV2hNNHp6?=
 =?iso-2022-jp?B?R253OEhmOEd2aXFkSnpTbU5uSEY2bEJKem4yUVZSQ3RJbVdhV3dmRUVQ?=
 =?iso-2022-jp?B?Tkcvb3dEL1N0Y3FybHhYQU13YmhRaUFHeVJsTkNYYUJFdjArRWZUNnBQ?=
 =?iso-2022-jp?B?N21mVDdKbVJjSjhGTUJiMjVXamp6U2twVzk1Z3YrUFJ0REh2THN5VlBC?=
 =?iso-2022-jp?B?UTRKKzNaYVpBT1ZtRFNMd2JBMjd2QUNOTUUvbUh4b3EyQnpRNUhlQWZM?=
 =?iso-2022-jp?B?RGphRXYwQitVRnhUZ2UrRWdNdHJOdjJmeVRKWUZiSEhQK3AvMnNBY0xM?=
 =?iso-2022-jp?B?ZjFxWnU5QU1hd3BscENqMmZMeEZLN3FqRDZ6ek5tVHRaMDU5NnZscHJw?=
 =?iso-2022-jp?B?ZXFUM3g2dG41Q2xTelpTc2VTdUVxdFJrM0RycGVJZFhRNVpWaWJ4QU4z?=
 =?iso-2022-jp?B?TjQrM09YQVI5ZitKSDZIbGptT3l1a2tWaVNBZ29vOFIybElGNFBaQk5a?=
 =?iso-2022-jp?B?VmFCMTdlOGM4TlNWV0ViTEVrS1pvWmFwcUl4ZEs3WDU3M3lRbSs0bmpG?=
 =?iso-2022-jp?B?QmtOamxOWnpQMTYxS24yV0VnRDVLc1Z0aEpYa1NGamZLdThsZWZoLzFJ?=
 =?iso-2022-jp?B?U1lUUld4M0czOEEwMU9XZmtWWDFheTdVbDMrVnF5ZWlEbnVBTHlrYVBy?=
 =?iso-2022-jp?B?VTlvbmtMWDVCKzZodW9NWmpjc2RFTXBoMUhJSkNjWEVWdzN2aURYSnlK?=
 =?iso-2022-jp?B?d2xwSkhsaVFsNzNoNnBhN3JnZVpXTXpxeXF4MGowS2E4MkV2OU5TQmN3?=
 =?iso-2022-jp?B?SGR3Q2hsblZ3OVNoVnFleTkwQWwyZW15NjB3T1ZTT3o2ZkF6MmpvUmZF?=
 =?iso-2022-jp?B?OTNKVm9kUEZOOGhXV1k2cHpxSG41VmxrYWo1Q0NDRFBZRURXUC9UQWF1?=
 =?iso-2022-jp?B?Z2R5K3dDUEFSMVpIMnBYekdsZ251Mks5MktWclBTWllRNm1oZ1A4Zmxj?=
 =?iso-2022-jp?B?NE1rL1Mzd1BOdFZrL0NaSDRVaW8vaGwyR09CZ0dDNkxVVkZsaWZIRmRB?=
 =?iso-2022-jp?B?bUJBR1BHK08zUkZKZ1BaODVoKzhaK0lONWJmeVppaTdBdmZ2ei9ubGpK?=
 =?iso-2022-jp?B?M3ExOGlCbWZkV1NoOTFRenpZZ2dmWFVINmJhZXh0M0E4NGtTYWJmSVp2?=
 =?iso-2022-jp?B?bkpad3o3aE1yQUJHS0ZicG9DQmpXbC9GL2t5YmIxN1M5dk5XaXBNa2JD?=
 =?iso-2022-jp?B?QUtiRHYxc1F1a2l3a01BZlNxOXlCV3RhNE95VmFvUmVtM3QyaTNSMk1s?=
 =?iso-2022-jp?B?WU9vK1ozby9VZnJGSnpScWJsZ0FmbnYvdUplK0FtMG5SazFFeEJnOG91?=
 =?iso-2022-jp?B?VFJIMDRJblVUaDRieVZJeE9EbEl0VkE4U29PNit6dmFWL0Z3aElkTFB1?=
 =?iso-2022-jp?B?NWxIV0E5VXVURVhRNTJaVFlMWTNkMTlEMDBnVGRtVlBCVUJXUUJ5NmEx?=
 =?iso-2022-jp?B?ZmJ0OFlpSXZhZXI3SlZqWUxhN3pGVDBMV0hrZXN0UWJiN0VMNVM5RC9E?=
 =?iso-2022-jp?B?RkpNa0JOeTh2ZGc1Y09uK0NYc2l0ZnVKNUMwS0ZYOGR4RmFJaUQ2V0k0?=
 =?iso-2022-jp?B?em9jS1B5T2FQSkRyYnRkZEhLV2J5ckRYVXVtM2FYNTVnTmFkQi9nQjJV?=
 =?iso-2022-jp?B?aXBKQ0U2aHh2WS9ETytEZTBFOE12MnZDY2tDK00ydkRaZ1N5OFQ4NmU1?=
 =?iso-2022-jp?B?RzRud204eGJpZVd5RDVhbW9RYzFxZjYwVGFSbzBDamRnekZjSWVtSVhM?=
 =?iso-2022-jp?B?WXRaOXBvdHNLRW9ENURTNW1sSkNseDI5WnAvcXZHeVRGcGJKRHlpRlNY?=
 =?iso-2022-jp?B?UW9UeQ==?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5152E2C6E83FE53A63319623E3BB9DM4PR12MB5152namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c066689b-9108-4afd-78bc-08da597c7525
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 03:07:10.2083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wvFq7NvoWaCwAy5MxaCZnqrhp8y5U4WhtlAbRHy1ezIXxVu1xhw+GNsvRwfd2rPA1yBwxl9W2J4S2gpHRFHoCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2869
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5152E2C6E83FE53A63319623E3BB9DM4PR12MB5152namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hi Alex and Mario
We find the =1B$B!H=1B(BSyncobj timeline=1B$B!I=1B(B test failed on ubunt22=
(kernel version  >=3D 5.15.34).
Failed log:
Suite: SYNCOBJ TIMELINE Tests
  Test: syncobj timeline test ...FAILED
    1. sources/drm/tests/amdgpu/syncobj_tests.c:299  - CU_ASSERT_EQUAL(payl=
oad,18)
    2. sources/drm/tests/amdgpu/syncobj_tests.c:309  - CU_ASSERT_EQUAL(payl=
oad,20)

We find it cause by the patch.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dab66fdace8581ef3b4e7cf5381a168ed4058d779.

So I add a patch , please help to review.

diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
index 7e48dcd1bee4..d5db818f1c76 100644
--- a/drivers/gpu/drm/drm_syncobj.c
+++ b/drivers/gpu/drm/drm_syncobj.c
@@ -887,7 +887,7 @@ static int drm_syncobj_flatten_chain(struct dma_fence *=
*f)
                goto free_fences;

        dma_fence_put(*f);
-       *f =3D &array->base;
+       *f =3D array->fences[0];
        return 0;



Thanks
Jesse

--_000_DM4PR12MB5152E2C6E83FE53A63319623E3BB9DM4PR12MB5152namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Alex and Mario<o:p></o:p></p>
<p class=3D"MsoNormal">We find the =1B$B!H=1B(BSyncobj timeline=1B$B!I=1B(B=
 test failed on ubunt22(kernel version &nbsp;&gt;=3D 5.15.34).&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal">Failed log:<o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">Suite: SYNCOBJ TIMELINE Tests<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp; Test: syncobj timeline test ...FAILED<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp;&nbsp;&nbsp; 1. sources/drm/tests/amdgpu=
/syncobj_tests.c:299&nbsp; - CU_ASSERT_EQUAL(payload,18)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;;color:black">&nbsp;&nbsp;&nbsp; 2. sources/drm/tests/amdgpu=
/syncobj_tests.c:309&nbsp; - CU_ASSERT_EQUAL(payload,20)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We find it cause by the patch.<o:p></o:p></p>
<p class=3D"MsoNormal"><a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/commit/?id=3Dab66fdace8581ef3b4e7cf5381a168ed4058=
d779">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dab66fdace8581ef3b4e7cf5381a168ed4058d779</a>.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So I add a patch , please help to review.&nbsp; <o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers=
/gpu/drm/drm_syncobj.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 7e48dcd1bee4..d5db818f1c76 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/drm_syncobj.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/drm_syncobj.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -887,7 +887,7 @@ static int drm_syncobj_flatten_c=
hain(struct dma_fence **f)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto free_fences;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence=
_put(*f);<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *f =3D &amp;ar=
ray-&gt;base;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *f =3D array-&=
gt;fences[0];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Jesse<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB5152E2C6E83FE53A63319623E3BB9DM4PR12MB5152namp_--
