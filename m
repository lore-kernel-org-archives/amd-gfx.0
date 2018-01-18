From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/ttm: Don't add swapped BOs to swap-LRU list
Date: Thu, 18 Jan 2018 21:15:12 +0000
Message-ID: <BN6PR12MB1652C9BDA540238CBB3C7B47F7E80@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1516294577-29078-1-git-send-email-Felix.Kuehling@amd.com>
 <8d81b35d-dd7c-3d9c-cb91-4978b59f95c8@gmail.com>,
 <117acb40-1cc5-9ea0-0e64-5db554c8cf9b@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0551263523=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <117acb40-1cc5-9ea0-0e64-5db554c8cf9b-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "He, Roger" <Hongbo.He-5C7GfCeVMHo@public.gmane.org>

--===============0551263523==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1652C9BDA540238CBB3C7B47F7E80BN6PR12MB1652namp_"

--_000_BN6PR12MB1652C9BDA540238CBB3C7B47F7E80BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


________________________________
From: Kuehling, Felix
Sent: Thursday, January 18, 2018 4:12 PM
To: Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org; He, Roger; Deucher, Alexander
Subject: Re: [PATCH 1/2] drm/ttm: Don't add swapped BOs to swap-LRU list

On 2018-01-18 01:09 PM, Christian K=F6nig wrote:
> Am 18.01.2018 um 17:56 schrieb Felix Kuehling:
>> A BO that's already swapped would be added back to the swap-LRU list
>> for example if its validation failed under high memory pressure. This
>> could later lead to swapping it out again and leaking previous swap
>> storage.
>>
>> This commit adds a condition to prevent that from happening.
>>
>> v2: Check page_flags instead of swap_storage
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
>
> Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org> for both.

Thanks. I pushed them to amd-staging-drm-next. I think patch 1 should
also go to -fixes. Alex?

Yup, already planning on it.

Alex

Regards,
  Felix

>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 2eb71ff..62518b6 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -170,7 +170,8 @@ void ttm_bo_add_to_lru(struct ttm_buffer_object *bo)
>>           list_add_tail(&bo->lru, &man->lru[bo->priority]);
>>           kref_get(&bo->list_kref);
>>   -        if (bo->ttm && !(bo->ttm->page_flags & TTM_PAGE_FLAG_SG)) {
>> +        if (bo->ttm && !(bo->ttm->page_flags &
>> +                 (TTM_PAGE_FLAG_SG | TTM_PAGE_FLAG_SWAPPED))) {
>>               list_add_tail(&bo->swap,
>>                         &bo->glob->swap_lru[bo->priority]);
>>               kref_get(&bo->list_kref);
>


--_000_BN6PR12MB1652C9BDA540238CBB3C7B47F7E80BN6PR12MB1652namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Kuehling, Felix<br>
<b>Sent:</b> Thursday, January 18, 2018 4:12 PM<br>
<b>To:</b> Koenig, Christian; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel@list=
s.freedesktop.org; He, Roger; Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/ttm: Don't add swapped BOs to swap-LRU =
list</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2018-01-18 01:09 PM, Christian K=F6nig wrote:<b=
r>
&gt; Am 18.01.2018 um 17:56 schrieb Felix Kuehling:<br>
&gt;&gt; A BO that's already swapped would be added back to the swap-LRU li=
st<br>
&gt;&gt; for example if its validation failed under high memory pressure. T=
his<br>
&gt;&gt; could later lead to swapping it out again and leaking previous swa=
p<br>
&gt;&gt; storage.<br>
&gt;&gt;<br>
&gt;&gt; This commit adds a condition to prevent that from happening.<br>
&gt;&gt;<br>
&gt;&gt; v2: Check page_flags instead of swap_storage<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt; for bo=
th.<br>
<br>
Thanks. I pushed them to amd-staging-drm-next. I think patch 1 should<br>
also go to -fixes. Alex?<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Yup, already planning on it.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Alex<br>
</div>
<div class=3D"PlainText"><br>
Regards,<br>
&nbsp; Felix<br>
<br>
&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; &nbsp; drivers/gpu/drm/ttm/ttm_bo.c | 3 &#43;&#43;-<br>
&gt;&gt; &nbsp; 1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/tt=
m_bo.c<br>
&gt;&gt; index 2eb71ff..62518b6 100644<br>
&gt;&gt; --- a/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/ttm/ttm_bo.c<br>
&gt;&gt; @@ -170,7 &#43;170,8 @@ void ttm_bo_add_to_lru(struct ttm_buffer_o=
bject *bo)<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add_ta=
il(&amp;bo-&gt;lru, &amp;man-&gt;lru[bo-&gt;priority]);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_get(&a=
mp;bo-&gt;list_kref);<br>
&gt;&gt; &nbsp; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;ttm =
&amp;&amp; !(bo-&gt;ttm-&gt;page_flags &amp; TTM_PAGE_FLAG_SG)) {<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;ttm &am=
p;&amp; !(bo-&gt;ttm-&gt;page_flags &amp;<br>
&gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (TTM_PAGE_FLAG_SG | TTM_PAGE_FLAG_SWAPP=
ED))) {<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; list_add_tail(&amp;bo-&gt;swap,<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;bo-&gt;glob-&gt;swap_lru[bo-&gt;priority]);<br>
&gt;&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; kref_get(&amp;bo-&gt;list_kref);<br>
&gt;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1652C9BDA540238CBB3C7B47F7E80BN6PR12MB1652namp_--

--===============0551263523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0551263523==--
