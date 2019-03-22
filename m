From: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/9] dma-buf: add new dma_fence_chain container v6
Date: Fri, 22 Mar 2019 15:34:55 +0800
Message-ID: <5cb29811-a383-f473-5443-25e9d968c516@amd.com>
References: <20190320054724.14636-1-david1.zhou@amd.com>
 <201903210813.K5uuPgyD%lkp@intel.com>
 <c0a6bea6-c5e6-f111-748d-36c425585bce@amd.com>
 <6034e885-8485-81e4-1898-2c8af90950c5@gmail.com>
 <2q1nzdv6akhy5260mi-2nbzia-ttsfc8-dz76ft-4ifnnm-oz4kfp-uezs6vwoq2oq-wd0h34-v7m6m7-cd3muc-v4wzqd-yktmtp-2338r6riorqe-ez3yxk-8jr766yyjh0ob0v5e8-33h712k31w5b1ntkih.1553177522341@email.android.com>
 <6bd1f7e6-965b-3bd5-e4e0-f3b04e0638fd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------80DE380F34C2D28F4D8ADFB6"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <6bd1f7e6-965b-3bd5-e4e0-f3b04e0638fd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: christian.koenig-5C7GfCeVMHo@public.gmane.org, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Hector,
 Tobias" <Tobias.Hector-5C7GfCeVMHo@public.gmane.org>, "kbuild-all-JC7UmRfGjtg@public.gmane.org" <kbuild-all-JC7UmRfGjtg@public.gmane.org>, "jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org" <jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org>, "lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

--------------80DE380F34C2D28F4D8ADFB6
Content-Type: multipart/alternative;
	boundary="------------94B62DD2045ADD28BEED2540"

--------------94B62DD2045ADD28BEED2540
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

how about the attached?

If ok, I will merge to pathc#1.


-David


On 2019年03月21日 22:40, Christian König wrote:
> No, atomic cmpxchg is a hardware operation. If you want to replace 
> that you need a lock again.
>
> Maybe just add a comment and use an explicit cast to void* ? Not sure 
> if that silences the warning.
>
> Christian.
>
> Am 21.03.19 um 15:13 schrieb Zhou, David(ChunMing):
>> cmpxchg be replaced by some simple c sentance?
>> otherwise we have to remove __rcu of chian->prev.
>>
>> -David
>>
>> -------- Original Message --------
>> Subject: Re: [PATCH 1/9] dma-buf: add new dma_fence_chain container v6
>> From: Christian König
>> To: "Zhou, David(ChunMing)" ,kbuild test robot ,"Zhou, David(ChunMing)"
>> CC: 
>> kbuild-all-JC7UmRfGjtg@public.gmane.org,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org,"Koenig, 
>> Christian" ,"Hector, Tobias"
>>
>> Hi David,
>>
>> For the cmpxchg() case I of hand don't know either. Looks like so far
>> nobody has used cmpxchg() with rcu protected structures.
>>
>> The other cases should be replaced by RCU_INIT_POINTER() or
>> rcu_dereference_protected(.., true);
>>
>> Regards,
>> Christian.
>>
>> Am 21.03.19 um 07:34 schrieb zhoucm1:
>> > Hi Lionel and Christian,
>> >
>> > Below is robot report for chain->prev, which was added __rcu as you
>> > suggested.
>> >
>> > How to fix this line "tmp = cmpxchg(&chain->prev, prev, 
>> replacement); "?
>> > I checked kernel header file, seems it has no cmpxchg for rcu.
>> >
>> > Any suggestion to fix this robot report?
>> >
>> > Thanks,
>> > -David
>> >
>> > On 2019年03月21日 08:24, kbuild test robot wrote:
>> >> Hi Chunming,
>> >>
>> >> I love your patch! Perhaps something to improve:
>> >>
>> >> [auto build test WARNING on linus/master]
>> >> [also build test WARNING on v5.1-rc1 next-20190320]
>> >> [if your patch is applied to the wrong git tree, please drop us a
>> >> note to help improve the system]
>> >>
>> >> url:
>> >> 
>> https://github.com/0day-ci/linux/commits/Chunming-Zhou/dma-buf-add-new-dma_fence_chain-container-v6/20190320-223607
>> >> reproduce:
>> >>          # apt-get install sparse
>> >>          make ARCH=x86_64 allmodconfig
>> >>          make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>> >>
>> >>
>> >> sparse warnings: (new ones prefixed by >>)
>> >>
>> >>>> drivers/dma-buf/dma-fence-chain.c:73:23: sparse: incorrect type in
>> >>>> initializer (different address spaces) @@    expected struct
>> >>>> dma_fence [noderef] <asn:4>*__old @@    got  dma_fence [noderef]
>> >>>> <asn:4>*__old @@
>> >>     drivers/dma-buf/dma-fence-chain.c:73:23: expected struct
>> >> dma_fence [noderef] <asn:4>*__old
>> >>     drivers/dma-buf/dma-fence-chain.c:73:23: got struct dma_fence
>> >> *[assigned] prev
>> >>>> drivers/dma-buf/dma-fence-chain.c:73:23: sparse: incorrect type in
>> >>>> initializer (different address spaces) @@    expected struct
>> >>>> dma_fence [noderef] <asn:4>*__new @@    got  dma_fence [noderef]
>> >>>> <asn:4>*__new @@
>> >>     drivers/dma-buf/dma-fence-chain.c:73:23: expected struct
>> >> dma_fence [noderef] <asn:4>*__new
>> >>     drivers/dma-buf/dma-fence-chain.c:73:23: got struct dma_fence
>> >> *[assigned] replacement
>> >>>> drivers/dma-buf/dma-fence-chain.c:73:21: sparse: incorrect type in
>> >>>> assignment (different address spaces) @@    expected struct
>> >>>> dma_fence *tmp @@    got struct dma_fence [noderef] <struct
>> >>>> dma_fence *tmp @@
>> >>     drivers/dma-buf/dma-fence-chain.c:73:21: expected struct
>> >> dma_fence *tmp
>> >>     drivers/dma-buf/dma-fence-chain.c:73:21: got struct dma_fence
>> >> [noderef] <asn:4>*[assigned] __ret
>> >>>> drivers/dma-buf/dma-fence-chain.c:190:28: sparse: incorrect type in
>> >>>> argument 1 (different address spaces) @@    expected struct
>> >>>> dma_fence *fence @@    got struct dma_fence struct dma_fence 
>> *fence @@
>> >>     drivers/dma-buf/dma-fence-chain.c:190:28: expected struct
>> >> dma_fence *fence
>> >>     drivers/dma-buf/dma-fence-chain.c:190:28: got struct dma_fence
>> >> [noderef] <asn:4>*prev
>> >>>> drivers/dma-buf/dma-fence-chain.c:222:21: sparse: incorrect type in
>> >>>> assignment (different address spaces) @@    expected struct
>> >>>> dma_fence [noderef] <asn:4>*prev @@    got [noderef] <asn:4>*prev @@
>> >>     drivers/dma-buf/dma-fence-chain.c:222:21: expected struct
>> >> dma_fence [noderef] <asn:4>*prev
>> >>     drivers/dma-buf/dma-fence-chain.c:222:21: got struct dma_fence
>> >> *prev
>> >>     drivers/dma-buf/dma-fence-chain.c:235:33: sparse: expression
>> >> using sizeof(void)
>> >>     drivers/dma-buf/dma-fence-chain.c:235:33: sparse: expression
>> >> using sizeof(void)
>> >>
>> >> vim +73 drivers/dma-buf/dma-fence-chain.c
>> >>
>> >>      38
>> >>      39    /**
>> >>      40     * dma_fence_chain_walk - chain walking function
>> >>      41     * @fence: current chain node
>> >>      42     *
>> >>      43     * Walk the chain to the next node. Returns the next fence
>> >> or NULL if we are at
>> >>      44     * the end of the chain. Garbage collects chain nodes
>> >> which are already
>> >>      45     * signaled.
>> >>      46     */
>> >>      47    struct dma_fence *dma_fence_chain_walk(struct dma_fence
>> >> *fence)
>> >>      48    {
>> >>      49        struct dma_fence_chain *chain, *prev_chain;
>> >>      50        struct dma_fence *prev, *replacement, *tmp;
>> >>      51
>> >>      52        chain = to_dma_fence_chain(fence);
>> >>      53        if (!chain) {
>> >>      54            dma_fence_put(fence);
>> >>      55            return NULL;
>> >>      56        }
>> >>      57
>> >>      58        while ((prev = dma_fence_chain_get_prev(chain))) {
>> >>      59
>> >>      60            prev_chain = to_dma_fence_chain(prev);
>> >>      61            if (prev_chain) {
>> >>      62                if (!dma_fence_is_signaled(prev_chain->fence))
>> >>      63                    break;
>> >>      64
>> >>      65                replacement =
>> >> dma_fence_chain_get_prev(prev_chain);
>> >>      66            } else {
>> >>      67                if (!dma_fence_is_signaled(prev))
>> >>      68                    break;
>> >>      69
>> >>      70                replacement = NULL;
>> >>      71            }
>> >>      72
>> >>    > 73            tmp = cmpxchg(&chain->prev, prev, replacement);
>> >>      74            if (tmp == prev)
>> >>      75                dma_fence_put(tmp);
>> >>      76            else
>> >>      77 dma_fence_put(replacement);
>> >>      78            dma_fence_put(prev);
>> >>      79        }
>> >>      80
>> >>      81        dma_fence_put(fence);
>> >>      82        return prev;
>> >>      83    }
>> >>      84    EXPORT_SYMBOL(dma_fence_chain_walk);
>> >>      85
>> >>      86    /**
>> >>      87     * dma_fence_chain_find_seqno - find fence chain node by
>> >> seqno
>> >>      88     * @pfence: pointer to the chain node where to start
>> >>      89     * @seqno: the sequence number to search for
>> >>      90     *
>> >>      91     * Advance the fence pointer to the chain node which will
>> >> signal this sequence
>> >>      92     * number. If no sequence number is provided then this is
>> >> a no-op.
>> >>      93     *
>> >>      94     * Returns EINVAL if the fence is not a chain node or the
>> >> sequence number has
>> >>      95     * not yet advanced far enough.
>> >>      96     */
>> >>      97    int dma_fence_chain_find_seqno(struct dma_fence **pfence,
>> >> uint64_t seqno)
>> >>      98    {
>> >>      99        struct dma_fence_chain *chain;
>> >>     100
>> >>     101        if (!seqno)
>> >>     102            return 0;
>> >>     103
>> >>     104        chain = to_dma_fence_chain(*pfence);
>> >>     105        if (!chain || chain->base.seqno < seqno)
>> >>     106            return -EINVAL;
>> >>     107
>> >>     108        dma_fence_chain_for_each(*pfence, &chain->base) {
>> >>     109            if ((*pfence)->context != chain->base.context ||
>> >>     110 to_dma_fence_chain(*pfence)->prev_seqno < seqno)
>> >>     111                break;
>> >>     112        }
>> >>     113 dma_fence_put(&chain->base);
>> >>     114
>> >>     115        return 0;
>> >>     116    }
>> >>     117 EXPORT_SYMBOL(dma_fence_chain_find_seqno);
>> >>     118
>> >>     119    static const char *dma_fence_chain_get_driver_name(struct
>> >> dma_fence *fence)
>> >>     120    {
>> >>     121            return "dma_fence_chain";
>> >>     122    }
>> >>     123
>> >>     124    static const char
>> >> *dma_fence_chain_get_timeline_name(struct dma_fence *fence)
>> >>     125    {
>> >>     126            return "unbound";
>> >>     127    }
>> >>     128
>> >>     129    static void dma_fence_chain_irq_work(struct irq_work *work)
>> >>     130    {
>> >>     131        struct dma_fence_chain *chain;
>> >>     132
>> >>     133        chain = container_of(work, typeof(*chain), work);
>> >>     134
>> >>     135        /* Try to rearm the callback */
>> >>     136        if (!dma_fence_chain_enable_signaling(&chain->base))
>> >>     137            /* Ok, we are done. No more unsignaled fences 
>> left */
>> >>     138 dma_fence_signal(&chain->base);
>> >>     139 dma_fence_put(&chain->base);
>> >>     140    }
>> >>     141
>> >>     142    static void dma_fence_chain_cb(struct dma_fence *f, struct
>> >> dma_fence_cb *cb)
>> >>     143    {
>> >>     144        struct dma_fence_chain *chain;
>> >>     145
>> >>     146        chain = container_of(cb, typeof(*chain), cb);
>> >>     147 irq_work_queue(&chain->work);
>> >>     148        dma_fence_put(f);
>> >>     149    }
>> >>     150
>> >>     151    static bool dma_fence_chain_enable_signaling(struct
>> >> dma_fence *fence)
>> >>     152    {
>> >>     153        struct dma_fence_chain *head = 
>> to_dma_fence_chain(fence);
>> >>     154
>> >>     155        dma_fence_get(&head->base);
>> >>     156        dma_fence_chain_for_each(fence, &head->base) {
>> >>     157            struct dma_fence_chain *chain =
>> >> to_dma_fence_chain(fence);
>> >>     158            struct dma_fence *f = chain ? chain->fence : fence;
>> >>     159
>> >>     160            dma_fence_get(f);
>> >>     161            if (!dma_fence_add_callback(f, &head->cb,
>> >> dma_fence_chain_cb)) {
>> >>     162                dma_fence_put(fence);
>> >>     163                return true;
>> >>     164            }
>> >>     165            dma_fence_put(f);
>> >>     166        }
>> >>     167        dma_fence_put(&head->base);
>> >>     168        return false;
>> >>     169    }
>> >>     170
>> >>     171    static bool dma_fence_chain_signaled(struct dma_fence 
>> *fence)
>> >>     172    {
>> >>     173        dma_fence_chain_for_each(fence, fence) {
>> >>     174            struct dma_fence_chain *chain =
>> >> to_dma_fence_chain(fence);
>> >>     175            struct dma_fence *f = chain ? chain->fence : fence;
>> >>     176
>> >>     177            if (!dma_fence_is_signaled(f)) {
>> >>     178                dma_fence_put(fence);
>> >>     179                return false;
>> >>     180            }
>> >>     181        }
>> >>     182
>> >>     183        return true;
>> >>     184    }
>> >>     185
>> >>     186    static void dma_fence_chain_release(struct dma_fence 
>> *fence)
>> >>     187    {
>> >>     188        struct dma_fence_chain *chain =
>> >> to_dma_fence_chain(fence);
>> >>     189
>> >>   > 190        dma_fence_put(chain->prev);
>> >>     191        dma_fence_put(chain->fence);
>> >>     192        dma_fence_free(fence);
>> >>     193    }
>> >>     194
>> >>     195    const struct dma_fence_ops dma_fence_chain_ops = {
>> >>     196        .get_driver_name = dma_fence_chain_get_driver_name,
>> >>     197        .get_timeline_name = dma_fence_chain_get_timeline_name,
>> >>     198        .enable_signaling = dma_fence_chain_enable_signaling,
>> >>     199        .signaled = dma_fence_chain_signaled,
>> >>     200        .release = dma_fence_chain_release,
>> >>     201    };
>> >>     202    EXPORT_SYMBOL(dma_fence_chain_ops);
>> >>     203
>> >>     204    /**
>> >>     205     * dma_fence_chain_init - initialize a fence chain
>> >>     206     * @chain: the chain node to initialize
>> >>     207     * @prev: the previous fence
>> >>     208     * @fence: the current fence
>> >>     209     *
>> >>     210     * Initialize a new chain node and either start a new
>> >> chain or add the node to
>> >>     211     * the existing chain of the previous fence.
>> >>     212     */
>> >>     213    void dma_fence_chain_init(struct dma_fence_chain *chain,
>> >>     214                  struct dma_fence *prev,
>> >>     215                  struct dma_fence *fence,
>> >>     216                  uint64_t seqno)
>> >>     217    {
>> >>     218        struct dma_fence_chain *prev_chain =
>> >> to_dma_fence_chain(prev);
>> >>     219        uint64_t context;
>> >>     220
>> >>     221 spin_lock_init(&chain->lock);
>> >>   > 222        chain->prev = prev;
>> >>
>> >> ---
>> >> 0-DAY kernel test infrastructure Open Source
>> >> Technology Center
>> >> https://lists.01.org/pipermail/kbuild-all Intel Corporation
>> >
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------94B62DD2045ADD28BEED2540
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>how about the attached?</p>
    <p>If ok, I will merge to pathc#1.</p>
    <p><br>
    </p>
    <p>-David<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2019年03月21日 22:40, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:6bd1f7e6-965b-3bd5-e4e0-f3b04e0638fd-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div class="moz-cite-prefix">No, atomic cmpxchg is a hardware
        operation. If you want to replace that you need a lock again.<br>
        <br>
        Maybe just add a comment and use an explicit cast to void* ? Not
        sure if that silences the warning.<br>
        <br>
        Christian.<br>
        <br>
        Am 21.03.19 um 15:13 schrieb Zhou, David(ChunMing):<br>
      </div>
      <blockquote type="cite"
cite="mid:2q1nzdv6akhy5260mi-2nbzia-ttsfc8-dz76ft-4ifnnm-oz4kfp-uezs6vwoq2oq-wd0h34-v7m6m7-cd3muc-v4wzqd-yktmtp-2338r6riorqe-ez3yxk-8jr766yyjh0ob0v5e8-33h712k31w5b1ntkih.1553177522341-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
        <meta name="Generator" content="Microsoft Exchange Server">
        <!-- converted from text -->
        <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
        <div>cmpxchg be replaced by some simple c sentance?<br>
          otherwise we have to remove __rcu of chian-&gt;prev.<br>
          <br>
          -David<br>
          <br>
          -------- Original Message --------<br>
          Subject: Re: [PATCH 1/9] dma-buf: add new dma_fence_chain
          container v6<br>
          From: Christian König <br>
          To: "Zhou, David(ChunMing)" ,kbuild test robot ,"Zhou,
          David(ChunMing)" <br>
          CC:
          <a class="moz-txt-link-abbreviated"
href="mailto:kbuild-all-JC7UmRfGjtg@public.gmane.org,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org"
            moz-do-not-send="true">kbuild-all-JC7UmRfGjtg@public.gmane.org,dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org,lionel.g.landwerlin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,jason-fQELhIk9awXprZlt/sZkLg@public.gmane.org</a>,"Koenig,
          Christian" ,"Hector, Tobias" <br>
          <br>
        </div>
        <font size="2"><span style="font-size:11pt;">
            <div class="PlainText">Hi David,<br>
              <br>
              For the cmpxchg() case I of hand don't know either. Looks
              like so far <br>
              nobody has used cmpxchg() with rcu protected structures.<br>
              <br>
              The other cases should be replaced by RCU_INIT_POINTER()
              or <br>
              rcu_dereference_protected(.., true);<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 21.03.19 um 07:34 schrieb zhoucm1:<br>
              &gt; Hi Lionel and Christian,<br>
              &gt;<br>
              &gt; Below is robot report for chain-&gt;prev, which was
              added __rcu as you <br>
              &gt; suggested.<br>
              &gt;<br>
              &gt; How to fix this line "tmp =
              cmpxchg(&amp;chain-&gt;prev, prev, replacement); "?<br>
              &gt; I checked kernel header file, seems it has no cmpxchg
              for rcu.<br>
              &gt;<br>
              &gt; Any suggestion to fix this robot report?<br>
              &gt;<br>
              &gt; Thanks,<br>
              &gt; -David<br>
              &gt;<br>
              &gt; On 2019年03月21日 08:24, kbuild test robot wrote:<br>
              &gt;&gt; Hi Chunming,<br>
              &gt;&gt;<br>
              &gt;&gt; I love your patch! Perhaps something to improve:<br>
              &gt;&gt;<br>
              &gt;&gt; [auto build test WARNING on linus/master]<br>
              &gt;&gt; [also build test WARNING on v5.1-rc1
              next-20190320]<br>
              &gt;&gt; [if your patch is applied to the wrong git tree,
              please drop us a <br>
              &gt;&gt; note to help improve the system]<br>
              &gt;&gt;<br>
              &gt;&gt; url: <br>
              &gt;&gt; <a
href="https://github.com/0day-ci/linux/commits/Chunming-Zhou/dma-buf-add-new-dma_fence_chain-container-v6/20190320-223607"
                moz-do-not-send="true">
https://github.com/0day-ci/linux/commits/Chunming-Zhou/dma-buf-add-new-dma_fence_chain-container-v6/20190320-223607</a><br>
              &gt;&gt; reproduce:<br>
              &gt;&gt;          # apt-get install sparse<br>
              &gt;&gt;          make ARCH=x86_64 allmodconfig<br>
              &gt;&gt;          make C=1 CF='-fdiagnostic-prefix
              -D__CHECK_ENDIAN__'<br>
              &gt;&gt;<br>
              &gt;&gt;<br>
              &gt;&gt; sparse warnings: (new ones prefixed by &gt;&gt;)<br>
              &gt;&gt;<br>
              &gt;&gt;&gt;&gt; drivers/dma-buf/dma-fence-chain.c:73:23:
              sparse: incorrect type in <br>
              &gt;&gt;&gt;&gt; initializer (different address spaces)
              @@    expected struct <br>
              &gt;&gt;&gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*__old
              @@    got  dma_fence [noderef] <br>
              &gt;&gt;&gt;&gt; &lt;asn:4&gt;*__old @@<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:23:   
              expected struct <br>
              &gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*__old<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:23:   
              got struct dma_fence <br>
              &gt;&gt; *[assigned] prev<br>
              &gt;&gt;&gt;&gt; drivers/dma-buf/dma-fence-chain.c:73:23:
              sparse: incorrect type in <br>
              &gt;&gt;&gt;&gt; initializer (different address spaces)
              @@    expected struct <br>
              &gt;&gt;&gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*__new
              @@    got  dma_fence [noderef] <br>
              &gt;&gt;&gt;&gt; &lt;asn:4&gt;*__new @@<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:23:   
              expected struct <br>
              &gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*__new<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:23:   
              got struct dma_fence <br>
              &gt;&gt; *[assigned] replacement<br>
              &gt;&gt;&gt;&gt; drivers/dma-buf/dma-fence-chain.c:73:21:
              sparse: incorrect type in <br>
              &gt;&gt;&gt;&gt; assignment (different address spaces)
              @@    expected struct <br>
              &gt;&gt;&gt;&gt; dma_fence *tmp @@    got struct dma_fence
              [noderef] &lt;struct <br>
              &gt;&gt;&gt;&gt; dma_fence *tmp @@<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:21:   
              expected struct <br>
              &gt;&gt; dma_fence *tmp<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:73:21:   
              got struct dma_fence <br>
              &gt;&gt; [noderef] &lt;asn:4&gt;*[assigned] __ret<br>
              &gt;&gt;&gt;&gt; drivers/dma-buf/dma-fence-chain.c:190:28:
              sparse: incorrect type in <br>
              &gt;&gt;&gt;&gt; argument 1 (different address spaces)
              @@    expected struct <br>
              &gt;&gt;&gt;&gt; dma_fence *fence @@    got struct
              dma_fence struct dma_fence *fence @@<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:190:28:   
              expected struct <br>
              &gt;&gt; dma_fence *fence<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:190:28:   
              got struct dma_fence <br>
              &gt;&gt; [noderef] &lt;asn:4&gt;*prev<br>
              &gt;&gt;&gt;&gt; drivers/dma-buf/dma-fence-chain.c:222:21:
              sparse: incorrect type in <br>
              &gt;&gt;&gt;&gt; assignment (different address spaces)
              @@    expected struct <br>
              &gt;&gt;&gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*prev
              @@    got [noderef] &lt;asn:4&gt;*prev @@<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:222:21:   
              expected struct <br>
              &gt;&gt; dma_fence [noderef] &lt;asn:4&gt;*prev<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:222:21:   
              got struct dma_fence <br>
              &gt;&gt; *prev<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:235:33:
              sparse: expression <br>
              &gt;&gt; using sizeof(void)<br>
              &gt;&gt;     drivers/dma-buf/dma-fence-chain.c:235:33:
              sparse: expression <br>
              &gt;&gt; using sizeof(void)<br>
              &gt;&gt;<br>
              &gt;&gt; vim +73 drivers/dma-buf/dma-fence-chain.c<br>
              &gt;&gt;<br>
              &gt;&gt;      38<br>
              &gt;&gt;      39    /**<br>
              &gt;&gt;      40     * dma_fence_chain_walk - chain
              walking function<br>
              &gt;&gt;      41     * @fence: current chain node<br>
              &gt;&gt;      42     *<br>
              &gt;&gt;      43     * Walk the chain to the next node.
              Returns the next fence <br>
              &gt;&gt; or NULL if we are at<br>
              &gt;&gt;      44     * the end of the chain. Garbage
              collects chain nodes <br>
              &gt;&gt; which are already<br>
              &gt;&gt;      45     * signaled.<br>
              &gt;&gt;      46     */<br>
              &gt;&gt;      47    struct dma_fence
              *dma_fence_chain_walk(struct dma_fence <br>
              &gt;&gt; *fence)<br>
              &gt;&gt;      48    {<br>
              &gt;&gt;      49        struct dma_fence_chain *chain,
              *prev_chain;<br>
              &gt;&gt;      50        struct dma_fence *prev,
              *replacement, *tmp;<br>
              &gt;&gt;      51<br>
              &gt;&gt;      52        chain = to_dma_fence_chain(fence);<br>
              &gt;&gt;      53        if (!chain) {<br>
              &gt;&gt;      54            dma_fence_put(fence);<br>
              &gt;&gt;      55            return NULL;<br>
              &gt;&gt;      56        }<br>
              &gt;&gt;      57<br>
              &gt;&gt;      58        while ((prev =
              dma_fence_chain_get_prev(chain))) {<br>
              &gt;&gt;      59<br>
              &gt;&gt;      60            prev_chain =
              to_dma_fence_chain(prev);<br>
              &gt;&gt;      61            if (prev_chain) {<br>
              &gt;&gt;      62                if
              (!dma_fence_is_signaled(prev_chain-&gt;fence))<br>
              &gt;&gt;      63                    break;<br>
              &gt;&gt;      64<br>
              &gt;&gt;      65                replacement = <br>
              &gt;&gt; dma_fence_chain_get_prev(prev_chain);<br>
              &gt;&gt;      66            } else {<br>
              &gt;&gt;      67                if
              (!dma_fence_is_signaled(prev))<br>
              &gt;&gt;      68                    break;<br>
              &gt;&gt;      69<br>
              &gt;&gt;      70                replacement = NULL;<br>
              &gt;&gt;      71            }<br>
              &gt;&gt;      72<br>
              &gt;&gt;    &gt; 73            tmp =
              cmpxchg(&amp;chain-&gt;prev, prev, replacement);<br>
              &gt;&gt;      74            if (tmp == prev)<br>
              &gt;&gt;      75                dma_fence_put(tmp);<br>
              &gt;&gt;      76            else<br>
              &gt;&gt;      77               
              dma_fence_put(replacement);<br>
              &gt;&gt;      78            dma_fence_put(prev);<br>
              &gt;&gt;      79        }<br>
              &gt;&gt;      80<br>
              &gt;&gt;      81        dma_fence_put(fence);<br>
              &gt;&gt;      82        return prev;<br>
              &gt;&gt;      83    }<br>
              &gt;&gt;      84    EXPORT_SYMBOL(dma_fence_chain_walk);<br>
              &gt;&gt;      85<br>
              &gt;&gt;      86    /**<br>
              &gt;&gt;      87     * dma_fence_chain_find_seqno - find
              fence chain node by <br>
              &gt;&gt; seqno<br>
              &gt;&gt;      88     * @pfence: pointer to the chain node
              where to start<br>
              &gt;&gt;      89     * @seqno: the sequence number to
              search for<br>
              &gt;&gt;      90     *<br>
              &gt;&gt;      91     * Advance the fence pointer to the
              chain node which will <br>
              &gt;&gt; signal this sequence<br>
              &gt;&gt;      92     * number. If no sequence number is
              provided then this is <br>
              &gt;&gt; a no-op.<br>
              &gt;&gt;      93     *<br>
              &gt;&gt;      94     * Returns EINVAL if the fence is not
              a chain node or the <br>
              &gt;&gt; sequence number has<br>
              &gt;&gt;      95     * not yet advanced far enough.<br>
              &gt;&gt;      96     */<br>
              &gt;&gt;      97    int dma_fence_chain_find_seqno(struct
              dma_fence **pfence, <br>
              &gt;&gt; uint64_t seqno)<br>
              &gt;&gt;      98    {<br>
              &gt;&gt;      99        struct dma_fence_chain *chain;<br>
              &gt;&gt;     100<br>
              &gt;&gt;     101        if (!seqno)<br>
              &gt;&gt;     102            return 0;<br>
              &gt;&gt;     103<br>
              &gt;&gt;     104        chain =
              to_dma_fence_chain(*pfence);<br>
              &gt;&gt;     105        if (!chain || chain-&gt;base.seqno
              &lt; seqno)<br>
              &gt;&gt;     106            return -EINVAL;<br>
              &gt;&gt;     107<br>
              &gt;&gt;     108        dma_fence_chain_for_each(*pfence,
              &amp;chain-&gt;base) {<br>
              &gt;&gt;     109            if ((*pfence)-&gt;context !=
              chain-&gt;base.context ||<br>
              &gt;&gt;     110
              to_dma_fence_chain(*pfence)-&gt;prev_seqno &lt; seqno)<br>
              &gt;&gt;     111                break;<br>
              &gt;&gt;     112        }<br>
              &gt;&gt;     113       
              dma_fence_put(&amp;chain-&gt;base);<br>
              &gt;&gt;     114<br>
              &gt;&gt;     115        return 0;<br>
              &gt;&gt;     116    }<br>
              &gt;&gt;     117   
              EXPORT_SYMBOL(dma_fence_chain_find_seqno);<br>
              &gt;&gt;     118<br>
              &gt;&gt;     119    static const char
              *dma_fence_chain_get_driver_name(struct <br>
              &gt;&gt; dma_fence *fence)<br>
              &gt;&gt;     120    {<br>
              &gt;&gt;     121            return "dma_fence_chain";<br>
              &gt;&gt;     122    }<br>
              &gt;&gt;     123<br>
              &gt;&gt;     124    static const char <br>
              &gt;&gt; *dma_fence_chain_get_timeline_name(struct
              dma_fence *fence)<br>
              &gt;&gt;     125    {<br>
              &gt;&gt;     126            return "unbound";<br>
              &gt;&gt;     127    }<br>
              &gt;&gt;     128<br>
              &gt;&gt;     129    static void
              dma_fence_chain_irq_work(struct irq_work *work)<br>
              &gt;&gt;     130    {<br>
              &gt;&gt;     131        struct dma_fence_chain *chain;<br>
              &gt;&gt;     132<br>
              &gt;&gt;     133        chain = container_of(work,
              typeof(*chain), work);<br>
              &gt;&gt;     134<br>
              &gt;&gt;     135        /* Try to rearm the callback */<br>
              &gt;&gt;     136        if
              (!dma_fence_chain_enable_signaling(&amp;chain-&gt;base))<br>
              &gt;&gt;     137            /* Ok, we are done. No more
              unsignaled fences left */<br>
              &gt;&gt;     138           
              dma_fence_signal(&amp;chain-&gt;base);<br>
              &gt;&gt;     139       
              dma_fence_put(&amp;chain-&gt;base);<br>
              &gt;&gt;     140    }<br>
              &gt;&gt;     141<br>
              &gt;&gt;     142    static void dma_fence_chain_cb(struct
              dma_fence *f, struct <br>
              &gt;&gt; dma_fence_cb *cb)<br>
              &gt;&gt;     143    {<br>
              &gt;&gt;     144        struct dma_fence_chain *chain;<br>
              &gt;&gt;     145<br>
              &gt;&gt;     146        chain = container_of(cb,
              typeof(*chain), cb);<br>
              &gt;&gt;     147       
              irq_work_queue(&amp;chain-&gt;work);<br>
              &gt;&gt;     148        dma_fence_put(f);<br>
              &gt;&gt;     149    }<br>
              &gt;&gt;     150<br>
              &gt;&gt;     151    static bool
              dma_fence_chain_enable_signaling(struct <br>
              &gt;&gt; dma_fence *fence)<br>
              &gt;&gt;     152    {<br>
              &gt;&gt;     153        struct dma_fence_chain *head =
              to_dma_fence_chain(fence);<br>
              &gt;&gt;     154<br>
              &gt;&gt;     155        dma_fence_get(&amp;head-&gt;base);<br>
              &gt;&gt;     156        dma_fence_chain_for_each(fence,
              &amp;head-&gt;base) {<br>
              &gt;&gt;     157            struct dma_fence_chain *chain
              = <br>
              &gt;&gt; to_dma_fence_chain(fence);<br>
              &gt;&gt;     158            struct dma_fence *f = chain ?
              chain-&gt;fence : fence;<br>
              &gt;&gt;     159<br>
              &gt;&gt;     160            dma_fence_get(f);<br>
              &gt;&gt;     161            if (!dma_fence_add_callback(f,
              &amp;head-&gt;cb, <br>
              &gt;&gt; dma_fence_chain_cb)) {<br>
              &gt;&gt;     162                dma_fence_put(fence);<br>
              &gt;&gt;     163                return true;<br>
              &gt;&gt;     164            }<br>
              &gt;&gt;     165            dma_fence_put(f);<br>
              &gt;&gt;     166        }<br>
              &gt;&gt;     167        dma_fence_put(&amp;head-&gt;base);<br>
              &gt;&gt;     168        return false;<br>
              &gt;&gt;     169    }<br>
              &gt;&gt;     170<br>
              &gt;&gt;     171    static bool
              dma_fence_chain_signaled(struct dma_fence *fence)<br>
              &gt;&gt;     172    {<br>
              &gt;&gt;     173        dma_fence_chain_for_each(fence,
              fence) {<br>
              &gt;&gt;     174            struct dma_fence_chain *chain
              = <br>
              &gt;&gt; to_dma_fence_chain(fence);<br>
              &gt;&gt;     175            struct dma_fence *f = chain ?
              chain-&gt;fence : fence;<br>
              &gt;&gt;     176<br>
              &gt;&gt;     177            if (!dma_fence_is_signaled(f))
              {<br>
              &gt;&gt;     178                dma_fence_put(fence);<br>
              &gt;&gt;     179                return false;<br>
              &gt;&gt;     180            }<br>
              &gt;&gt;     181        }<br>
              &gt;&gt;     182<br>
              &gt;&gt;     183        return true;<br>
              &gt;&gt;     184    }<br>
              &gt;&gt;     185<br>
              &gt;&gt;     186    static void
              dma_fence_chain_release(struct dma_fence *fence)<br>
              &gt;&gt;     187    {<br>
              &gt;&gt;     188        struct dma_fence_chain *chain = <br>
              &gt;&gt; to_dma_fence_chain(fence);<br>
              &gt;&gt;     189<br>
              &gt;&gt;   &gt; 190        dma_fence_put(chain-&gt;prev);<br>
              &gt;&gt;     191        dma_fence_put(chain-&gt;fence);<br>
              &gt;&gt;     192        dma_fence_free(fence);<br>
              &gt;&gt;     193    }<br>
              &gt;&gt;     194<br>
              &gt;&gt;     195    const struct dma_fence_ops
              dma_fence_chain_ops = {<br>
              &gt;&gt;     196        .get_driver_name =
              dma_fence_chain_get_driver_name,<br>
              &gt;&gt;     197        .get_timeline_name =
              dma_fence_chain_get_timeline_name,<br>
              &gt;&gt;     198        .enable_signaling =
              dma_fence_chain_enable_signaling,<br>
              &gt;&gt;     199        .signaled =
              dma_fence_chain_signaled,<br>
              &gt;&gt;     200        .release =
              dma_fence_chain_release,<br>
              &gt;&gt;     201    };<br>
              &gt;&gt;     202    EXPORT_SYMBOL(dma_fence_chain_ops);<br>
              &gt;&gt;     203<br>
              &gt;&gt;     204    /**<br>
              &gt;&gt;     205     * dma_fence_chain_init - initialize a
              fence chain<br>
              &gt;&gt;     206     * @chain: the chain node to
              initialize<br>
              &gt;&gt;     207     * @prev: the previous fence<br>
              &gt;&gt;     208     * @fence: the current fence<br>
              &gt;&gt;     209     *<br>
              &gt;&gt;     210     * Initialize a new chain node and
              either start a new <br>
              &gt;&gt; chain or add the node to<br>
              &gt;&gt;     211     * the existing chain of the previous
              fence.<br>
              &gt;&gt;     212     */<br>
              &gt;&gt;     213    void dma_fence_chain_init(struct
              dma_fence_chain *chain,<br>
              &gt;&gt;     214                  struct dma_fence *prev,<br>
              &gt;&gt;     215                  struct dma_fence *fence,<br>
              &gt;&gt;     216                  uint64_t seqno)<br>
              &gt;&gt;     217    {<br>
              &gt;&gt;     218        struct dma_fence_chain *prev_chain
              = <br>
              &gt;&gt; to_dma_fence_chain(prev);<br>
              &gt;&gt;     219        uint64_t context;<br>
              &gt;&gt;     220<br>
              &gt;&gt;     221       
              spin_lock_init(&amp;chain-&gt;lock);<br>
              &gt;&gt;   &gt; 222        chain-&gt;prev = prev;<br>
              &gt;&gt;<br>
              &gt;&gt; ---<br>
              &gt;&gt; 0-DAY kernel test infrastructure               
              Open Source <br>
              &gt;&gt; Technology Center<br>
              &gt;&gt; <a
                href="https://lists.01.org/pipermail/kbuild-all"
                moz-do-not-send="true">https://lists.01.org/pipermail/kbuild-all</a>
              Intel Corporation<br>
              &gt;<br>
              <br>
            </div>
          </span></font> <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
      </blockquote>
      <br>
    </blockquote>
    <br>
  </body>
</html>

--------------94B62DD2045ADD28BEED2540--

--------------80DE380F34C2D28F4D8ADFB6
Content-Type: text/x-patch;
	name="0001-fix-rcu-warning-from-kernel-robot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-fix-rcu-warning-from-kernel-robot.patch"

>From 0cb7171b2a99b425323a8e02a968c9488de29608 Mon Sep 17 00:00:00 2001
From: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Date: Fri, 22 Mar 2019 15:33:01 +0800
Subject: [PATCH] fix rcu warning from kernel robot

Signed-off-by: Chunming Zhou <david1.zhou-5C7GfCeVMHo@public.gmane.org>
---
 drivers/dma-buf/dma-fence-chain.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-chain.c b/drivers/dma-buf/dma-fence-chain.c
index 0c5e3c902fa0..c729f98a7bd3 100644
--- a/drivers/dma-buf/dma-fence-chain.c
+++ b/drivers/dma-buf/dma-fence-chain.c
@@ -70,7 +70,7 @@ struct dma_fence *dma_fence_chain_walk(struct dma_fence *fence)
 			replacement = NULL;
 		}
 
-		tmp = cmpxchg(&chain->prev, prev, replacement);
+		tmp = cmpxchg((void **)&chain->prev, (void *)prev, (void *)replacement);
 		if (tmp == prev)
 			dma_fence_put(tmp);
 		else
@@ -187,7 +187,7 @@ static void dma_fence_chain_release(struct dma_fence *fence)
 {
 	struct dma_fence_chain *chain = to_dma_fence_chain(fence);
 
-	dma_fence_put(chain->prev);
+	dma_fence_put(rcu_dereference_protected(chain->prev, true));
 	dma_fence_put(chain->fence);
 	dma_fence_free(fence);
 }
@@ -219,7 +219,7 @@ void dma_fence_chain_init(struct dma_fence_chain *chain,
 	uint64_t context;
 
 	spin_lock_init(&chain->lock);
-	chain->prev = prev;
+	rcu_assign_pointer(chain->prev, prev);
 	chain->fence = fence;
 	chain->prev_seqno = 0;
 	init_irq_work(&chain->work, dma_fence_chain_irq_work);
-- 
2.17.1


--------------80DE380F34C2D28F4D8ADFB6
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------80DE380F34C2D28F4D8ADFB6--
